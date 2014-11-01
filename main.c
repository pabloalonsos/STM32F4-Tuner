#include <stdio.h>
#include <stdlib.h>


#include "STM32F4xx.h"
#include "LED.h"
#include "Keyboard.h"

#define size_of_array(x) sizeof(x)/sizeof(x[0])

volatile uint32_t msTicks = 0;                      /* counts 1ms timeTicks       */

// SysTick Handler (Interrupt Service Routine for the System Tick interrupt)
void SysTick_Handler(void){
  msTicks++;
}

// initialize the system tick 
void InitSystick(void){
	SystemCoreClockUpdate();                      /* Get Core Clock Frequency   */
  if (SysTick_Config(SystemCoreClock / 1000)) { /* SysTick 1 msec interrupts  */
    while (1);                                  /* Capture error              */
  }
}
int main(void) {
	uint32_t msPrev = 0;
	
	InitSystick();
	
	while(1){ /* main function does not return */
		/* Read axes data from initialized accelerometer */
		if((msTicks - msPrev) >= 100){
			msPrev = msTicks;
		}
	}
	
}
