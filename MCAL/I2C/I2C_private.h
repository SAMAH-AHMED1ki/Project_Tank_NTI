#ifndef I2C_PRIVATE_H
#define I2C_PRIVATE_H

/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — I2C / TWI private layer (ATmega32)
 * Include this file ONLY from I2C.c.
 */

/* =========================================================================
 * 1. Register Definitions (ATmega32 Memory Mapped Registers)
 * ========================================================================= */
#define TWBR (*((volatile uint8 *)0x20)) /* TWI Bit Rate Register */
#define TWSR (*((volatile uint8 *)0x21)) /* TWI Status Register */
#define TWAR (*((volatile uint8 *)0x22)) /* TWI (Slave) Address Register */
#define TWDR (*((volatile uint8 *)0x23)) /* TWI Data Register */
#define TWCR (*((volatile uint8 *)0x56)) /* TWI Control Register */

/* =========================================================================
 * 2. Bit Definitions for TWCR Register
 * ========================================================================= */
#define TWINT 7 /* TWI Interrupt Flag */
#define TWEA 6  /* TWI Enable Acknowledge Bit */
#define TWSTA 5 /* TWI START Condition Bit */
#define TWSTO 4 /* TWI STOP Condition Bit */
#define TWWC 3  /* TWI Write Collision Flag */
#define TWEN 2  /* TWI Enable Bit */
/* Bit 1 is reserved */
#define TWIE 0 /* TWI Interrupt Enable */

/* =========================================================================
 * 3. Status Mask
 * ========================================================================= */
/* TWS7..TWS3 contain status code; bottom 3 bits (TWPS1:0 and reserved bit) are masked out */
#define TWI_STATUS_MASK 0xF8

#endif