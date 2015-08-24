/*
 * main.c
 *
 *  Created on: Mar 10, 2014
 *      Author: VuNgocQuang & YosuaAmadeusSusanto
 */

#include <stdio.h>
#include <string.h>

#include "LPC17xx.h"
#include "lpc17xx_i2c.h"
#include "lpc17xx_pinsel.h"
#include "lpc17xx_gpio.h"
#include "lpc17xx_ssp.h"
#include "lpc17xx_timer.h"
#include "lpc17xx_uart.h"

#include "joystick.h"
#include "pca9532.h"
#include "acc.h"
#include "oled.h"
#include "rgb.h"
#include "temp.h"
#include "light.h"
#include "led7seg.h"

#define NOTE_PIN_HIGH() GPIO_SetValue(0, 1<<26);
#define NOTE_PIN_LOW()  GPIO_ClearValue(0, 1<<26);
#define TEMP_STANDARD 400
#define LUX_STANDARD 800
#define TIME_WINDOW 3000
#define REPORTING_TIME 1000

typedef enum
{
    HOT,
    NORMAL
} temp_range_t;

typedef enum
{
    RISKY,
    SAFE
} lux_range_t;

volatile uint32_t msTicks=0; // counter for 1ms SysTicks
static int32_t zoff = 0;

static int8_t x = 0;
static int8_t y = 0;
static int8_t z = 0;


uint8_t standbyFlag = 0;
uint8_t calibrationFlag = 0;
uint8_t activeFlag = 0;
uint8_t lightFlag = 0;
uint8_t warningFlag = 0;
uint8_t standbyMode = 0;
uint8_t calibrationMode = 0;
uint8_t handshakeFlag = 0;
uint8_t RACK_flag = 0;
uint8_t receiveUART3 = 0;

uint8_t btn3 = 1;
uint8_t btn4 = 1;
uint8_t UNSAFE_LOWER = 2;
uint8_t UNSAFE_UPPER = 10;


// variable to display on UART
static char* msg = NULL;
static char report[20] = "";
static char data = 0;
uint32_t len = 0;
uint8_t line[20];

static int curTemp=0;
static temp_range_t curTempCondition;

static uint32_t curLux=100;
static lux_range_t curLuxCondition;

static uint8_t oledInt[10];
static uint8_t oledString[50];

static uint32_t getMsTicks(void)
{
	return msTicks;
}

//  SysTick_Handler - just increment SysTick counter
void SysTick_Handler(void) {
  msTicks++;

  //if (UART_GetLineStatus(LPC_UART3) & UART_LINESTAT_RDR){
  if (LPC_UART3->LSR & UART_LSR_RDR){
	  UART_Receive(LPC_UART3, &data, 1, BLOCKING);

	  if (data != '\r')
	  {
	  	len++;
	  	line[len-1] = data;
	  }
	  else
	  {
	  	data = '\n';
	  	len = 0;
	  	receiveUART3 = 1;
	  }
  }
}

// systick_delay - creates a delay of the appropriate number of Systicks (happens every 1 ms)
__INLINE static void systick_delay (uint32_t delayTicks) {
  uint32_t currentTicks;

  currentTicks = msTicks;	// read current tick counter
  // Now loop until required number of ticks passes
  while ((msTicks - currentTicks) < delayTicks);
}

void EINT0_IRQHandler(void)
// function button SW3 interrupt
{
	if ((LPC_GPIOINT -> IO2IntStatF>>10)& 0x1) {
		if (calibrationFlag==0) {
			calibrationFlag=1;
			led7seg_setChar(48, FALSE);
		}
		LPC_GPIOINT -> IO2IntClr = 1<<10;
	}
	LPC_SC -> EXTINT |= 1<<0;

	return;
}

