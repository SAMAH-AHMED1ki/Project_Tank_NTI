#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "Pump_interface.h"

#define PUMP_PORT GPIO_PORTB
#define PUMP_PIN  GPIO_PIN0

static uint8 Pump_u8State = GPIO_LOW;
static uint32 Pump_u32RunSeconds = 0UL;   /* current continuous run, resets on stop */
static uint32 Pump_u32TotalSeconds = 0UL; /* lifetime run time, never resets        */
static uint32 Pump_u32Cycles = 0UL;

STD_ReturnType PMP_Init(void)
{
	STD_ReturnType Local_xError;

	Local_xError = GPIO_SetPinDirection(PUMP_PORT, PUMP_PIN, GPIO_OUTPUT);
	if (Local_xError != E_OK)
	{
		return Local_xError;
	}

	Local_xError = GPIO_SetPinValue(PUMP_PORT, PUMP_PIN, GPIO_LOW);
	if (Local_xError == E_OK)
	{
		Pump_u8State = GPIO_LOW;
		Pump_u32RunSeconds = 0UL;
		Pump_u32TotalSeconds = 0UL;
		Pump_u32Cycles = 0UL;
	}

	return Local_xError;
}

STD_ReturnType PMP_Set(uint8 Copy_u8State)
{
	STD_ReturnType Local_xError;

	if ((Copy_u8State != GPIO_LOW) && (Copy_u8State != GPIO_HIGH))
	{
		return E_NOK;
	}

	Local_xError = GPIO_SetPinValue(PUMP_PORT, PUMP_PIN, Copy_u8State);
	if (Local_xError != E_OK)
	{
		return Local_xError;
	}

	if ((Pump_u8State == GPIO_LOW) && (Copy_u8State == GPIO_HIGH))
	{
		/* Rising edge: OFF -> ON, this is a new start cycle */
		Pump_u32Cycles++;
	}
	else if ((Pump_u8State == GPIO_HIGH) && (Copy_u8State == GPIO_LOW))
	{

		Pump_u32RunSeconds = 0UL;
	}

	Pump_u8State = Copy_u8State;
	return E_OK;
}

STD_ReturnType PMP_GetState(uint8 *Copy_pu8State)
{
	if (Copy_pu8State == NULL)
	{
		return E_NOK;
	}

	*Copy_pu8State = Pump_u8State;
	return E_OK;
}

STD_ReturnType PMP_RunSeconds(uint32 *Copy_pu32Seconds)
{
	if (Copy_pu32Seconds == NULL)
	{
		return E_NOK;
	}

	*Copy_pu32Seconds = Pump_u32RunSeconds;
	return E_OK;
}

STD_ReturnType PMP_TotalSeconds(uint32 *Copy_pu32Seconds)
{
	if (Copy_pu32Seconds == NULL)
	{
		return E_NOK;
	}

	*Copy_pu32Seconds = Pump_u32TotalSeconds;
	return E_OK;
}

STD_ReturnType PMP_Cycles(uint32 *Copy_pu32Cycles)
{
	if (Copy_pu32Cycles == NULL)
	{
		return E_NOK;
	}

	*Copy_pu32Cycles = Pump_u32Cycles;
	return E_OK;
}

STD_ReturnType PMP_Update1s(void)
{
	if (Pump_u8State == GPIO_HIGH)
	{
		Pump_u32RunSeconds++;
		Pump_u32TotalSeconds++;
	}

	return E_OK;
}