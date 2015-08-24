   1              		.syntax unified
   2              		.cpu cortex-m3
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 18, 4
  12              		.thumb
  13              		.file	"cr_startup_lpc17.c"
  23              	.Ltext0:
  24              		.file 1 "../src/cr_startup_lpc17.c"
 1247              		.align	2
 1250              	g_pfnVectors:
 1251 0000 00000000 		.word	_vStackTop
 1252 0004 00000000 		.word	ResetISR
 1253 0008 00000000 		.word	NMI_Handler
 1254 000c 00000000 		.word	HardFault_Handler
 1255 0010 00000000 		.word	MemManage_Handler
 1256 0014 00000000 		.word	BusFault_Handler
 1257 0018 00000000 		.word	UsageFault_Handler
 1258 001c 00000000 		.word	0
 1259 0020 00000000 		.word	0
 1260 0024 00000000 		.word	0
 1261 0028 00000000 		.word	0
 1262 002c 00000000 		.word	SVCall_Handler
 1263 0030 00000000 		.word	DebugMon_Handler
 1264 0034 00000000 		.word	0
 1265 0038 00000000 		.word	PendSV_Handler
 1266 003c 00000000 		.word	SysTick_Handler
 1267 0040 00000000 		.word	WDT_IRQHandler
 1268 0044 00000000 		.word	TIMER0_IRQHandler
 1269 0048 00000000 		.word	TIMER1_IRQHandler
 1270 004c 00000000 		.word	TIMER2_IRQHandler
 1271 0050 00000000 		.word	TIMER3_IRQHandler
 1272 0054 00000000 		.word	UART0_IRQHandler
 1273 0058 00000000 		.word	UART1_IRQHandler
 1274 005c 00000000 		.word	UART2_IRQHandler
 1275 0060 00000000 		.word	UART3_IRQHandler
 1276 0064 00000000 		.word	PWM1_IRQHandler
 1277 0068 00000000 		.word	I2C0_IRQHandler
 1278 006c 00000000 		.word	I2C1_IRQHandler
 1279 0070 00000000 		.word	I2C2_IRQHandler
 1280 0074 00000000 		.word	SPI_IRQHandler
 1281 0078 00000000 		.word	SSP0_IRQHandler
 1282 007c 00000000 		.word	SSP1_IRQHandler
 1283 0080 00000000 		.word	PLL0_IRQHandler
 1284 0084 00000000 		.word	RTC_IRQHandler
 1285 0088 00000000 		.word	EINT0_IRQHandler
 1286 008c 00000000 		.word	EINT1_IRQHandler
 1287 0090 00000000 		.word	EINT2_IRQHandler
 1288 0094 00000000 		.word	EINT3_IRQHandler
 1289 0098 00000000 		.word	ADC_IRQHandler
 1290 009c 00000000 		.word	BOD_IRQHandler
 1291 00a0 00000000 		.word	USB_IRQHandler
 1292 00a4 00000000 		.word	CAN_IRQHandler
 1293 00a8 00000000 		.word	DMA_IRQHandler
 1294 00ac 00000000 		.word	I2S_IRQHandler
 1295 00b0 00000000 		.word	ENET_IRQHandler
 1296 00b4 00000000 		.word	RIT_IRQHandler
 1297 00b8 00000000 		.word	MCPWM_IRQHandler
 1298 00bc 00000000 		.word	QEI_IRQHandler
 1299 00c0 00000000 		.word	PLL1_IRQHandler
 1300 00c4 00000000 		.word	USBActivity_IRQHandler
 1301 00c8 00000000 		.word	CANActivity_IRQHandler
 1302              		.section	.text.ResetISR,"ax",%progbits
 1303              		.align	2
 1304              		.global	ResetISR
 1305              		.thumb
 1306              		.thumb_func
 1308              	ResetISR:
 1309              	.LFB2:
   1:../src/cr_startup_lpc17.c **** //*****************************************************************************
   2:../src/cr_startup_lpc17.c **** //   +--+       
   3:../src/cr_startup_lpc17.c **** //   | ++----+   
   4:../src/cr_startup_lpc17.c **** //   +-++    |  
   5:../src/cr_startup_lpc17.c **** //     |     |  
   6:../src/cr_startup_lpc17.c **** //   +-+--+  |   
   7:../src/cr_startup_lpc17.c **** //   | +--+--+  
   8:../src/cr_startup_lpc17.c **** //   +----+    Copyright (c) 2009-10 Code Red Technologies Ltd.
   9:../src/cr_startup_lpc17.c **** //
  10:../src/cr_startup_lpc17.c **** // Microcontroller Startup code for use with Red Suite
  11:../src/cr_startup_lpc17.c **** //
  12:../src/cr_startup_lpc17.c **** // Software License Agreement
  13:../src/cr_startup_lpc17.c **** // 
  14:../src/cr_startup_lpc17.c **** // The software is owned by Code Red Technologies and/or its suppliers, and is 
  15:../src/cr_startup_lpc17.c **** // protected under applicable copyright laws.  All rights are reserved.  Any 
  16:../src/cr_startup_lpc17.c **** // use in violation of the foregoing restrictions may subject the user to criminal 
  17:../src/cr_startup_lpc17.c **** // sanctions under applicable laws, as well as to civil liability for the breach 
  18:../src/cr_startup_lpc17.c **** // of the terms and conditions of this license.
  19:../src/cr_startup_lpc17.c **** // 
  20:../src/cr_startup_lpc17.c **** // THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
  21:../src/cr_startup_lpc17.c **** // OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
  22:../src/cr_startup_lpc17.c **** // MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
  23:../src/cr_startup_lpc17.c **** // USE OF THIS SOFTWARE FOR COMMERCIAL DEVELOPMENT AND/OR EDUCATION IS SUBJECT
  24:../src/cr_startup_lpc17.c **** // TO A CURRENT END USER LICENSE AGREEMENT (COMMERCIAL OR EDUCATIONAL) WITH
  25:../src/cr_startup_lpc17.c **** // CODE RED TECHNOLOGIES LTD. 
  26:../src/cr_startup_lpc17.c **** //
  27:../src/cr_startup_lpc17.c **** //*****************************************************************************
  28:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
  29:../src/cr_startup_lpc17.c **** #ifdef __REDLIB__
  30:../src/cr_startup_lpc17.c **** #error Redlib does not support C++
  31:../src/cr_startup_lpc17.c **** #else
  32:../src/cr_startup_lpc17.c **** //*****************************************************************************
  33:../src/cr_startup_lpc17.c **** //
  34:../src/cr_startup_lpc17.c **** // The entry point for the C++ library startup
  35:../src/cr_startup_lpc17.c **** //
  36:../src/cr_startup_lpc17.c **** //*****************************************************************************
  37:../src/cr_startup_lpc17.c **** extern "C" {
  38:../src/cr_startup_lpc17.c **** 	extern void __libc_init_array(void);
  39:../src/cr_startup_lpc17.c **** }
  40:../src/cr_startup_lpc17.c **** #endif
  41:../src/cr_startup_lpc17.c **** #endif
  42:../src/cr_startup_lpc17.c **** 
  43:../src/cr_startup_lpc17.c **** #define WEAK __attribute__ ((weak))
  44:../src/cr_startup_lpc17.c **** #define ALIAS(f) __attribute__ ((weak, alias (#f)))
  45:../src/cr_startup_lpc17.c **** 
  46:../src/cr_startup_lpc17.c **** // Code Red - if CMSIS is being used, then SystemInit() routine
  47:../src/cr_startup_lpc17.c **** // will be called by startup code rather than in application's main()
  48:../src/cr_startup_lpc17.c **** #if defined (__USE_CMSIS)
  49:../src/cr_startup_lpc17.c **** #include "system_LPC17xx.h"
  50:../src/cr_startup_lpc17.c **** #endif
  51:../src/cr_startup_lpc17.c **** 
  52:../src/cr_startup_lpc17.c **** //*****************************************************************************
  53:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
  54:../src/cr_startup_lpc17.c **** extern "C" {
  55:../src/cr_startup_lpc17.c **** #endif
  56:../src/cr_startup_lpc17.c **** 
  57:../src/cr_startup_lpc17.c **** //*****************************************************************************
  58:../src/cr_startup_lpc17.c **** //
  59:../src/cr_startup_lpc17.c **** // Forward declaration of the default handlers. These are aliased.
  60:../src/cr_startup_lpc17.c **** // When the application defines a handler (with the same name), this will 
  61:../src/cr_startup_lpc17.c **** // automatically take precedence over these weak definitions
  62:../src/cr_startup_lpc17.c **** //
  63:../src/cr_startup_lpc17.c **** //*****************************************************************************
  64:../src/cr_startup_lpc17.c ****      void ResetISR(void);
  65:../src/cr_startup_lpc17.c **** WEAK void NMI_Handler(void);
  66:../src/cr_startup_lpc17.c **** WEAK void HardFault_Handler(void);
  67:../src/cr_startup_lpc17.c **** WEAK void MemManage_Handler(void);
  68:../src/cr_startup_lpc17.c **** WEAK void BusFault_Handler(void);
  69:../src/cr_startup_lpc17.c **** WEAK void UsageFault_Handler(void);
  70:../src/cr_startup_lpc17.c **** WEAK void SVCall_Handler(void);
  71:../src/cr_startup_lpc17.c **** WEAK void DebugMon_Handler(void);
  72:../src/cr_startup_lpc17.c **** WEAK void PendSV_Handler(void);
  73:../src/cr_startup_lpc17.c **** WEAK void SysTick_Handler(void);
  74:../src/cr_startup_lpc17.c **** WEAK void IntDefaultHandler(void);
  75:../src/cr_startup_lpc17.c **** 
  76:../src/cr_startup_lpc17.c **** //*****************************************************************************
  77:../src/cr_startup_lpc17.c **** //
  78:../src/cr_startup_lpc17.c **** // Forward declaration of the specific IRQ handlers. These are aliased
  79:../src/cr_startup_lpc17.c **** // to the IntDefaultHandler, which is a 'forever' loop. When the application
  80:../src/cr_startup_lpc17.c **** // defines a handler (with the same name), this will automatically take 
  81:../src/cr_startup_lpc17.c **** // precedence over these weak definitions
  82:../src/cr_startup_lpc17.c **** //
  83:../src/cr_startup_lpc17.c **** //*****************************************************************************
  84:../src/cr_startup_lpc17.c **** void WDT_IRQHandler(void) ALIAS(IntDefaultHandler);
  85:../src/cr_startup_lpc17.c **** void TIMER0_IRQHandler(void) ALIAS(IntDefaultHandler);
  86:../src/cr_startup_lpc17.c **** void TIMER1_IRQHandler(void) ALIAS(IntDefaultHandler);
  87:../src/cr_startup_lpc17.c **** void TIMER2_IRQHandler(void) ALIAS(IntDefaultHandler);
  88:../src/cr_startup_lpc17.c **** void TIMER3_IRQHandler(void) ALIAS(IntDefaultHandler);
  89:../src/cr_startup_lpc17.c **** void UART0_IRQHandler(void) ALIAS(IntDefaultHandler);
  90:../src/cr_startup_lpc17.c **** void UART1_IRQHandler(void) ALIAS(IntDefaultHandler);
  91:../src/cr_startup_lpc17.c **** void UART2_IRQHandler(void) ALIAS(IntDefaultHandler);
  92:../src/cr_startup_lpc17.c **** void UART3_IRQHandler(void) ALIAS(IntDefaultHandler);
  93:../src/cr_startup_lpc17.c **** void PWM1_IRQHandler(void) ALIAS(IntDefaultHandler);
  94:../src/cr_startup_lpc17.c **** void I2C0_IRQHandler(void) ALIAS(IntDefaultHandler);
  95:../src/cr_startup_lpc17.c **** void I2C1_IRQHandler(void) ALIAS(IntDefaultHandler);
  96:../src/cr_startup_lpc17.c **** void I2C2_IRQHandler(void) ALIAS(IntDefaultHandler);
  97:../src/cr_startup_lpc17.c **** void SPI_IRQHandler(void) ALIAS(IntDefaultHandler);
  98:../src/cr_startup_lpc17.c **** void SSP0_IRQHandler(void) ALIAS(IntDefaultHandler);
  99:../src/cr_startup_lpc17.c **** void SSP1_IRQHandler(void) ALIAS(IntDefaultHandler);
 100:../src/cr_startup_lpc17.c **** void PLL0_IRQHandler(void) ALIAS(IntDefaultHandler);
 101:../src/cr_startup_lpc17.c **** void RTC_IRQHandler(void) ALIAS(IntDefaultHandler);
 102:../src/cr_startup_lpc17.c **** void EINT0_IRQHandler(void) ALIAS(IntDefaultHandler);
 103:../src/cr_startup_lpc17.c **** void EINT1_IRQHandler(void) ALIAS(IntDefaultHandler);
 104:../src/cr_startup_lpc17.c **** void EINT2_IRQHandler(void) ALIAS(IntDefaultHandler);
 105:../src/cr_startup_lpc17.c **** void EINT3_IRQHandler(void) ALIAS(IntDefaultHandler);
 106:../src/cr_startup_lpc17.c **** void ADC_IRQHandler(void) ALIAS(IntDefaultHandler);
 107:../src/cr_startup_lpc17.c **** void BOD_IRQHandler(void) ALIAS(IntDefaultHandler);
 108:../src/cr_startup_lpc17.c **** void USB_IRQHandler(void) ALIAS(IntDefaultHandler);
 109:../src/cr_startup_lpc17.c **** void CAN_IRQHandler(void) ALIAS(IntDefaultHandler);
 110:../src/cr_startup_lpc17.c **** void DMA_IRQHandler(void) ALIAS(IntDefaultHandler);
 111:../src/cr_startup_lpc17.c **** void I2S_IRQHandler(void) ALIAS(IntDefaultHandler);
 112:../src/cr_startup_lpc17.c **** void ENET_IRQHandler(void) ALIAS(IntDefaultHandler);
 113:../src/cr_startup_lpc17.c **** void RIT_IRQHandler(void) ALIAS(IntDefaultHandler);
 114:../src/cr_startup_lpc17.c **** void MCPWM_IRQHandler(void) ALIAS(IntDefaultHandler);
 115:../src/cr_startup_lpc17.c **** void QEI_IRQHandler(void) ALIAS(IntDefaultHandler);
 116:../src/cr_startup_lpc17.c **** void PLL1_IRQHandler(void) ALIAS(IntDefaultHandler);
 117:../src/cr_startup_lpc17.c **** void USBActivity_IRQHandler(void) ALIAS(IntDefaultHandler);
 118:../src/cr_startup_lpc17.c **** void CANActivity_IRQHandler(void) ALIAS(IntDefaultHandler);
 119:../src/cr_startup_lpc17.c **** 
 120:../src/cr_startup_lpc17.c **** //*****************************************************************************
 121:../src/cr_startup_lpc17.c **** //
 122:../src/cr_startup_lpc17.c **** // The entry point for the application.
 123:../src/cr_startup_lpc17.c **** // __main() is the entry point for Redlib based applications
 124:../src/cr_startup_lpc17.c **** // main() is the entry point for Newlib based applications
 125:../src/cr_startup_lpc17.c **** //
 126:../src/cr_startup_lpc17.c **** //*****************************************************************************
 127:../src/cr_startup_lpc17.c **** #if defined (__REDLIB__)
 128:../src/cr_startup_lpc17.c **** extern void __main(void);
 129:../src/cr_startup_lpc17.c **** #endif
 130:../src/cr_startup_lpc17.c **** extern int main(void);
 131:../src/cr_startup_lpc17.c **** //*****************************************************************************
 132:../src/cr_startup_lpc17.c **** //
 133:../src/cr_startup_lpc17.c **** // External declaration for the pointer to the stack top from the Linker Script
 134:../src/cr_startup_lpc17.c **** //
 135:../src/cr_startup_lpc17.c **** //*****************************************************************************
 136:../src/cr_startup_lpc17.c **** extern void _vStackTop(void);
 137:../src/cr_startup_lpc17.c **** 
 138:../src/cr_startup_lpc17.c **** //*****************************************************************************
 139:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
 140:../src/cr_startup_lpc17.c **** } // extern "C"
 141:../src/cr_startup_lpc17.c **** #endif
 142:../src/cr_startup_lpc17.c **** //*****************************************************************************
 143:../src/cr_startup_lpc17.c **** //
 144:../src/cr_startup_lpc17.c **** // The vector table.
 145:../src/cr_startup_lpc17.c **** // This relies on the linker script to place at correct location in memory.
 146:../src/cr_startup_lpc17.c **** //
 147:../src/cr_startup_lpc17.c **** //*****************************************************************************
 148:../src/cr_startup_lpc17.c **** extern void (* const g_pfnVectors[])(void);
 149:../src/cr_startup_lpc17.c **** __attribute__ ((section(".isr_vector")))
 150:../src/cr_startup_lpc17.c **** void (* const g_pfnVectors[])(void) = {
 151:../src/cr_startup_lpc17.c **** 	// Core Level - CM3
 152:../src/cr_startup_lpc17.c **** 	&_vStackTop, // The initial stack pointer
 153:../src/cr_startup_lpc17.c **** 	ResetISR,								// The reset handler
 154:../src/cr_startup_lpc17.c **** 	NMI_Handler,							// The NMI handler
 155:../src/cr_startup_lpc17.c **** 	HardFault_Handler,						// The hard fault handler
 156:../src/cr_startup_lpc17.c **** 	MemManage_Handler,						// The MPU fault handler
 157:../src/cr_startup_lpc17.c **** 	BusFault_Handler,						// The bus fault handler
 158:../src/cr_startup_lpc17.c **** 	UsageFault_Handler,						// The usage fault handler
 159:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 160:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 161:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 162:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 163:../src/cr_startup_lpc17.c **** 	SVCall_Handler,							// SVCall handler
 164:../src/cr_startup_lpc17.c **** 	DebugMon_Handler,						// Debug monitor handler
 165:../src/cr_startup_lpc17.c **** 	0,										// Reserved
 166:../src/cr_startup_lpc17.c **** 	PendSV_Handler,							// The PendSV handler
 167:../src/cr_startup_lpc17.c **** 	SysTick_Handler,						// The SysTick handler
 168:../src/cr_startup_lpc17.c **** 
 169:../src/cr_startup_lpc17.c **** 	// Chip Level - LPC17
 170:../src/cr_startup_lpc17.c **** 	WDT_IRQHandler,							// 16, 0x40 - WDT
 171:../src/cr_startup_lpc17.c **** 	TIMER0_IRQHandler,						// 17, 0x44 - TIMER0
 172:../src/cr_startup_lpc17.c **** 	TIMER1_IRQHandler,						// 18, 0x48 - TIMER1
 173:../src/cr_startup_lpc17.c **** 	TIMER2_IRQHandler,						// 19, 0x4c - TIMER2
 174:../src/cr_startup_lpc17.c **** 	TIMER3_IRQHandler,						// 20, 0x50 - TIMER3
 175:../src/cr_startup_lpc17.c **** 	UART0_IRQHandler,						// 21, 0x54 - UART0
 176:../src/cr_startup_lpc17.c **** 	UART1_IRQHandler,						// 22, 0x58 - UART1
 177:../src/cr_startup_lpc17.c **** 	UART2_IRQHandler,						// 23, 0x5c - UART2
 178:../src/cr_startup_lpc17.c **** 	UART3_IRQHandler,						// 24, 0x60 - UART3
 179:../src/cr_startup_lpc17.c **** 	PWM1_IRQHandler,						// 25, 0x64 - PWM1
 180:../src/cr_startup_lpc17.c **** 	I2C0_IRQHandler,						// 26, 0x68 - I2C0
 181:../src/cr_startup_lpc17.c **** 	I2C1_IRQHandler,						// 27, 0x6c - I2C1
 182:../src/cr_startup_lpc17.c **** 	I2C2_IRQHandler,						// 28, 0x70 - I2C2
 183:../src/cr_startup_lpc17.c **** 	SPI_IRQHandler,							// 29, 0x74 - SPI
 184:../src/cr_startup_lpc17.c **** 	SSP0_IRQHandler,						// 30, 0x78 - SSP0
 185:../src/cr_startup_lpc17.c **** 	SSP1_IRQHandler,						// 31, 0x7c - SSP1
 186:../src/cr_startup_lpc17.c **** 	PLL0_IRQHandler,						// 32, 0x80 - PLL0 (Main PLL)
 187:../src/cr_startup_lpc17.c **** 	RTC_IRQHandler,							// 33, 0x84 - RTC
 188:../src/cr_startup_lpc17.c **** 	EINT0_IRQHandler,						// 34, 0x88 - EINT0
 189:../src/cr_startup_lpc17.c **** 	EINT1_IRQHandler,						// 35, 0x8c - EINT1
 190:../src/cr_startup_lpc17.c **** 	EINT2_IRQHandler,						// 36, 0x90 - EINT2
 191:../src/cr_startup_lpc17.c **** 	EINT3_IRQHandler,						// 37, 0x94 - EINT3
 192:../src/cr_startup_lpc17.c **** 	ADC_IRQHandler,							// 38, 0x98 - ADC
 193:../src/cr_startup_lpc17.c **** 	BOD_IRQHandler,							// 39, 0x9c - BOD
 194:../src/cr_startup_lpc17.c **** 	USB_IRQHandler,							// 40, 0xA0 - USB
 195:../src/cr_startup_lpc17.c **** 	CAN_IRQHandler,							// 41, 0xa4 - CAN
 196:../src/cr_startup_lpc17.c **** 	DMA_IRQHandler,							// 42, 0xa8 - GP DMA
 197:../src/cr_startup_lpc17.c **** 	I2S_IRQHandler,							// 43, 0xac - I2S
 198:../src/cr_startup_lpc17.c **** 	ENET_IRQHandler,						// 44, 0xb0 - Ethernet
 199:../src/cr_startup_lpc17.c **** 	RIT_IRQHandler,							// 45, 0xb4 - RITINT
 200:../src/cr_startup_lpc17.c **** 	MCPWM_IRQHandler,						// 46, 0xb8 - Motor Control PWM
 201:../src/cr_startup_lpc17.c **** 	QEI_IRQHandler,							// 47, 0xbc - Quadrature Encoder
 202:../src/cr_startup_lpc17.c **** 	PLL1_IRQHandler,						// 48, 0xc0 - PLL1 (USB PLL)
 203:../src/cr_startup_lpc17.c **** 	USBActivity_IRQHandler,					// 49, 0xc4 - USB Activity interrupt to wakeup
 204:../src/cr_startup_lpc17.c **** 	CANActivity_IRQHandler, 				// 50, 0xc8 - CAN Activity interrupt to wakeup
 205:../src/cr_startup_lpc17.c **** };
 206:../src/cr_startup_lpc17.c **** 
 207:../src/cr_startup_lpc17.c **** //*****************************************************************************
 208:../src/cr_startup_lpc17.c **** //
 209:../src/cr_startup_lpc17.c **** // The following are constructs created by the linker, indicating where the
 210:../src/cr_startup_lpc17.c **** // the "data" and "bss" segments reside in memory.  The initializers for the
 211:../src/cr_startup_lpc17.c **** // for the "data" segment resides immediately following the "text" segment.
 212:../src/cr_startup_lpc17.c **** //
 213:../src/cr_startup_lpc17.c **** //*****************************************************************************
 214:../src/cr_startup_lpc17.c **** extern unsigned long _etext;
 215:../src/cr_startup_lpc17.c **** extern unsigned long _data;
 216:../src/cr_startup_lpc17.c **** extern unsigned long _edata;
 217:../src/cr_startup_lpc17.c **** extern unsigned long _bss;
 218:../src/cr_startup_lpc17.c **** extern unsigned long _ebss;
 219:../src/cr_startup_lpc17.c **** 
 220:../src/cr_startup_lpc17.c **** //*****************************************************************************
 221:../src/cr_startup_lpc17.c **** // Reset entry point for your code.
 222:../src/cr_startup_lpc17.c **** // Sets up a simple runtime environment and initializes the C/C++
 223:../src/cr_startup_lpc17.c **** // library.
 224:../src/cr_startup_lpc17.c **** //
 225:../src/cr_startup_lpc17.c **** //*****************************************************************************
 226:../src/cr_startup_lpc17.c **** void
 227:../src/cr_startup_lpc17.c **** ResetISR(void) {
 1310              		.loc 1 227 0
 1311              		@ args = 0, pretend = 0, frame = 8
 1312              		@ frame_needed = 1, uses_anonymous_args = 0
 1313 0000 80B5     		push	{r7, lr}
 1314              	.LCFI0:
 1315 0002 82B0     		sub	sp, sp, #8
 1316              	.LCFI1:
 1317 0004 00AF     		add	r7, sp, #0
 1318              	.LCFI2:
 228:../src/cr_startup_lpc17.c ****     unsigned long *pulSrc, *pulDest;
 229:../src/cr_startup_lpc17.c **** 
 230:../src/cr_startup_lpc17.c ****     //
 231:../src/cr_startup_lpc17.c ****     // Copy the data segment initializers from flash to SRAM.
 232:../src/cr_startup_lpc17.c ****     //
 233:../src/cr_startup_lpc17.c ****     pulSrc = &_etext;
 1319              		.loc 1 233 0
 1320 0006 40F20003 		movw	r3, #:lower16:_etext
 1321 000a C0F20003 		movt	r3, #:upper16:_etext
 1322 000e 3B60     		str	r3, [r7, #0]
 234:../src/cr_startup_lpc17.c ****     for(pulDest = &_data; pulDest < &_edata; )
 1323              		.loc 1 234 0
 1324 0010 40F20003 		movw	r3, #:lower16:_data
 1325 0014 C0F20003 		movt	r3, #:upper16:_data
 1326 0018 7B60     		str	r3, [r7, #4]
 1327 001a 0BE0     		b	.L2
 1328              	.L3:
 235:../src/cr_startup_lpc17.c ****     {
 236:../src/cr_startup_lpc17.c ****         *pulDest++ = *pulSrc++;
 1329              		.loc 1 236 0
 1330 001c 3B68     		ldr	r3, [r7, #0]
 1331 001e 1A68     		ldr	r2, [r3, #0]
 1332 0020 7B68     		ldr	r3, [r7, #4]
 1333 0022 1A60     		str	r2, [r3, #0]
 1334 0024 7B68     		ldr	r3, [r7, #4]
 1335 0026 03F10403 		add	r3, r3, #4
 1336 002a 7B60     		str	r3, [r7, #4]
 1337 002c 3B68     		ldr	r3, [r7, #0]
 1338 002e 03F10403 		add	r3, r3, #4
 1339 0032 3B60     		str	r3, [r7, #0]
 1340              	.L2:
 1341              		.loc 1 234 0
 1342 0034 7A68     		ldr	r2, [r7, #4]
 1343 0036 40F20003 		movw	r3, #:lower16:_edata
 1344 003a C0F20003 		movt	r3, #:upper16:_edata
 1345 003e 9A42     		cmp	r2, r3
 1346 0040 ECD3     		bcc	.L3
 237:../src/cr_startup_lpc17.c ****     }
 238:../src/cr_startup_lpc17.c **** 
 239:../src/cr_startup_lpc17.c ****     //
 240:../src/cr_startup_lpc17.c ****     // Zero fill the bss segment.  This is done with inline assembly since this
 241:../src/cr_startup_lpc17.c ****     // will clear the value of pulDest if it is not kept in a register.
 242:../src/cr_startup_lpc17.c ****     //
 243:../src/cr_startup_lpc17.c ****     __asm("    ldr     r0, =_bss\n"
 1347              		.loc 1 243 0
 1348              	@ 243 "../src/cr_startup_lpc17.c" 1
 1349 0042 0748     		    ldr     r0, =_bss
 1350 0044 0749     	    ldr     r1, =_ebss
 1351 0046 4FF00002 	    mov     r2, #0
 1352              	    .thumb_func
 1353              	zero_loop:
 1354 004a 8842     	        cmp     r0, r1
 1355 004c B8BF     	        it      lt
 1356 004e 40F8042B 	        strlt   r2, [r0], #4
 1357 0052 FADB     	        blt     zero_loop
 1358              	@ 0 "" 2
 244:../src/cr_startup_lpc17.c ****           "    ldr     r1, =_ebss\n"
 245:../src/cr_startup_lpc17.c ****           "    mov     r2, #0\n"
 246:../src/cr_startup_lpc17.c ****           "    .thumb_func\n"
 247:../src/cr_startup_lpc17.c ****           "zero_loop:\n"
 248:../src/cr_startup_lpc17.c ****           "        cmp     r0, r1\n"
 249:../src/cr_startup_lpc17.c ****           "        it      lt\n"
 250:../src/cr_startup_lpc17.c ****           "        strlt   r2, [r0], #4\n"
 251:../src/cr_startup_lpc17.c ****           "        blt     zero_loop");
 252:../src/cr_startup_lpc17.c **** 
 253:../src/cr_startup_lpc17.c **** #ifdef __USE_CMSIS
 254:../src/cr_startup_lpc17.c **** 	SystemInit();
 1359              		.loc 1 254 0
 1360              		.thumb
 1361 0054 FFF7FEFF 		bl	SystemInit
 255:../src/cr_startup_lpc17.c **** #endif
 256:../src/cr_startup_lpc17.c **** 
 257:../src/cr_startup_lpc17.c **** #if defined (__cplusplus)
 258:../src/cr_startup_lpc17.c **** 	//
 259:../src/cr_startup_lpc17.c **** 	// Call C++ library initialisation
 260:../src/cr_startup_lpc17.c **** 	//
 261:../src/cr_startup_lpc17.c **** 	__libc_init_array();
 262:../src/cr_startup_lpc17.c **** #endif
 263:../src/cr_startup_lpc17.c **** 
 264:../src/cr_startup_lpc17.c **** #if defined (__REDLIB__)
 265:../src/cr_startup_lpc17.c **** 	// Call the Redlib library, which in turn calls main()
 266:../src/cr_startup_lpc17.c **** 	__main() ;
 1362              		.loc 1 266 0
 1363 0058 FFF7FEFF 		bl	__main
 1364              	.L4:
 1365 005c FEE7     		b	.L4
 1366              	.LFE2:
 1368 005e 0000     		.section	.text.NMI_Handler,"ax",%progbits
 1369              		.align	2
 1370              		.weak	NMI_Handler
 1371              		.thumb
 1372              		.thumb_func
 1374              	NMI_Handler:
 1375              	.LFB3:
 267:../src/cr_startup_lpc17.c **** #else
 268:../src/cr_startup_lpc17.c **** 	main();
 269:../src/cr_startup_lpc17.c **** #endif
 270:../src/cr_startup_lpc17.c **** 
 271:../src/cr_startup_lpc17.c **** 	//
 272:../src/cr_startup_lpc17.c **** 	// main() shouldn't return, but if it does, we'll just enter an infinite loop 
 273:../src/cr_startup_lpc17.c **** 	//
 274:../src/cr_startup_lpc17.c **** 	while (1) {
 275:../src/cr_startup_lpc17.c **** 		;
 276:../src/cr_startup_lpc17.c **** 	}
 277:../src/cr_startup_lpc17.c **** }
 278:../src/cr_startup_lpc17.c **** 
 279:../src/cr_startup_lpc17.c **** //*****************************************************************************
 280:../src/cr_startup_lpc17.c **** //
 281:../src/cr_startup_lpc17.c **** // This is the code that gets called when the processor receives a NMI.  This
 282:../src/cr_startup_lpc17.c **** // simply enters an infinite loop, preserving the system state for examination
 283:../src/cr_startup_lpc17.c **** // by a debugger.
 284:../src/cr_startup_lpc17.c **** //
 285:../src/cr_startup_lpc17.c **** //*****************************************************************************
 286:../src/cr_startup_lpc17.c **** void NMI_Handler(void)
 287:../src/cr_startup_lpc17.c **** {
 1376              		.loc 1 287 0
 1377              		@ args = 0, pretend = 0, frame = 0
 1378              		@ frame_needed = 1, uses_anonymous_args = 0
 1379              		@ link register save eliminated.
 1380 0000 80B4     		push	{r7}
 1381              	.LCFI3:
 1382 0002 00AF     		add	r7, sp, #0
 1383              	.LCFI4:
 1384              	.L7:
 1385 0004 FEE7     		b	.L7
 1386              	.LFE3:
 1388 0006 00BF     		.section	.text.HardFault_Handler,"ax",%progbits
 1389              		.align	2
 1390              		.weak	HardFault_Handler
 1391              		.thumb
 1392              		.thumb_func
 1394              	HardFault_Handler:
 1395              	.LFB4:
 288:../src/cr_startup_lpc17.c ****     while(1)
 289:../src/cr_startup_lpc17.c ****     {
 290:../src/cr_startup_lpc17.c ****     }
 291:../src/cr_startup_lpc17.c **** }
 292:../src/cr_startup_lpc17.c **** 
 293:../src/cr_startup_lpc17.c **** void HardFault_Handler(void)
 294:../src/cr_startup_lpc17.c **** {
 1396              		.loc 1 294 0
 1397              		@ args = 0, pretend = 0, frame = 0
 1398              		@ frame_needed = 1, uses_anonymous_args = 0
 1399              		@ link register save eliminated.
 1400              		.loc 1 294 0
 1401 0000 80B4     		push	{r7}
 1402              	.LCFI5:
 1403 0002 00AF     		add	r7, sp, #0
 1404              	.LCFI6:
 1405              	.L10:
 1406 0004 FEE7     		b	.L10
 1407              	.LFE4:
 1409 0006 00BF     		.section	.text.MemManage_Handler,"ax",%progbits
 1410              		.align	2
 1411              		.weak	MemManage_Handler
 1412              		.thumb
 1413              		.thumb_func
 1415              	MemManage_Handler:
 1416              	.LFB5:
 295:../src/cr_startup_lpc17.c ****     while(1)
 296:../src/cr_startup_lpc17.c ****     {
 297:../src/cr_startup_lpc17.c ****     }
 298:../src/cr_startup_lpc17.c **** }
 299:../src/cr_startup_lpc17.c **** 
 300:../src/cr_startup_lpc17.c **** void MemManage_Handler(void)
 301:../src/cr_startup_lpc17.c **** {
 1417              		.loc 1 301 0
 1418              		@ args = 0, pretend = 0, frame = 0
 1419              		@ frame_needed = 1, uses_anonymous_args = 0
 1420              		@ link register save eliminated.
 1421              		.loc 1 301 0
 1422 0000 80B4     		push	{r7}
 1423              	.LCFI7:
 1424 0002 00AF     		add	r7, sp, #0
 1425              	.LCFI8:
 1426              	.L13:
 1427 0004 FEE7     		b	.L13
 1428              	.LFE5:
 1430 0006 00BF     		.section	.text.BusFault_Handler,"ax",%progbits
 1431              		.align	2
 1432              		.weak	BusFault_Handler
 1433              		.thumb
 1434              		.thumb_func
 1436              	BusFault_Handler:
 1437              	.LFB6:
 302:../src/cr_startup_lpc17.c ****     while(1)
 303:../src/cr_startup_lpc17.c ****     {
 304:../src/cr_startup_lpc17.c ****     }
 305:../src/cr_startup_lpc17.c **** }
 306:../src/cr_startup_lpc17.c **** 
 307:../src/cr_startup_lpc17.c **** void BusFault_Handler(void)
 308:../src/cr_startup_lpc17.c **** {
 1438              		.loc 1 308 0
 1439              		@ args = 0, pretend = 0, frame = 0
 1440              		@ frame_needed = 1, uses_anonymous_args = 0
 1441              		@ link register save eliminated.
 1442              		.loc 1 308 0
 1443 0000 80B4     		push	{r7}
 1444              	.LCFI9:
 1445 0002 00AF     		add	r7, sp, #0
 1446              	.LCFI10:
 1447              	.L16:
 1448 0004 FEE7     		b	.L16
 1449              	.LFE6:
 1451 0006 00BF     		.section	.text.UsageFault_Handler,"ax",%progbits
 1452              		.align	2
 1453              		.weak	UsageFault_Handler
 1454              		.thumb
 1455              		.thumb_func
 1457              	UsageFault_Handler:
 1458              	.LFB7:
 309:../src/cr_startup_lpc17.c ****     while(1)
 310:../src/cr_startup_lpc17.c ****     {
 311:../src/cr_startup_lpc17.c ****     }
 312:../src/cr_startup_lpc17.c **** }
 313:../src/cr_startup_lpc17.c **** 
 314:../src/cr_startup_lpc17.c **** void UsageFault_Handler(void)
 315:../src/cr_startup_lpc17.c **** {
 1459              		.loc 1 315 0
 1460              		@ args = 0, pretend = 0, frame = 0
 1461              		@ frame_needed = 1, uses_anonymous_args = 0
 1462              		@ link register save eliminated.
 1463              		.loc 1 315 0
 1464 0000 80B4     		push	{r7}
 1465              	.LCFI11:
 1466 0002 00AF     		add	r7, sp, #0
 1467              	.LCFI12:
 1468              	.L19:
 1469 0004 FEE7     		b	.L19
 1470              	.LFE7:
 1472 0006 00BF     		.section	.text.SVCall_Handler,"ax",%progbits
 1473              		.align	2
 1474              		.weak	SVCall_Handler
 1475              		.thumb
 1476              		.thumb_func
 1478              	SVCall_Handler:
 1479              	.LFB8:
 316:../src/cr_startup_lpc17.c ****     while(1)
 317:../src/cr_startup_lpc17.c ****     {
 318:../src/cr_startup_lpc17.c ****     }
 319:../src/cr_startup_lpc17.c **** }
 320:../src/cr_startup_lpc17.c **** 
 321:../src/cr_startup_lpc17.c **** void SVCall_Handler(void)
 322:../src/cr_startup_lpc17.c **** {
 1480              		.loc 1 322 0
 1481              		@ args = 0, pretend = 0, frame = 0
 1482              		@ frame_needed = 1, uses_anonymous_args = 0
 1483              		@ link register save eliminated.
 1484              		.loc 1 322 0
 1485 0000 80B4     		push	{r7}
 1486              	.LCFI13:
 1487 0002 00AF     		add	r7, sp, #0
 1488              	.LCFI14:
 1489              	.L22:
 1490 0004 FEE7     		b	.L22
 1491              	.LFE8:
 1493 0006 00BF     		.section	.text.DebugMon_Handler,"ax",%progbits
 1494              		.align	2
 1495              		.weak	DebugMon_Handler
 1496              		.thumb
 1497              		.thumb_func
 1499              	DebugMon_Handler:
 1500              	.LFB9:
 323:../src/cr_startup_lpc17.c ****     while(1)
 324:../src/cr_startup_lpc17.c ****     {
 325:../src/cr_startup_lpc17.c ****     }
 326:../src/cr_startup_lpc17.c **** }
 327:../src/cr_startup_lpc17.c **** 
 328:../src/cr_startup_lpc17.c **** void DebugMon_Handler(void)
 329:../src/cr_startup_lpc17.c **** {
 1501              		.loc 1 329 0
 1502              		@ args = 0, pretend = 0, frame = 0
 1503              		@ frame_needed = 1, uses_anonymous_args = 0
 1504              		@ link register save eliminated.
 1505              		.loc 1 329 0
 1506 0000 80B4     		push	{r7}
 1507              	.LCFI15:
 1508 0002 00AF     		add	r7, sp, #0
 1509              	.LCFI16:
 1510              	.L25:
 1511 0004 FEE7     		b	.L25
 1512              	.LFE9:
 1514 0006 00BF     		.section	.text.PendSV_Handler,"ax",%progbits
 1515              		.align	2
 1516              		.weak	PendSV_Handler
 1517              		.thumb
 1518              		.thumb_func
 1520              	PendSV_Handler:
 1521              	.LFB10:
 330:../src/cr_startup_lpc17.c ****     while(1)
 331:../src/cr_startup_lpc17.c ****     {
 332:../src/cr_startup_lpc17.c ****     }
 333:../src/cr_startup_lpc17.c **** }
 334:../src/cr_startup_lpc17.c **** 
 335:../src/cr_startup_lpc17.c **** void PendSV_Handler(void)
 336:../src/cr_startup_lpc17.c **** {
 1522              		.loc 1 336 0
 1523              		@ args = 0, pretend = 0, frame = 0
 1524              		@ frame_needed = 1, uses_anonymous_args = 0
 1525              		@ link register save eliminated.
 1526              		.loc 1 336 0
 1527 0000 80B4     		push	{r7}
 1528              	.LCFI17:
 1529 0002 00AF     		add	r7, sp, #0
 1530              	.LCFI18:
 1531              	.L28:
 1532 0004 FEE7     		b	.L28
 1533              	.LFE10:
 1535 0006 00BF     		.section	.text.SysTick_Handler,"ax",%progbits
 1536              		.align	2
 1537              		.weak	SysTick_Handler
 1538              		.thumb
 1539              		.thumb_func
 1541              	SysTick_Handler:
 1542              	.LFB11:
 337:../src/cr_startup_lpc17.c ****     while(1)
 338:../src/cr_startup_lpc17.c ****     {
 339:../src/cr_startup_lpc17.c ****     }
 340:../src/cr_startup_lpc17.c **** }
 341:../src/cr_startup_lpc17.c **** 
 342:../src/cr_startup_lpc17.c **** void SysTick_Handler(void) 
 343:../src/cr_startup_lpc17.c **** {
 1543              		.loc 1 343 0
 1544              		@ args = 0, pretend = 0, frame = 0
 1545              		@ frame_needed = 1, uses_anonymous_args = 0
 1546              		@ link register save eliminated.
 1547              		.loc 1 343 0
 1548 0000 80B4     		push	{r7}
 1549              	.LCFI19:
 1550 0002 00AF     		add	r7, sp, #0
 1551              	.LCFI20:
 1552              	.L31:
 1553 0004 FEE7     		b	.L31
 1554              	.LFE11:
 1556 0006 00BF     		.section	.text.IntDefaultHandler,"ax",%progbits
 1557              		.align	2
 1558              		.weak	IntDefaultHandler
 1559              		.thumb
 1560              		.thumb_func
 1562              	IntDefaultHandler:
 1563              	.LFB12:
 344:../src/cr_startup_lpc17.c ****     while(1)
 345:../src/cr_startup_lpc17.c ****     {
 346:../src/cr_startup_lpc17.c ****     }
 347:../src/cr_startup_lpc17.c **** }
 348:../src/cr_startup_lpc17.c **** 
 349:../src/cr_startup_lpc17.c **** 
 350:../src/cr_startup_lpc17.c **** //*****************************************************************************
 351:../src/cr_startup_lpc17.c **** //
 352:../src/cr_startup_lpc17.c **** // Processor ends up here if an unexpected interrupt occurs or a handler
 353:../src/cr_startup_lpc17.c **** // is not present in the application code.
 354:../src/cr_startup_lpc17.c **** //
 355:../src/cr_startup_lpc17.c **** //*****************************************************************************
 356:../src/cr_startup_lpc17.c **** void IntDefaultHandler(void)
 357:../src/cr_startup_lpc17.c **** {
 1564              		.loc 1 357 0
 1565              		@ args = 0, pretend = 0, frame = 0
 1566              		@ frame_needed = 1, uses_anonymous_args = 0
 1567              		@ link register save eliminated.
 1568              		.loc 1 357 0
 1569 0000 80B4     		push	{r7}
 1570              	.LCFI21:
 1571 0002 00AF     		add	r7, sp, #0
 1572              	.LCFI22:
 1573              	.L34:
 1574 0004 FEE7     		b	.L34
 1575              	.LFE12:
 1869              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 cr_startup_lpc17.c
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:26     .debug_macinfo:00000000 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1250   .isr_vector:00000000 g_pfnVectors
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1247   .isr_vector:00000000 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1308   .text.ResetISR:00000000 ResetISR
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1374   .text.NMI_Handler:00000000 NMI_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1394   .text.HardFault_Handler:00000000 HardFault_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1415   .text.MemManage_Handler:00000000 MemManage_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1436   .text.BusFault_Handler:00000000 BusFault_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1457   .text.UsageFault_Handler:00000000 UsageFault_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1478   .text.SVCall_Handler:00000000 SVCall_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1499   .text.DebugMon_Handler:00000000 DebugMon_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1520   .text.PendSV_Handler:00000000 PendSV_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1541   .text.SysTick_Handler:00000000 SysTick_Handler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 WDT_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 TIMER0_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 TIMER1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 TIMER2_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 TIMER3_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 UART0_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 UART1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 UART2_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 UART3_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 PWM1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 I2C0_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 I2C1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 I2C2_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 SPI_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 SSP0_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 SSP1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 PLL0_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 RTC_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 EINT0_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 EINT1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 EINT2_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 EINT3_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 ADC_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 BOD_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 USB_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 CAN_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 DMA_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 I2S_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 ENET_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 RIT_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 MCPWM_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 QEI_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 PLL1_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 USBActivity_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 CANActivity_IRQHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1303   .text.ResetISR:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1353   .text.ResetISR:0000004a zero_loop
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1369   .text.NMI_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1389   .text.HardFault_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1410   .text.MemManage_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1431   .text.BusFault_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1452   .text.UsageFault_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1473   .text.SVCall_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1494   .text.DebugMon_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1515   .text.PendSV_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1536   .text.SysTick_Handler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1557   .text.IntDefaultHandler:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1562   .text.IntDefaultHandler:00000000 IntDefaultHandler
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1578   .debug_macinfo:00002692 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1873   .debug_loc:00000000 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccrJYrOJ.s:1368   .text.ResetISR:0000005e $d

UNDEFINED SYMBOLS
_vStackTop
_etext
_data
_edata
_bss
_ebss
SystemInit
__main