void EINT3_IRQHandler(void)
{
	if (calibrationMode == 0)
	{
		// light sensor interrupt
		if ((LPC_GPIOINT -> IO2IntStatF>>5)& 0x1)
		{
			//lightFlag = 1;
			standbyFlag = 1;
			LPC_GPIOINT -> IO2IntClr = 1<<5;
		}
	}
    return;
}

static inline char *stringFromTemp(temp_range_t t)
{
    static const char *strings[] = { "HOT", "NORMAL"};

    return strings[t];
}

static inline char *stringFromLux(lux_range_t lux)
{
    static const char *strings[] = { "RISKY", "SAFE"};

    return strings[lux];
}

static temp_range_t isTempNormal(uint32_t temp)
{
	if (temp >= TEMP_STANDARD)
	{
		return HOT;
	} else {
		return NORMAL;
	}
}

static lux_range_t isLuxNormal(uint32_t lux){
	if (lux >= LUX_STANDARD)
	{
		return RISKY;
	} else {
		return SAFE;
	}
}

void pinsel_uart3(void)
// initialize UART pins
{
	PINSEL_CFG_Type PinCfg;
	// Initialize UART function
	PinCfg.Funcnum = 2;
	PinCfg.Portnum = 0;
	PinCfg.Pinnum = 0;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 1;
	PINSEL_ConfigPin(&PinCfg);

	return;
}

void init_uart(void)
// initialize UART configuration
{
	UART_CFG_Type uartCfg;
	uartCfg.Baud_rate = 115200;
	uartCfg.Databits = UART_DATABIT_8;
	uartCfg.Parity = UART_PARITY_NONE;
	uartCfg.Stopbits = UART_STOPBIT_1;

	pinsel_uart3();
	UART_Init(LPC_UART3, &uartCfg);
	UART_TxCmd(LPC_UART3, ENABLE);

	return;
}

static void init_ssp(void)
{
	SSP_CFG_Type SSP_ConfigStruct;
	PINSEL_CFG_Type PinCfg;

	/*
	 * Initialize SPI pin connect
	 * P0.7 - SCK;
	 * P0.8 - MISO
	 * P0.9 - MOSI
	 * P2.2 - SSEL - used as GPIO
	 */
	PinCfg.Funcnum = 2;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 0;
	PinCfg.Pinnum = 7;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 8;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 9;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Funcnum = 0;
	PinCfg.Portnum = 2;
	PinCfg.Pinnum = 2;
	PINSEL_ConfigPin(&PinCfg);

	SSP_ConfigStructInit(&SSP_ConfigStruct);

	// Initialize SSP peripheral with parameter given in structure above
	SSP_Init(LPC_SSP1, &SSP_ConfigStruct);

	// Enable SSP peripheral
	SSP_Cmd(LPC_SSP1, ENABLE);

	return;
}

static void init_i2c(void)
{
	PINSEL_CFG_Type PinCfg;

	/* Initialize I2C2 pin connect */
	PinCfg.Funcnum = 2;
	PinCfg.OpenDrain = 1;
	PinCfg.Pinnum = 10;
	PinCfg.Portnum = 0;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 11;
	PINSEL_ConfigPin(&PinCfg);

	// Initialize I2C peripheral
	I2C_Init(LPC_I2C2, 100000);

	/* Enable I2C1 operation */
	I2C_Cmd(LPC_I2C2, ENABLE);
}

static void init_GPIO(void)
{
	PINSEL_CFG_Type PinCfg;
	// Initialize button SW3
	PinCfg.Funcnum = 1;  //01 -- EINT0 bar (set as interupt)
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 2;
	PinCfg.Pinnum = 10;
	PINSEL_ConfigPin(&PinCfg);
	//Port 2, bit 10, 0~input <- set FIO2DIR
	GPIO_SetDir (2, 1<<10, 0);

	// Initialize button SW4
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 1;
	PinCfg.Pinnum = 31;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(1, (1<<31), 0);

	// Initialize light sensor interrupt
	PinCfg.Pinnum = 5;
	PinCfg.Portnum = 2;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Funcnum = 0; //(Normal GPIO)
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(2, (1<<5), 0);
}

