# 0 "MCAL/I2C/I2C.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/I2C/I2C.c"
# 9 "MCAL/I2C/I2C.c"
# 1 "LIB/STD_TYPES.h" 1
# 12 "LIB/STD_TYPES.h"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned long uint32;
typedef signed char sint8;
typedef signed short sint16;
typedef signed long sint32;

typedef unsigned char uint8_h;

typedef enum
{
    E_OK = 0,
    E_NOK = 1,
    E_PORT_NOT_VALID = 2,
    E_PIN_NOT_VALID = 3,
} STD_ReturnType;
# 10 "MCAL/I2C/I2C.c" 2
# 1 "MCAL/I2C/I2C_interface.h" 1
# 32 "MCAL/I2C/I2C_interface.h"
STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz);




STD_ReturnType I2C_SendStart(void);




STD_ReturnType I2C_SendRepeatedStart(void);




void I2C_SendStop(void);





STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address);
STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address);




STD_ReturnType I2C_SendByte(uint8 Copy_u8Data);





STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck);
# 11 "MCAL/I2C/I2C.c" 2
# 1 "MCAL/I2C/I2C_private.h" 1
# 12 "MCAL/I2C/I2C.c" 2

STD_ReturnType I2C_InitMaster(uint32 Copy_u32SclHz)
{

    if (Copy_u32SclHz == 0u)
    {
        return E_NOK;
    }


    (*((volatile uint8 *)0x20)) = (uint8)(((8000000UL / Copy_u32SclHz) - 16u) / 2u);
    (*((volatile uint8 *)0x21)) &= ~((1u << 0) | (1u << 1));


    (*((volatile uint8 *)0x56)) = (1u << 2);

    return E_OK;
}

STD_ReturnType I2C_SendStart(void)
{

    (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 5) | (1u << 2);


    while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
        ;


    if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x08u)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_SendRepeatedStart(void)
{

    (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 5) | (1u << 2);


    while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
        ;


    if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x10u)
    {
        return E_NOK;
    }

    return E_OK;
}

void I2C_SendStop(void)
{

    (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 4) | (1u << 2);



}

STD_ReturnType I2C_SendSlaveAddressWithWrite(uint8 Copy_u8Address)
{

    (*((volatile uint8 *)0x23)) = (uint8)(Copy_u8Address << 1u);


    (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 2);


    while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
        ;


    if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x18u)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_SendSlaveAddressWithRead(uint8 Copy_u8Address)
{

    (*((volatile uint8 *)0x23)) = (uint8)((Copy_u8Address << 1u) | 1u);


    (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 2);


    while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
        ;


    if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x40u)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_SendByte(uint8 Copy_u8Data)
{

    (*((volatile uint8 *)0x23)) = Copy_u8Data;


    (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 2);


    while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
        ;


    if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x28u)
    {
        return E_NOK;
    }

    return E_OK;
}

STD_ReturnType I2C_ReceiveByte(uint8 *Copy_pu8Data, uint8 Copy_u8SendAck)
{

    if (Copy_pu8Data == ((void *)0))
    {
        return E_NOK;
    }


    if (Copy_u8SendAck == 1u)
    {

        (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 6) | (1u << 2);


        while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
            ;


        if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x50u)
        {
            return E_NOK;
        }
    }
    else if (Copy_u8SendAck == 0u)
    {

        (*((volatile uint8 *)0x56)) = (1u << 7) | (1u << 2);


        while (((*((volatile uint8 *)0x56)) & (1u << 7)) == 0u)
            ;


        if (((*((volatile uint8 *)0x21)) & 0xF8) != 0x58u)
        {
            return E_NOK;
        }
    }
    else
    {
        return E_NOK;
    }


    *Copy_pu8Data = (*((volatile uint8 *)0x23));

    return E_OK;
}
