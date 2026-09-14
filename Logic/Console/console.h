/*
 * Author: Doaa Shaker Mohamed Aziz Awad
 * Module: Console command parser and UART telemetry - Header
 */

#ifndef CONSOLE_H_
#define CONSOLE_H_

#include "STD_TYPES.h"
#include "DATA.h"
#include "faultlog.h"

#define CON_MAX_LINE_LEN 40U
#define CON_MAX_CMD_LEN 32U

typedef enum
{
    CON_RES_OK = 0,
    CON_RES_ERR_CMD,
    CON_RES_ERR_RANGE,
    CON_RES_ERR_MODE,
    CON_RES_ERR_INTERLOCK,
    CON_RES_ERR_ACTIVE,
    CON_RES_ERR_LONG,
    CON_RES_OK_NOOP
} CON_Result_t;

/* Initializes the console parser and UART receive state. */
STD_ReturnType CON_Init(void);

/* Runs the console task: reads one command line, parses it, and emits responses. */
void CON_Run(void);

/* Parses and executes one complete command line from the UART input buffer. */
STD_ReturnType CON_ProcessCommand(const uint8 *pCommandLine);

/* Sends the live telemetry frame defined in section 18.1 of the README. */
void CON_SendStatus(void);

/* Sends the command-help text listing the valid console commands. */
void CON_SendHelp(void);

/* Sends the fault history newest-first in FLT,n,trip,timeSec,L,R,I format. */
STD_ReturnType CON_SendFaults(void);

#endif /* CONSOLE_H_ */
