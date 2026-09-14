#ifndef FLOWMETER_H
#define FLOWMETER_H

#include "STD_TYPES.h"

#define FLOWMETER_PULSES_PER_LITER 450UL

/* Sets PB1/T1 input, starts Timer1 as a free-running external pulse
 * counter, zeroes the internal totaliser. Call once at startup.
 */
STD_ReturnType FLOWMETER_Init(void);

/* Call exactly once per second (e.g. the 1 Hz tick of the 10 ms scheduler).
 * Reads TCNT1, computes the wrap-safe pulse delta since the last call, and
 * updates the flow rate and the running totaliser. Never resets TCNT1 —
 * the hardware counter free-runs and is only ever read, so no pulse is
 * ever lost at a reset boundary.
 */
STD_ReturnType FLOWMETER_Update1Hz(void);

/* Pulses counted in the most recent 1 Hz window. */
uint16 FLOWMETER_GetPulsesPerSec(void);

/* Flow rate in L/min x10 (e.g. 87 = 8.7 L/min), from the most recent window. */
uint16 FLOWMETER_GetFlowLpmX10(void);

/* Lifetime totaliser accumulated every Update1Hz call since Init (or the
 * last explicit reset). uint32 milliliters — does not overflow in practice.
 */
uint32 FLOWMETER_GetTotalMilliliters(void);

/* Deliberate reset of the lifetime totaliser only. NOT part of the normal
 * 1 Hz cycle — call only when the application really means to zero the
 * counted volume (this is different from the old per-cycle reset).
 */
STD_ReturnType FLOWMETER_ResetTotaliser(void);

#endif /* FLOWMETER_H */