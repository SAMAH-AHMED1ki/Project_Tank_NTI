# 0 "MCAL/UART/UART.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "MCAL/UART/UART.c"
# 9 "MCAL/UART/UART.c"
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
# 10 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_interface.h" 1
# 20 "MCAL/UART/UART_interface.h"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate);




STD_ReturnType UART_SendByte(uint8 Copy_u8Data);




STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data);




STD_ReturnType UART_SendString(const uint8 *Copy_pu8String);





STD_ReturnType UART_IsDataReady(void);





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State);
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State);
# 11 "MCAL/UART/UART.c" 2
# 1 "MCAL/UART/UART_private.h" 1
# 12 "MCAL/UART/UART.c" 2
# 1 "LIB/MATH.h" 1



# 1 "LIB/STD_TYPES.h" 1
# 5 "LIB/MATH.h" 2
# 13 "MCAL/UART/UART.c" 2
# 22 "MCAL/UART/UART.c"
STD_ReturnType UART_Init(uint32 Copy_u32BaudRate){
    uint16 UBRRValue;

    if (Copy_u32BaudRate == 0){
        return E_NOK;
    }

    UBRRValue = ((uint16)((8000000UL / (16UL * (Copy_u32BaudRate))) - 1));
    (*(volatile uint8 *)0x40) = (uint8)(UBRRValue >> 8);
    (*(volatile uint8 *)0x29) = (uint8)(UBRRValue & 0xFF);
    (*(volatile uint8 *)0x40) = (1<<7) | (1<<1) | (1<<0);
    (*(volatile uint8 *)0x2A) = (1<<4) | (1<<3);


    return E_OK;
}




STD_ReturnType UART_SendByte(uint8 Copy_u8Data){
    while(((((*(volatile uint8 *)0x2B)) >> (5)) & 1u)==0){
    }
    (*(volatile uint8 *)0x2C)=Copy_u8Data;
    return E_OK;
}





STD_ReturnType UART_ReceiveByte(uint8 *Copy_pu8Data){
    if(Copy_pu8Data==((void *)0)){
        return E_NOK;
    }
    while(((((*(volatile uint8 *)0x2B)) >> (7)) & 1u)==0){
    }
    *Copy_pu8Data = (*(volatile uint8 *)0x2C);
    return E_OK;
}





STD_ReturnType UART_SendString(const uint8 *Copy_pu8String){
        if(Copy_pu8String==((void *)0)){
        return E_NOK;
    }
    uint8 i=0;
    while(Copy_pu8String[i]!='\0'){
        UART_SendByte(Copy_pu8String[i]);
        i++;
    }
    return E_OK;
}




STD_ReturnType UART_IsDataReady(void){
    if(((((*(volatile uint8 *)0x2B)) >> (7)) & 1u)==1)
        return E_OK;
    else
        return E_NOK;

}





STD_ReturnType UART_SetRxInterrupt(uint8 Copy_u8State){
    if (Copy_u8State == 1){
        (((*(volatile uint8 *)0x2A)) |= (1u << (7)));
        return E_OK;
    }
    else if (Copy_u8State == 0){
        (((*(volatile uint8 *)0x2A)) &= ~(1u << (7)));
        return E_OK;
    }
    else{
        return E_NOK;
    }
}
STD_ReturnType UART_SetTxInterrupt(uint8 Copy_u8State){
    if (Copy_u8State == 1){
        (((*(volatile uint8 *)0x2A)) |= (1u << (5)));
        return E_OK;
    }
    else if (Copy_u8State == 0){
        (((*(volatile uint8 *)0x2A)) &= ~(1u << (5)));
        return E_OK;
    }
    else{
        return E_NOK;
    }
}
