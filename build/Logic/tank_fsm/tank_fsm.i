# 0 "Logic/tank_fsm/tank_fsm.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "Logic/tank_fsm/tank_fsm.c"





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
# 7 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "MCAL/GPIO/GPIO_interface.h" 1
# 41 "MCAL/GPIO/GPIO_interface.h"
STD_ReturnType GPIO_SetPinDirection(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin, uint8 *Copy_pu8Value);




STD_ReturnType GPIO_TogglePinValue(uint8 Copy_u8Port, uint8 Copy_u8Pin);




STD_ReturnType GPIO_SetPortDirection(uint8 Copy_u8Port, uint8 Copy_u8Direction);




STD_ReturnType GPIO_SetPortValue(uint8 Copy_u8Port, uint8 Copy_u8Value);




STD_ReturnType GPIO_GetPortValue(uint8 Copy_u8Port, uint8 *Copy_pu8Value);
# 8 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "HAL/Pump/Pump_interface.h" 1





STD_ReturnType PMP_Init(void);
STD_ReturnType PMP_Set(uint8 Copy_u8State);
STD_ReturnType PMP_GetState(uint8 *Copy_pu8State);
STD_ReturnType PMP_RunSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_TotalSeconds(uint32 *Copy_pu32Seconds);
STD_ReturnType PMP_Cycles(uint32 *Copy_pu32Cycles);
STD_ReturnType PMP_Update1s(void);
# 9 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "HAL/Valve/Valve_interface.h" 1





STD_ReturnType Valve_Init(void);
STD_ReturnType Valve_Set(uint8 Copy_u8State);
STD_ReturnType Valve_GetState(uint8 *Copy_pu8State);
# 10 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "HAL/Buttons/Buttons_interface.h" 1
# 12 "HAL/Buttons/Buttons_interface.h"
typedef enum
{
    BTN_MODE = 0,
    BTN_MANUAL_START,
    BTN_ACK,
    BTN_COUNT
} ButtonID_t;

typedef enum
{
    BTN_EVENT_NONE = 0,
    BTN_EVENT_PRESSED,
    BTN_EVENT_RELEASED,
    BTN_EVENT_SHORT_PRESS,
    BTN_EVENT_LONG_HOLD_1S
} ButtonEvent_t;


STD_ReturnType BTN_Init(uint8 port);


void BTN_Update10ms(uint8 port);


STD_ReturnType BTN_GetEvent(ButtonID_t btn, ButtonEvent_t *pEvent);


STD_ReturnType BTN_IsPressed(uint8 port,
                             ButtonID_t btn,
                             uint8 *pIsPressed);
# 11 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "Logic/interlocks/interlocks.h" 1




# 1 "Logic/interlocks/tank_types.h" 1







typedef enum
{
    ST_INIT = 0,
    ST_IDLE,
    ST_FILLING,
    ST_SETTLING,
    ST_RESERVOIR_WAIT,
    ST_TRIPPED,
    ST_MANUAL,
    ST_SERVICE

} TankState_t;



typedef enum
{
    TRIP_NONE = 0,

    TRIP_OVERFLOW,
    TRIP_OVERCURRENT,
    TRIP_DRY_RESERVOIR,
    TRIP_DRY_RUN,
    TRIP_NO_CURRENT,
    TRIP_MAX_RUNTIME,
    TRIP_LEVEL_SENSOR,
    TRIP_LEAK,
    TRIP_NO_RISE

} Trip_t;



typedef struct
{
    uint16 levelRaw;
    uint16 reservoirRaw;
    uint16 currentRaw;

    uint8 levelPct;
    uint8 reservoirPct;

    uint16 currentmA;
    uint16 flowLpmX10;

    uint32 totalLitres;

    sint8 levelRatePctMin;

    uint8 pumpOn : 1;
    uint8 valveOn : 1;
    uint8 highFloat : 1;
    uint8 lowFloat : 1;
    uint8 reserved : 4;

    uint8 state;
    uint8 activeTrip;

    uint16 pumpRunSec;
    uint32 pumpTotalSec;
    uint16 pumpCycles;

    uint32 upTimeSec;

} TankData_t;






