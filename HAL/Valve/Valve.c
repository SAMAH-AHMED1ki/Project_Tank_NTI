#include "STD_TYPES.h"
#include "GPIO_interface.h"
#include "Valve_interface.h"

#define VALVE_PORT GPIO_PORTB
#define VALVE_PIN  GPIO_PIN2

static uint8 Valve_u8State = GPIO_LOW;

STD_ReturnType Valve_Init(void)
{
	STD_ReturnType Local_xError;

	Local_xError = GPIO_SetPinDirection(VALVE_PORT, VALVE_PIN, GPIO_OUTPUT);
	if (Local_xError != E_OK)
	{
		return Local_xError;
	}

	Local_xError = GPIO_SetPinValue(VALVE_PORT, VALVE_PIN, GPIO_LOW);
	if (Local_xError == E_OK)
	{
		Valve_u8State = GPIO_LOW;
	}

	return Local_xError;
}

STD_ReturnType Valve_Set(uint8 Copy_u8State)
{
	STD_ReturnType Local_xError;

	if ((Copy_u8State != GPIO_LOW) && (Copy_u8State != GPIO_HIGH))
	{
		return E_NOK;
	}

	Local_xError = GPIO_SetPinValue(VALVE_PORT, VALVE_PIN, Copy_u8State);
	if (Local_xError == E_OK)
	{
		Valve_u8State = Copy_u8State;
	}

	return Local_xError;
}

STD_ReturnType Valve_GetState(uint8 *Copy_pu8State)
{
	if (Copy_pu8State == NULL)
	{
		return E_NOK;
	}

	*Copy_pu8State = Valve_u8State;
	return E_OK;
}
