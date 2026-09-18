#include "Ringbuffer.h"

#include <avr/interrupt.h>

static uint8 RB_NextIndex(uint8 Copy_u8Index)
{
	Copy_u8Index++;

	if (Copy_u8Index >= RB_BUFFER_SIZE)
	{
		Copy_u8Index = 0U;
	}

	return Copy_u8Index;
}

void RB_Init(RingBuffer_t *pRb)
{
	if (pRb == NULL)
	{
		return;
	}

	pRb->head = 0U;
	pRb->tail = 0U;
	pRb->count = 0U;
}

STD_ReturnType RB_Put(RingBuffer_t *pRb, uint8 data)
{
	uint8 Local_u8Sreg;

	if (pRb == NULL)
	{
		return E_NOK;
	}

	Local_u8Sreg = SREG;
	cli();

	if (pRb->count >= RB_BUFFER_SIZE)
	{
		SREG = Local_u8Sreg;
		return E_NOK;
	}

	pRb->buffer[pRb->head] = data;
	pRb->head = RB_NextIndex(pRb->head);
	pRb->count++;

	SREG = Local_u8Sreg;
	return E_OK;
}

STD_ReturnType RB_Get(RingBuffer_t *pRb, uint8 *pData)
{
	uint8 Local_u8Sreg;

	if ((pRb == NULL) || (pData == NULL))
	{
		return E_NOK;
	}

	Local_u8Sreg = SREG;
	cli();

	if (pRb->count == 0U)
	{
		SREG = Local_u8Sreg;
		return E_NOK;
	}

	*pData = pRb->buffer[pRb->tail];
	pRb->tail = RB_NextIndex(pRb->tail);
	pRb->count--;

	SREG = Local_u8Sreg;
	return E_OK;
}

uint8 RB_IsEmpty(const RingBuffer_t *pRb)
{
	uint8 Local_u8Sreg;
	uint8 Local_u8Count;

	if (pRb == NULL)
	{
		return 1U;
	}

	Local_u8Sreg = SREG;
	cli();
	Local_u8Count = pRb->count;
	SREG = Local_u8Sreg;

	return (Local_u8Count == 0U) ? 1U : 0U;
}

uint8 RB_IsFull(const RingBuffer_t *pRb)
{
	uint8 Local_u8Sreg;
	uint8 Local_u8Count;

	if (pRb == NULL)
	{
		return 0U;
	}

	Local_u8Sreg = SREG;
	cli();
	Local_u8Count = pRb->count;
	SREG = Local_u8Sreg;

	return (Local_u8Count >= RB_BUFFER_SIZE) ? 1U : 0U;
}