typedef struct
{
    uint16 magic;
    uint8 version;

    uint8 startPct;
    uint8 stopPct;
    uint8 reserveMinPct;
    uint8 overflowPct;

    uint8 overCurrentA_X10;
    uint8 minCurrentA_X10;
    uint8 minFlowLpm;

    uint16 maxRunSec;
    uint16 minOffSec;

    uint8 leakDropPct;

    uint32 totalLitres;
    uint32 pumpTotalSec;
    uint16 pumpCycles;

    uint8 faultHead;
    uint8 checksum;

} TankCfg_t;
# 6 "Logic/interlocks/interlocks.h" 2

STD_ReturnType INT_Init(void);
# 17 "Logic/interlocks/interlocks.h"
Trip_t ILK_Evaluate(const TankData_t *Copy_pstData);







STD_ReturnType ILK_Reset(void);
# 12 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "Logic/demand/demand.h" 1




# 1 "Logic/interlocks/tank_types.h" 1
# 6 "Logic/demand/demand.h" 2

STD_ReturnType DEM_Init(void);
STD_ReturnType DEM_Update(const TankData_t *Copy_pstData);
uint8 DEM_GetPumpDemand(void);
# 13 "Logic/tank_fsm/tank_fsm.c" 2
# 1 "Logic/tank_fsm/tank_fsm.h" 1
# 13 "Logic/tank_fsm/tank_fsm.h"
STD_ReturnType FSM_Init(void);


STD_ReturnType FSM_Run(const TankData_t *Copy_pstData);


TankState_t FSM_GetState(void);


STD_ReturnType FSM_Ack(void);


uint8 FSM_IsBuzzerEnabled(void);
# 14 "Logic/tank_fsm/tank_fsm.c" 2




static TankState_t Global_eCurrentState = ST_INIT;

static uint16 Global_u16SettlingTicks = 0u;
static uint16 Global_u16MinOffTicks = 500u;
static uint8 Global_u8BuzzerSilenced = 0u;
static uint8 Global_u8ManualPumpOn = 0u;




static void FSM_StopOutputs(void)
{
    PMP_Set(0u);
    Valve_Set(0u);
}





static void FSM_StartFilling(void)
{
    PMP_Set(1u);
    Valve_Set(1u);
}





static void FSM_UpdateMinOffTimer(uint8 Copy_u8PumpOn)
{
    if (Copy_u8PumpOn == 0u)
    {
        if (Global_u16MinOffTicks < 500u)
        {
            Global_u16MinOffTicks++;
        }
    }
    else
    {




        Global_u16MinOffTicks = 0u;
    }
}





STD_ReturnType FSM_Init(void)
{
    STD_ReturnType Local_Status;

    Global_eCurrentState = ST_INIT;

    Global_u16SettlingTicks = 0u;
    Global_u16MinOffTicks = 500u;
    Global_u8BuzzerSilenced = 0u;

    Local_Status = PMP_Set(0u);

    if (Local_Status != E_OK)
    {
        return Local_Status;
    }

    Local_Status = Valve_Set(0u);

    if (Local_Status != E_OK)
    {
        return Local_Status;
    }

    return E_OK;
}





