/*
 * Author: Ahmed Ellamie
 * Email:  ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — INTERRUPT.c  (ATmega32 EXTI + global I-bit)
 * Implement every prototype from INTERRUPT_interface.h.
 */

#include "STD_TYPES.h"
#include "INTERRUPT_interface.h"
#include "INTERRUPT_private.h"
#include <avr/interrupt.h>

static EXTI_CallbackType EXTI_INT0_Callback = NULL;
static EXTI_CallbackType EXTI_INT1_Callback = NULL;
static EXTI_CallbackType EXTI_INT2_Callback = NULL;

/*
 * INTERRUPT_EnableGlobal
 * 1. Set SREG I-bit (sei). Return E_OK.
 *
 * INTERRUPT_DisableGlobal
 * 1. Clear SREG I-bit (cli). Return E_OK.
 */
STD_ReturnType INTERRUPT_EnableGlobal(void)
{
    SREG |= (1u << I_BIT);

    return E_OK;
}

STD_ReturnType INTERRUPT_DisableGlobal(void)
{
    SREG &= ~(1u << I_BIT);

    return E_OK;
}

/*
 * EXTI_SetSense
 * 1. Reject an unknown source.
 * 2. INT0 : write ISC01:ISC00 from Copy_u8Sense (0..3).
 * 3. INT1 : write ISC11:ISC10 the same way.
 * 4. INT2 : only EXTI_FALLING_EDGE (ISC2=0) or EXTI_RISING_EDGE (ISC2=1).
 *    Return E_NOK for low-level / any-change on INT2.
 */

STD_ReturnType EXTI_SetSense(uint8 Copy_u8Int, uint8 Copy_u8Sense)
{

    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        if (Copy_u8Sense <= EXTI_RISING_EDGE)
        {
            MCUCR &= ~((1u << ISC01) | (1u << ISC00));
            MCUCR |= (Copy_u8Sense << ISC00);
            return E_OK;
        }
        break;

    case EXTI_INT1:
        if (Copy_u8Sense <= EXTI_RISING_EDGE)
        {
            MCUCR &= ~((1u << ISC11) | (1u << ISC10));
            MCUCR |= (Copy_u8Sense << ISC10);
            return E_OK;
        }
        break;

    case EXTI_INT2:
        if (Copy_u8Sense == EXTI_FALLING_EDGE)
        {
            MCUCSR &= ~(1u << ISC2);
            return E_OK;
        }
        else if (Copy_u8Sense == EXTI_RISING_EDGE)
        {
            MCUCSR |= (1u << ISC2);
            return E_OK;
        }
        break;
    default:
        break;
    }

    return E_NOK;
}
/*
 * EXTI_ClearFlag
 * 1. Write 1 to INTF0 / INTF1 / INTF2 in GIFR (w1c).
 */

STD_ReturnType EXTI_ClearFlag(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:

        GIFR |= (1u << INTF0);
        return E_OK;

    case EXTI_INT1:

        GIFR |= (1u << INTF1);
        return E_OK;

    case EXTI_INT2:

        GIFR |= (1u << INTF2);
        return E_OK;

    default:

        return E_NOK;
    }
}
/*
 * EXTI_Enable
 * 1. Validate the source.
 * 2. Clear the stale flag first, then set INT0/INT1/INT2 in GICR.
 * 3. Order that always works: sense -> clear flag -> enable source -> sei().
 *
 * EXTI_Disable
 * 1. Clear the matching GICR bit.
 */

STD_ReturnType EXTI_Enable(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:

        GIFR |= (1u << INTF0);
        GICR |= (1u << INT0);
        return E_OK;

    case EXTI_INT1:

        GIFR |= (1u << INTF1);
        GICR |= (1u << INT1);
        return E_OK;

    case EXTI_INT2:

        GIFR |= (1u << INTF2);
        GICR |= (1u << INT2);
        return E_OK;

    default:

        return E_NOK;
    }
}
STD_ReturnType EXTI_Disable(uint8 Copy_u8Int)
{
    switch (Copy_u8Int)
    {
    case EXTI_INT0:

        GICR &= ~(1u << INT0);
        return E_OK;

    case EXTI_INT1:

        GICR &= ~(1u << INT1);
        return E_OK;

    case EXTI_INT2:

        GICR &= ~(1u << INT2);
        return E_OK;

    default:
        return E_NOK;
    }
}

STD_ReturnType EXTI_SetCallback(uint8 Copy_u8Int, EXTI_CallbackType Copy_pfCallback)
{
    if (Copy_pfCallback == NULL)
    {
        return E_NOK;
    }

    switch (Copy_u8Int)
    {
    case EXTI_INT0:
        EXTI_INT0_Callback = Copy_pfCallback;
        return E_OK;

    case EXTI_INT1:
        EXTI_INT1_Callback = Copy_pfCallback;
        return E_OK;

    case EXTI_INT2:
        EXTI_INT2_Callback = Copy_pfCallback;
        return E_OK;

    default:
        return E_NOK;
    }
}

ISR(INT0_vect)
{
    if (EXTI_INT0_Callback != NULL)
    {
        EXTI_INT0_Callback();
    }
}

ISR(INT1_vect)
{
    if (EXTI_INT1_Callback != NULL)
    {
        EXTI_INT1_Callback();
    }
}

ISR(INT2_vect)
{
    if (EXTI_INT2_Callback != NULL)
    {
        EXTI_INT2_Callback();
    }
}
/* The vector handlers above dispatch to the callbacks registered by the application. */

/*
 * Author: Ahmed Ellamie
 * Email: ahmed.ellamiee@gmail.com
 *
 * STUDENT TASK — INTERRUPT.c (ATmega32 EXTI + global I-bit)
 * Implement every prototype from INTERRUPT_interface.h.
 */