static void resetFlag(void)
{
	calibrationFlag = 0;
	standbyFlag = 0;
	activeFlag = 0;

	return;
}

float calcMeanOfFive()
{
	int i=0, sum=0;
	for (i=1; i<=5; i++)
	{
		light_shutdown();
		acc_read(&x, &y, &z);
		light_enable();
		z-=zoff;
		sum+=z;
	}
	return sum/5.0;
}

static uint8_t isFreqSafe(uint32_t freq){
	if (freq < UNSAFE_LOWER || freq > UNSAFE_UPPER){
		return 1;
	}
	else
	{
		return 0;
	}
}

static uint32_t notes[] = {
        2272, // A - 440 Hz
        2024, // B - 494 Hz
        3816, // C - 262 Hz
        3401, // D - 294 Hz
        3030, // E - 330 Hz
        2865, // F - 349 Hz
        2551, // G - 392 Hz
        1136, // a - 880 Hz
        1012, // b - 988 Hz
        1912, // c - 523 Hz
        1703, // d - 587 Hz
        1517, // e - 659 Hz
        1432, // f - 698 Hz
        1275, // g - 784 Hz
};

static void playNote(uint32_t note, uint32_t durationMs) {

    uint32_t t = 0;

    if (note > 0) {

        while (t < (durationMs*1000)) {
            NOTE_PIN_HIGH();
            Timer0_us_Wait(note / 2);
            //delay32Us(0, note / 2);

            NOTE_PIN_LOW();
            Timer0_us_Wait(note / 2);
            //delay32Us(0, note / 2);

            t += note;
        }

    }
    else {
    	Timer0_Wait(durationMs);
        //delay32Ms(0, durationMs);
    }
}

static void turnOnWarning(void)
{
	pca9532_setLeds (0xFFFF, 0);
	rgb_setLeds(0x01);
	playNote(4500, 400);
}

static void turnOffWarning(void)
{
	pca9532_setLeds (0x0, 0xFFFF);
	rgb_setLeds(0x0);
}

static void initializeAll(void)
{
	int j=0;
	for (j=0;j<=3;j++)
	{
		line[j]='\0';
	}

	resetFlag();
	init_ssp();
	init_i2c();
	init_GPIO();
	init_uart();

	acc_init(); 					//init accelerometer
	oled_init(); 					//init oled display
	rgb_init();  					//init rgb LED
	led7seg_init();					//init  7 segment display
	led7seg_setChar(48, FALSE);
	light_init();
	light_enable();					//init light sensor
	// set the range and interrupt
	light_setRange(LIGHT_RANGE_16000);
	light_clearIrqStatus();
	light_setHiThreshold(800);
	light_setLoThreshold(0);

	// Setup SysTick Timer to interrupt at 1 msec intervals
	SysTick_Config(SystemCoreClock / 1000);

	temp_init(getMsTicks);			//init temperature sensor

	/* ---- Speaker ------> */
	GPIO_SetDir(0, 1<<27, 1); 	// Set P0.27 (PIO3_0) as Output
	GPIO_SetDir(0, 1<<28, 1); 	// Set P0.28 (PIO3_1) as Output
	GPIO_SetDir(2, 1<<13, 1); 	// Set P2.13 (PIO3_2) as Output

	GPIO_SetDir(2, 1<<0, 1);
	GPIO_SetDir(2, 1<<1, 1);

	//Input to PWM LP filter
	GPIO_SetDir(0, 1<<26, 1); 	// Set P0.26 (PIO1_2) as Output

	GPIO_ClearValue(0, 1<<27); 	//Clear P0.27 (PIO3_0) connected to CLK of LM4811
	GPIO_ClearValue(0, 1<<28); 	//Clear P0.28 (PIO3_1) connected to UP/DN of LM4811
	GPIO_ClearValue(2, 1<<13); 	//Clear P2.13 (PIO3_2) connected to SHUTDN of LM4811
	/* ---- Speaker ------> */

	/* ---- Interrupts ------> */
	// Enable GPIO interrupt P2.10 (sw3)
	LPC_GPIOINT->IO2IntEnF |= 1<<10;
	// Enable GPIO interrupt P2.5 (light sensor)
	LPC_GPIOINT->IO2IntEnF |= 1<<5;

	// Enable EINT0/3_interrupt
	NVIC_EnableIRQ(EINT0_IRQn);
	NVIC_EnableIRQ(EINT3_IRQn);


//	set priority levels
	uint32_t ans, PG = 5, PP = 0b0, SP = 0b0;
	NVIC_SetPriorityGrouping(5);
	ans = NVIC_EncodePriority(PG,PP,SP);
	NVIC_SetPriority(EINT0_IRQn, ans);
	PP = 0b01;
	ans = NVIC_EncodePriority(PG,PP,SP);
	NVIC_SetPriority(EINT3_IRQn, ans);
	/* ---- Interrupts ------> */
}

