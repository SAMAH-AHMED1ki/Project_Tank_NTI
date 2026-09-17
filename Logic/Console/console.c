/*
 * Author: Doaa Shaker Mohamed Aziz Awad
 * Module: Console command parser and UART telemetry
 */

#include <stdio.h>

#include "console.h"
#include "UART_interface.h"
#include "Ringbuffer.h"
#include "tank_types.h"
#include "tank_fsm.h"

extern TankData_t Global_stTankData;
#define CON_RX_BUFFER_SIZE 64U

#define CON_OK_TEXT "OK\r\n"
#define CON_ERR_CMD_TEXT "ERR CMD\r\n"
#define CON_ERR_RANGE_TEXT "ERR RANGE\r\n"
#define CON_ERR_MODE_TEXT "ERR MODE\r\n"
#define CON_ERR_INTERLOCK_TEXT "ERR INTERLOCK\r\n"
#define CON_ERR_ACTIVE_TEXT "ERR ACTIVE\r\n"
#define CON_ERR_LONG_TEXT "ERR LONG\r\n"

static RingBuffer_t g_conRxBuffer;

FLG_Buffer_t g_conFaultLog;

static uint8 g_conLine[CON_MAX_LINE_LEN + 1U];
static uint8 g_conLineLen = 0U;

/* =========================================================
 * UART output helpers
 * ========================================================= */

static void CON_WriteByte(char ch)
{
    UART_SendByte((uint8)ch);
}

static void CON_WriteString(const char *pText)
{
    if (pText != NULL)
    {
        UART_SendString((const uint8 *)pText);
    }
}

/* =========================================================
 * String helpers
 * ========================================================= */

static uint8 CON_ToUpper(uint8 ch)
{
    if ((ch >= 'a') && (ch <= 'z'))
    {
        return (uint8)(ch - ('a' - 'A'));
    }

    return ch;
}

static uint8 CON_CompareNoCase(
    const uint8 *pLine,
    const char *pExpected)
{
    uint8 index = 0U;

    if ((pLine == NULL) || (pExpected == NULL))
    {
        return 0U;
    }

    while (pExpected[index] != '\0')
    {
        if (CON_ToUpper(pLine[index]) !=
            (uint8)pExpected[index])
        {
            return 0U;
        }

        index++;
    }

    /*
     * Command must end here or be followed by whitespace.
     */
    if ((pLine[index] == '\0') ||
        (pLine[index] == ' ') ||
        (pLine[index] == '\t') ||
        (pLine[index] == '\r') ||
        (pLine[index] == '\n'))
    {
        return 1U;
    }

    return 0U;
}

static void CON_SkipSpaces(
    const uint8 **ppText)
{
    if (ppText == NULL)
    {
        return;
    }

    while ((*ppText != NULL) &&
           (((**ppText) == ' ') ||
            ((**ppText) == '\t') ||
            ((**ppText) == '\r') ||
            ((**ppText) == '\n')))
    {
        (*ppText)++;
    }
}

/* =========================================================
 * Console initialization
 * ========================================================= */

STD_ReturnType CON_Init(void)
{
    RB_Init(&g_conRxBuffer);

    FLG_Init(&g_conFaultLog);

    g_conLineLen = 0U;

    if (UART_Init(9600UL) != E_OK)
    {
        return E_NOK;
    }

    UART_SetRxBuffer(&g_conRxBuffer);

    UART_SetRxInterrupt(1U);

    return E_OK;
}

/* =========================================================
 * Console task
 * ========================================================= */

void CON_Run(void)
{
    uint8 byte;

    while (RB_IsEmpty(&g_conRxBuffer) == 0U)
    {
        if (RB_Get(&g_conRxBuffer, &byte) != E_OK)
        {
            break;
        }

        /*
         * End of command.
         */
        if ((byte == '\r') || (byte == '\n'))
        {
            if (g_conLineLen > 0U)
            {
                g_conLine[g_conLineLen] = '\0';

                CON_ProcessCommand(g_conLine);

                g_conLineLen = 0U;
            }
        }

        /*
         * Normal character.
         */
        else if (g_conLineLen < CON_MAX_LINE_LEN)
        {
            g_conLine[g_conLineLen] = byte;
            g_conLineLen++;
        }

        /*
         * Command too long.
         */
        else
        {
            CON_WriteString(CON_ERR_LONG_TEXT);

            while (RB_IsEmpty(&g_conRxBuffer) == 0U)
            {
                if (RB_Get(&g_conRxBuffer, &byte) != E_OK)
                {
                    break;
                }

                if ((byte == '\r') || (byte == '\n'))
                {
                    break;
                }
            }

            g_conLineLen = 0U;
        }
    }
}

