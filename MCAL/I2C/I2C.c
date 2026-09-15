/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — I2C.c  (ATmega32 TWI master)
 * Implement every prototype from I2C_interface.h.
 */

#include "STD_TYPES.h"
#include "I2C_interface.h"
#include "I2C_private.h"

STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz)
{
    /* 1. Reject SCL == 0 */
    if (Copy_u32SclHz == 0u)
    {
        return E_NOK;
    }

    /* 2. Configure Bit Rate Register and set Prescaler bits TWPS1:0 = 00 in TWSR */
    TWBR = (uint8)(((F_CPU / Copy_u32SclHz) - 16u) / 2u);
    TWSR &= ~((1u << 0) | (1u << 1));

    /* 3. Enable TWI peripheral */
    TWCR = (1u << TWEN);

    return E_OK;
}

STD_ReturnType I2C_SendStart(void)
{
    /* 1. Clear TWINT flag, set TWSTA to issue START condition, and enable TWI peripheral */
    TWCR = (1u << TWINT) | (1u << TWSTA) | (1u << TWEN);

    /* 2. Wait until TWINT flag is set by hardware, indicating START transmission finished */
    while ((TWCR & (1u << TWINT)) == 0u)
        ;

    /* Check status code masked with status mask (TWSR & 0xF8) */
    if ((TWSR & TWI_STATUS_MASK) != I2C_START_ACK)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_SendRepeatedStart(void)
{
    /* 1. Clear TWINT flag, set TWSTA to issue Repeated START condition, and enable TWI peripheral */
    TWCR = (1u << TWINT) | (1u << TWSTA) | (1u << TWEN);

    /* Wait until TWINT flag is set by hardware */
    while ((TWCR & (1u << TWINT)) == 0u)
        ;

    /* Check status code masked with status mask (TWSR & 0xF8) against I2C_REP_START_ACK (0x10) */
    if ((TWSR & TWI_STATUS_MASK) != I2C_REP_START_ACK)
    {
        return E_NOK;
    }

    return E_OK;
}

void I2C_SendStop(void)
{
    /* 1. Clear TWINT flag, set TWSTO to issue STOP condition, and enable TWI peripheral */
    TWCR = (1u << TWINT) | (1u << TWSTO) | (1u << TWEN);

    /* Hardware automatically clears TWSTO once the STOP condition is executed.
       No status check or polling is required. */
}

STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address)
{
    /* 1. Shift 7-bit address left by 1 and set LSB to 0 for Write operation */
    TWDR = (uint8)(Copy_u8Address << 1u);

    /* 2. Clear TWINT flag and enable TWI to transmit slave address + R/W bit */
    TWCR = (1u << TWINT) | (1u << TWEN);

    /* Wait until TWINT flag is set by hardware */
    while ((TWCR & (1u << TWINT)) == 0u)
        ;

    /* Check status code against I2C_SLA_W_ACK (0x18) */
    if ((TWSR & TWI_STATUS_MASK) != I2C_SLA_W_ACK)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address)
{
    /* 1. Shift 7-bit address left by 1 and set LSB to 1 for Read operation */
    TWDR = (uint8)((Copy_u8Address << 1u) | 1u);

    /* 2. Clear TWINT flag and enable TWI to transmit slave address + R/W bit */
    TWCR = (1u << TWINT) | (1u << TWEN);

    /* Wait until TWINT flag is set by hardware */
    while ((TWCR & (1u << TWINT)) == 0u)
        ;

    /* Check status code against I2C_SLA_R_ACK (0x40) */
    if ((TWSR & TWI_STATUS_MASK) != I2C_SLA_R_ACK)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_SendByte(uint8 Copy_u8Data)
{
    /* 1. Load data byte into TWDR */
    TWDR = Copy_u8Data;

    /* Clear TWINT flag and enable TWI peripheral to transmit byte */
    TWCR = (1u << TWINT) | (1u << TWEN);

    /* Wait until TWINT flag is set by hardware */
    while ((TWCR & (1u << TWINT)) == 0u)
        ;

    /* Check status code against I2C_DATA_TX_ACK (0x28) */
    if ((TWSR & TWI_STATUS_MASK) != I2C_DATA_TX_ACK)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck)
{
    /* 1. Reject NULL pointer */
    if (Copy_pu8Data == NULL)
    {
        return E_NOK;
    }

    /* 2. Initiate reception with ACK or NACK response */
    if (Copy_u8SendAck == I2C_ACK)
    {
        /* Set TWEA to respond with ACK upon byte reception */
        TWCR = (1u << TWINT) | (1u << TWEA) | (1u << TWEN);

        /* Wait until TWINT flag is set by hardware */
        while ((TWCR & (1u << TWINT)) == 0u)
            ;

        /* Expect I2C_DATA_RX_ACK (0x50) */
        if ((TWSR & TWI_STATUS_MASK) != I2C_DATA_RX_ACK)
        {
            return E_NOK;
        }
    }
    else if (Copy_u8SendAck == I2C_NACK)
    {
        /* Clear TWEA to respond with NACK upon byte reception */
        TWCR = (1u << TWINT) | (1u << TWEN);

        /* Wait until TWINT flag is set by hardware */
        while ((TWCR & (1u << TWINT)) == 0u)
            ;

        /* Expect I2C_DATA_RX_NACK (0x58) */
        if ((TWSR & TWI_STATUS_MASK) != I2C_DATA_RX_NACK)
        {
            return E_NOK;
        }
    }
    else
    {
        return E_NOK;
    }

    /* 3. Read received byte from data register */
    *Copy_pu8Data = TWDR;

    return E_OK;
}

/*
 * Typical 24Cxx write: START -> SLA+W -> word address -> data -> STOP
 * Typical 24Cxx read : START -> SLA+W -> word address -> REP START -> SLA+R -> data+NACK -> STOP
 */
