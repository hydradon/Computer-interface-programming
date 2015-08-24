/*
 * ass2.c
 *
 *  Created on: Mar 10, 2014
 *      Author: VuNgocQuang
 */

#include <stdio.h>

#include "lpc17xx_pinsel.h"
#include "lpc17xx_gpio.h"
#include "lpc17xx_i2c.h"
#include "lpc17xx_ssp.h"
#include "lpc17xx_timer.h"

#include "function.h"

int main (void) {

	/* ---- Speaker ------> */

	GPIO_SetDir(0, 1<<27, 1); 	// Set P0.27 (PIO3_0) as Output
	GPIO_SetDir(0, 1<<28, 1); 	// Set P0.28 (PIO3_1) as Output
	GPIO_SetDir(2, 1<<13, 1); 	// Set P2.13 (PIO3_2) as Output

	//Input to PWM LP filter
	GPIO_SetDir(0, 1<<26, 1); 	// Set P0.26 (PIO1_2) as Output
	GPIO_ClearValue(0, 1<<27); 	//Clear P0.27 (PIO3_0) connected to CLK of LM4811
	GPIO_ClearValue(0, 1<<28); 	//Clear P0.28 (PIO3_1) connected to UP/DN of LM4811
	GPIO_ClearValue(2, 1<<13); 	//Clear P2.13 (PIO3_2) connected to SHUTDN of LM4811

	/* ---- Speaker ------> */


	init_SW4();

	uint8_t btn3 = 1;
	init_SW3();
	//Enable Interrupt on P2.10
	LPC_GPIOINT->IO2IntEnF = 1<<10;
	//Enable EINT0 interrupt
	NVIC_Enable(EINT3_IRQn);
}
