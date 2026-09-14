#ifndef RING_BUFFER_H_
#define RING_BUFFER_H_

#include "STD_TYPES.h"

/*
 * Capacity of one ring buffer instance. Must be large enough to hold
 * the worst-case burst of UART bytes that can arrive between two
 * console polls (e.g. one full command line). Increase if TC-43
 * (40-char line test) overflows it.
 */
#define RB_BUFFER_SIZE   32U

typedef struct
{
    uint8 buffer[RB_BUFFER_SIZE];
    uint8 head;   /* next index to write */
    uint8 tail;   /* next index to read  */
    uint8 count;  /* number of bytes currently stored */
} RingBuffer_t;

/*
 * Initializes / resets a ring buffer instance to empty.
 * pRb : pointer to the RingBuffer_t to initialize.
 */
void RB_Init(RingBuffer_t *pRb);

/*
 * Pushes one byte into the buffer. Safe to call from an ISR context
 * (e.g. USART RX interrupt) - it never blocks.
 * pRb  : pointer to the RingBuffer_t instance.
 * data : byte to store.
 * Returns E_OK if stored, E_NOK if the buffer was full (byte dropped).
 */
STD_ReturnType RB_Put(RingBuffer_t *pRb, uint8 data);

/*
 * Pops one byte from the buffer. Intended to be called from the main
 * loop / console task, not from an ISR.
 * pRb   : pointer to the RingBuffer_t instance.
 * pData : out-parameter, receives the byte if one was available.
 * Returns E_OK if a byte was returned, E_NOK if the buffer was empty.
 */
STD_ReturnType RB_Get(RingBuffer_t *pRb, uint8 *pData);

/* Returns TRUE if the buffer currently holds no data. */
uint8 RB_IsEmpty(const RingBuffer_t *pRb);

/* Returns TRUE if the buffer is completely full. */
uint8 RB_IsFull(const RingBuffer_t *pRb);

#endif /* RING_BUFFER_H_ */