STD_ReturnType FSM_Run(const TankData_t *Copy_pstData)
{
    Trip_t Local_eTrip = TRIP_NONE;

    ButtonEvent_t Local_eModeEvent = BTN_EVENT_NONE;
    ButtonEvent_t Local_eManualEvent = BTN_EVENT_NONE;
    ButtonEvent_t Local_eAckEvent = BTN_EVENT_NONE;

    if (Copy_pstData == ((void *)0))
    {
        return E_NOK;
    }





    FSM_UpdateMinOffTimer(Copy_pstData->pumpOn);





    BTN_GetEvent(BTN_MODE, &Local_eModeEvent);
    BTN_GetEvent(BTN_MANUAL_START, &Local_eManualEvent);
    BTN_GetEvent(BTN_ACK, &Local_eAckEvent);





    Local_eTrip = ILK_Evaluate(Copy_pstData);

    if (Local_eTrip != TRIP_NONE)
    {



        FSM_StopOutputs();

        if (Global_eCurrentState != ST_TRIPPED)
        {
            Global_u8BuzzerSilenced = 0u;
        }

        Global_eCurrentState = ST_TRIPPED;






    }





    if ((Local_eAckEvent == BTN_EVENT_SHORT_PRESS) ||
        (Local_eAckEvent == BTN_EVENT_LONG_HOLD_1S))
    {
        FSM_Ack();
    }






    if (Local_eTrip != TRIP_NONE)
    {







        FSM_StopOutputs();

        return E_OK;
    }





    if (Local_eModeEvent == BTN_EVENT_SHORT_PRESS)
    {
        if (Global_eCurrentState == ST_MANUAL)
        {

            Global_u8ManualPumpOn = 0u;
            FSM_StopOutputs();
            Global_eCurrentState = ST_IDLE;
        }
        else if ((Global_eCurrentState == ST_IDLE) ||
                 (Global_eCurrentState == ST_FILLING))
        {

            Global_u8ManualPumpOn = 0u;
            FSM_StopOutputs();

            Global_eCurrentState = ST_MANUAL;
        }
    }





    switch (Global_eCurrentState)
    {
    case ST_INIT:

        FSM_StopOutputs();

        Global_u16SettlingTicks = 0u;

        Global_eCurrentState = ST_IDLE;

        break;

    case ST_IDLE:

        FSM_StopOutputs();

        Global_u16SettlingTicks = 0u;





        if (Copy_pstData->reservoirPct < 25u)
        {
            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }





        else if ((DEM_GetPumpDemand() != 0u) &&
                 (Global_u16MinOffTicks >= 500u))
        {
            Global_eCurrentState = ST_FILLING;
        }

        break;

    case ST_FILLING:




        if (Copy_pstData->reservoirPct < 25u)
        {
            FSM_StopOutputs();

            Global_eCurrentState = ST_RESERVOIR_WAIT;
        }




        else if (DEM_GetPumpDemand() == 0u)
        {
            FSM_StopOutputs();

            Global_u16SettlingTicks = 0u;

            Global_eCurrentState = ST_SETTLING;
        }




        else
        {
            FSM_StartFilling();
        }

        break;

    case ST_SETTLING:

        FSM_StopOutputs();

        if (Global_u16SettlingTicks < 500u)
        {
            Global_u16SettlingTicks++;
        }

        if (Global_u16SettlingTicks >= 500u)
        {
            Global_u16SettlingTicks = 0u;

            Global_eCurrentState = ST_IDLE;
        }

        break;

    case ST_RESERVOIR_WAIT:

        FSM_StopOutputs();

        if (Copy_pstData->reservoirPct >= 25u)
        {
            Global_eCurrentState = ST_IDLE;
        }

        break;

    case ST_TRIPPED:
# 324 "Logic/tank_fsm/tank_fsm.c"
        FSM_StopOutputs();






        break;

    case ST_MANUAL:
# 342 "Logic/tank_fsm/tank_fsm.c"
        if (Local_eManualEvent == BTN_EVENT_SHORT_PRESS)
        {
            if (Global_u8ManualPumpOn == 0u)
            {

                if (Global_u16MinOffTicks >= 500u)
                {
                    Global_u8ManualPumpOn = 1u;
                    FSM_StartFilling();
                }
            }
            else
            {

                Global_u8ManualPumpOn = 0u;
                FSM_StopOutputs();
            }
        }


        if (Global_u8ManualPumpOn != 0u)
        {
            FSM_StartFilling();
        }
        else
        {
            FSM_StopOutputs();
        }
        break;

    case ST_SERVICE:






        FSM_StopOutputs();

        break;

    default:

        FSM_StopOutputs();

        Global_eCurrentState = ST_TRIPPED;

        break;
    }

    return E_OK;
}





TankState_t FSM_GetState(void)
{
    return Global_eCurrentState;
}





STD_ReturnType FSM_Ack(void)
{
    STD_ReturnType Local_Status;

    Global_u8BuzzerSilenced = 1u;

    Local_Status = ILK_Reset();


    if (Local_Status == E_OK)
    {
        Global_eCurrentState = ST_IDLE;
    }

    return Local_Status;
}





uint8 FSM_IsBuzzerEnabled(void)
{
    if ((Global_eCurrentState == ST_TRIPPED) &&
        (Global_u8BuzzerSilenced == 0u))
    {
        return 1u;
    }

    return 0u;
}