/* =========================================================
 * Command parser
 * ========================================================= */

STD_ReturnType CON_ProcessCommand(
    const uint8 *pCommandLine)
{
    uint8 hasMatch = 0U;

    if (pCommandLine == NULL)
    {
        CON_WriteString(CON_ERR_CMD_TEXT);
        return E_NOK;
    }

    CON_SkipSpaces(&pCommandLine);

    /*
     * ---------------- HELP ----------------
     */
    if (CON_CompareNoCase(pCommandLine, "HELP"))
    {
        CON_SendHelp();
        hasMatch = 1U;
    }

    /*
     * ---------------- STATUS ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "STATUS") ||
             CON_CompareNoCase(pCommandLine, "STATUS?"))
    {
        CON_SendStatus();
        hasMatch = 1U;
    }

    /*
     * ---------------- LEVEL ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "LEVEL?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "LEVEL=%u%%\r\n",
            (unsigned int)Global_stTankData.levelPct);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }

    /*
     * ---------------- FLOW ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "FLOW?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "FLOW=%u.%u L/min\r\n",
            (unsigned int)(Global_stTankData.flowLpmX10 / 10U),

            (unsigned int)(Global_stTankData.flowLpmX10 % 10U));

        CON_WriteString(buffer);

        hasMatch = 1U;
    }

    /*
     * ---------------- VOLUME ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "VOLUME?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "VOLUME=%lu L\r\n",
            (unsigned long)
                Global_stTankData.totalLitres);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }

    /*
     * ---------------- CURRENT ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "CURRENT?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "CURRENT=%u mA\r\n",
            (unsigned int)
                Global_stTankData.currentmA);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }

    /*
     * ---------------- CONFIG ----------------
     *
     * Configuration is not connected to a live
     * configuration structure in the current code.
     */
    else if (CON_CompareNoCase(pCommandLine, "CFG?"))
    {
        CON_WriteString(
            "CFG=30,90,60,8,0.5,1,10,15,120\r\n");

        hasMatch = 1U;
    }

    /*
     * ---------------- ACK ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "ACK"))
    {
        if (FSM_Ack() == E_OK)
        {
            CON_WriteString(CON_OK_TEXT);
        }
        else
        {
            CON_WriteString(CON_ERR_ACTIVE_TEXT);
        }

        hasMatch = 1U;
    }

    /*
     * ---------------- FAULTS ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "FAULTS?"))
    {
        CON_SendFaults();

        hasMatch = 1U;
    }

    /*
     * ---------------- CLEAR FAULTS ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "CLRFAULTS"))
    {
        FLG_Clear(&g_conFaultLog);

        CON_WriteString(CON_OK_TEXT);

        hasMatch = 1U;
    }

    /*
     * ---------------- TRIP ----------------
     */
    else if (CON_CompareNoCase(pCommandLine, "TRIP?"))
    {
        char buffer[32];

        sprintf(
            buffer,
            "TRIP=%u\r\n",
            (unsigned int)
                Global_stTankData.activeTrip);

        CON_WriteString(buffer);

        hasMatch = 1U;
    }

    /*
     * ---------------- MODE ----------------
     *
     * Current console implementation does not directly
     * change the FSM mode.
     */
    else if (CON_CompareNoCase(
                 pCommandLine,
                 "MODE AUTO"))
    {
        CON_WriteString(
            "ERR MODE - USE MODE BUTTON\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "MODE MANUAL"))
    {
        CON_WriteString(
            "ERR MODE - USE MODE BUTTON\r\n");

        hasMatch = 1U;
    }

    /*
     * ---------------- PUMP / VALVE / SERVICE ----------------
     *
     * These commands are intentionally not used to directly
     * force hardware because the FSM owns the safety logic.
     */
    else if (CON_CompareNoCase(
                 pCommandLine,
                 "PUMP ON"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "PUMP OFF"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "VALVE ON"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "VALVE OFF"))
    {
        CON_WriteString(
            "ERR MODE - USE FSM CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "SERVICE ON"))
    {
        CON_WriteString(
            "ERR MODE - USE SERVICE CONTROL\r\n");

        hasMatch = 1U;
    }

    else if (CON_CompareNoCase(
                 pCommandLine,
                 "SERVICE OFF"))
    {
        CON_WriteString(
            "ERR MODE - USE SERVICE CONTROL\r\n");

        hasMatch = 1U;
    }

    /*
     * ---------------- UNKNOWN COMMAND ----------------
     */
    if (hasMatch == 0U)
    {
        CON_WriteString(CON_ERR_CMD_TEXT);
        return E_NOK;
    }

    return E_OK;
}

/* =========================================================
 * STATUS
 * ========================================================= */

void CON_SendStatus(void)
{
    char buffer[96];

    /*
     * Convert FSM state to readable text.
     */
    const char *stateText;

    switch (FSM_GetState())
    {
    case ST_INIT:
        stateText = "INIT";
        break;

    case ST_IDLE:
        stateText = "IDLE";
        break;

    case ST_FILLING:
        stateText = "FILLING";
        break;

    case ST_SETTLING:
        stateText = "SETTLING";
        break;

    case ST_RESERVOIR_WAIT:
        stateText = "RES_WAIT";
        break;

    case ST_TRIPPED:
        stateText = "TRIPPED";
        break;

    case ST_MANUAL:
        stateText = "MANUAL";
        break;

    case ST_SERVICE:
        stateText = "SERVICE";
        break;

    default:
        stateText = "UNKNOWN";
        break;
    }

    /*
     * Human-readable status.
     */
    sprintf(
        buffer,
        "LEVEL=%u%% R=%u%% I=%umA\r\n",
        (unsigned int)
            Global_stTankData.levelPct,

        (unsigned int)
            Global_stTankData.reservoirPct,

        (unsigned int)
            Global_stTankData.currentmA);

    CON_WriteString(buffer);

    sprintf(
        buffer,
        "FLOW=%u.%uL/min VOL=%luL\r\n",
        (unsigned int)(Global_stTankData.flowLpmX10 / 10U),

        (unsigned int)(Global_stTankData.flowLpmX10 % 10U),

        (unsigned long)
            Global_stTankData.totalLitres);

    CON_WriteString(buffer);

    sprintf(
        buffer,
        "PUMP=%u VALVE=%u HIGH=%u LOW=%u\r\n",
        (unsigned int)
            Global_stTankData.pumpOn,

        (unsigned int)
            Global_stTankData.valveOn,

        (unsigned int)
            Global_stTankData.highFloat,

        (unsigned int)
            Global_stTankData.lowFloat);

    CON_WriteString(buffer);

    sprintf(
        buffer,
        "STATE=%s TRIP=%u RUN=%u UP=%lu\r\n",
        stateText,

        (unsigned int)
            Global_stTankData.activeTrip,

        (unsigned int)
            Global_stTankData.pumpRunSec,

        (unsigned long)
            Global_stTankData.upTimeSec);

    CON_WriteString(buffer);
}

/* =========================================================
 * HELP
 * ========================================================= */

void CON_SendHelp(void)
{
    CON_WriteString("=== WATER TANK CONSOLE ===\r\n");

    CON_WriteString(
        "STATUS      - System status\r\n");

    CON_WriteString(
        "LEVEL?      - Roof tank level\r\n");

    CON_WriteString(
        "FLOW?       - Current flow\r\n");

    CON_WriteString(
        "VOLUME?     - Total volume\r\n");

    CON_WriteString(
        "CURRENT?    - Pump current\r\n");

    CON_WriteString(
        "CFG?        - Configuration\r\n");

    CON_WriteString(
        "TRIP?       - Active trip\r\n");

    CON_WriteString(
        "FAULTS?     - Fault history\r\n");

    CON_WriteString(
        "CLRFAULTS   - Clear fault history\r\n");

    CON_WriteString(
        "ACK         - Acknowledge trip\r\n");

    CON_WriteString(
        "MODE AUTO/MANUAL - Mode command\r\n");

    CON_WriteString(
        "===========================\r\n");
}

/* =========================================================
 * FAULT LOG
 * ========================================================= */

STD_ReturnType CON_SendFaults(void)
{
    if (FLG_GetCount(&g_conFaultLog) == 0U)
    {
        CON_WriteString("NO FAULTS\r\n");

        return E_OK;
    }

    FLG_Dump(
        &g_conFaultLog,
        CON_WriteByte);

    return E_OK;
}