static void calibration(void)
{
	if (warningFlag){
		turnOffWarning();
		warningFlag = 0;
	}

	calibrationMode = 1;
	led7seg_setChar(48, FALSE);
	oled_clearScreen(OLED_COLOR_WHITE);
    acc_setMode(ACC_MODE_MEASURE);
	oled_putString(0x0, 0x0, "CALIBRATION      \n", OLED_COLOR_WHITE, OLED_COLOR_BLACK);


    while (standbyFlag == 0)
	{
    	light_shutdown();
    	acc_read(&x, &y, &z);
    	light_enable();

	    sprintf(oledInt, "Accel =       ");
	    oled_putString(0x0, 0x21, oledInt, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
	    sprintf(oledInt, "Accel = %d", z);
	    oled_putString(0x0, 0x21, oledInt, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

	    btn4 = (GPIO_ReadValue(1) >> 31) & 0x01;
	    if (btn4 == 0)
	    {
	    	zoff = z;
	    	standbyFlag=1;
	    }
	}
    calibrationMode = 0;
	return;
}

/*----------------------------------------extra feature----------------------------------------*/
static char commandParser(uint8_t input[20])
{
	if (input[0] == 'L' && input[1] == 'O')
	{
		return 'L';
	}
	else if (input[0] == 'H' && input[1] == 'I')
	{
		return 'H';
	} else return 0;
}

static uint32_t getNumberFromCommand(char input[20])
{
	if (input[2] < '0' || input [2] > '9')
	{
		return -1;
	}
	else if (input[3] < '0' || input [3] > '9')
	{
		return input[2] - 48;
	}
	else
	{
		printf("%d %d\n", input[2], input[3]);
		return (input[2]-48) * 10 + (input[3]-48);
	}
}
/*----------------------------------------extra feature----------------------------------------*/

static void standby(void)
{
	turnOffWarning();
	standbyMode = 1;
	oled_clearScreen(OLED_COLOR_WHITE);
	acc_setMode(ACC_MODE_STANDBY);
	oled_putString(0x0, 0x0, "STANDBY                     ", OLED_COLOR_WHITE, OLED_COLOR_BLACK);

	int i=53, j=0;
	uint32_t currTicks = 0;

	while (i >= 48 && calibrationFlag == 0)
	{
		led7seg_setChar(i, FALSE);
		i--;
		systick_delay(1000);
		currTicks=msTicks;

		if (RACK_flag == 0 && handshakeFlag == 0){
			msg = "RDY 051\r\n";
			UART_Send(LPC_UART3, (uint8_t *)msg, strlen(msg), BLOCKING);

			printf("i: %d\n", receiveUART3);

			if(receiveUART3)
			{
				if (strcmp(line, "RACK") == 0)
				{
					msg = "HSHK 051\r\n";
					if (handshakeFlag == 0){
						UART_Send(LPC_UART3, (uint8_t *)msg, strlen(msg), BLOCKING);
						handshakeFlag = 1;
					}
					RACK_flag = 1;
				}

				for (j=0;j<=19;j++)
				{
					line[j]='\0';
				}

				receiveUART3 = 0;
			}
		}
	}

	while(calibrationFlag == 0 && activeFlag == 0)
	{
		if (receiveUART3)
		{
			if (strcmp(line, "RSTC") == 0)
			{
				msg = "CACK\r\n";
				UART_Send(LPC_UART3, (uint8_t *)msg, strlen(msg), BLOCKING);
				calibrationFlag = 1;
			}
			if (strcmp(line, "RACK") == 0)
			{
				msg = "HSHK 051\r\n";
				if (handshakeFlag == 0){
					UART_Send(LPC_UART3, (uint8_t *)msg, strlen(msg), BLOCKING);
					handshakeFlag = 1;
				}
				RACK_flag = 1;
			}

			for (j=0;j<=19;j++)
			{
				line[j]='\0';
			}

			receiveUART3 = 0;
		}


		curTemp = temp_read();
		curLux = light_read();

		curTempCondition = isTempNormal(curTemp);
		curLuxCondition = isLuxNormal(curLux);

		sprintf(oledString, "Temp is           ");
		oled_putString(0x0, 0x11, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
		sprintf(oledString, "Temp is %s\n", stringFromTemp(curTempCondition));
		oled_putString(0x0, 0x11, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

		sprintf(oledString, "Rad is           ");
		oled_putString(0x0, 0x21, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
		sprintf(oledString, "Rad is %s\n", stringFromLux(curLuxCondition));
		oled_putString(0x0, 0x21, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

		sprintf(oledString, "Temp is           ");
		oled_putString(0x0, 0x31, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
		sprintf(oledInt, "Temp = %.2f\n", curTemp/10.00);
		oled_putString(0x0, 0x31, oledInt, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

		if ((strcmp(stringFromTemp(curTempCondition),"NORMAL")==0) &&
				(strcmp(stringFromLux(curLuxCondition),"SAFE")==0) && handshakeFlag == 1)
		{
			activeFlag = 1;
		}
	}
	standbyMode = 0;
	return;
}

static void active(void)
{
	int j=0;
	uint8_t freqInt=0;
	uint32_t prevFreq=0;
	uint32_t currTime;
	uint8_t timeWindowCounter = 0;
	float freq=0, mean=0, prevMean=0;

	oled_clearScreen(OLED_COLOR_WHITE);
    acc_setMode(ACC_MODE_MEASURE);
	oled_putString(0x0, 0x0, "ACTIVE                ", OLED_COLOR_WHITE, OLED_COLOR_BLACK);

	while (calibrationFlag == 0 && standbyFlag == 0)
	{
		curTemp = temp_read();
		acc_setMode(ACC_MODE_STANDBY);
		curLux = light_read();
		acc_setMode(ACC_MODE_MEASURE);

		curTempCondition = isTempNormal(curTemp);
		curLuxCondition = isLuxNormal(curLux);

		if ((strcmp(stringFromTemp(curTempCondition),"HOT")==0) ||
				(strcmp(stringFromLux(curLuxCondition),"RISKY")==0))
		{
			standbyFlag = 1;
			break;
		}

		sprintf(oledString, "Temp is         ");
		oled_putString(0x0, 0x11, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
		sprintf(oledString, "Temp is %s\n", stringFromTemp(curTempCondition));
		oled_putString(0x0, 0x11, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

		sprintf(oledString, "Rad is       ");
		oled_putString(0x0, 0x21, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
		sprintf(oledString, "Rad is %s\n", stringFromLux(curLuxCondition));
		oled_putString(0x0, 0x21, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

		currTime = msTicks;
		freq = 0;
		while (msTicks <= currTime + REPORTING_TIME)
		{
			mean = calcMeanOfFive();
			if ((prevMean>0 && mean<0) || (prevMean<0 && mean>0))
			{
				freq+=0.5;
			}
			if (mean != 0)
			{
				prevMean = mean;
			}
		}

		if (warningFlag == 0)
		{
			if ((isFreqSafe(prevFreq) && !isFreqSafe(freq)) || (isFreqSafe(prevFreq) && isFreqSafe(freq)))
			{
				timeWindowCounter = 0;
			}
			else if (!isFreqSafe(prevFreq) && !isFreqSafe(freq))
			{
				timeWindowCounter++;
			}
		}
		else if (warningFlag == 1)
		{
			if ((!isFreqSafe(prevFreq) && isFreqSafe(freq)) || (!isFreqSafe(prevFreq) && !isFreqSafe(freq)))
			{
				timeWindowCounter = 0;
			}
			else if (isFreqSafe(prevFreq) && isFreqSafe(freq))
			{
				timeWindowCounter++;
			}
		}

		if (timeWindowCounter == 3) {
			warningFlag = !warningFlag;
		}
		prevFreq = freq;

		sprintf(oledString, "Freq is        ");
		oled_putString(0x0, 0x31, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);
		sprintf(oledString, "Freq is %.1f\n", freq);
		oled_putString(0x0, 0x31, oledString, OLED_COLOR_BLACK, OLED_COLOR_WHITE);

		if (warningFlag == 1)
		{
			turnOnWarning();
			sprintf(report, "REPT 051 %02d WARNING\r\n", (int)freq);
			UART_Send(LPC_UART3, (uint8_t *)report, strlen(report), BLOCKING);

		}
		else
		if (warningFlag == 0)
		{
			turnOffWarning();
			sprintf(report, "REPT 051 %02d\r\n", (int)freq);
			UART_Send(LPC_UART3, (uint8_t *)report, strlen(report), BLOCKING);
		}


		if (receiveUART3)
		{
			if (strcmp(line, "RSTC") == 0)
			{
				msg = "CACK\r\n";
				UART_Send(LPC_UART3, (uint8_t *)msg, strlen(msg), BLOCKING);
				calibrationFlag = 1;
			}
			else if (strcmp(line, "RSTS") == 0)
			{
				msg = "SACK\r\n";
				UART_Send(LPC_UART3, (uint8_t *)msg, strlen(msg), BLOCKING);
				standbyFlag = 1;
			}

/*----------------------------------------extra feature----------------------------------------*/
			else if(commandParser(line) == 'L' && (getNumberFromCommand(line) != -1))
			{
				if (getNumberFromCommand(line) < UNSAFE_UPPER)
				{
					UNSAFE_LOWER = getNumberFromCommand(line);
				}
				printf("unsafe lower: %d\n", UNSAFE_LOWER);
			}
			else if(commandParser(line) == 'H' && (getNumberFromCommand(line) != -1))
			{
				if (getNumberFromCommand(line) > UNSAFE_LOWER)
				{
					UNSAFE_UPPER = getNumberFromCommand(line);
				}
				printf("unsafe upper: %d\n", UNSAFE_UPPER);
			}
/*----------------------------------------extra feature----------------------------------------*/

			for (j=0;j<=19;j++)
			{
				line[j]='\0';
			}

			receiveUART3 = 0;
		}
	}
	return;
}

int main (void) {
	initializeAll();
	resetFlag();
	calibration();
	while (1)
	{
		if (calibrationFlag == 1)
		{
			resetFlag();
			calibration();
		}
		if (standbyFlag == 1)
		{
			resetFlag();
			standby();
		}
		if (activeFlag == 1)
		{
			resetFlag();
			active();
		}
	}
}

void check_failed(uint8_t *file, uint32_t line)
{
	/* User can add his own implementation to report the file name and line number,
	 ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

	/* Infinite loop */
	while(1);
}

