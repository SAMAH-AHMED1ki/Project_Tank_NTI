# Smart Water Tank Controller - Driver Plan and Team Assignment

This document turns the project specification in `README.md` into an
implementation plan. The code should be organized into `LIB`, `MCAL`, `HAL`,
and `APP` layers. Each module must keep its public API in a header file and
must not access another layer's private registers or variables.

## 1. Missing Drivers and Modules

### 1.1 Existing drivers

The following drivers are already implemented and should not be rewritten:

| Driver | Current status | Remaining work |
| --- | --- | --- |
| `gpio` / `dio` | Implemented | Use the existing pin configuration and APIs; do not reimplement this driver |
| `adc` | Implemented | Verify channel configuration, scaling, and integration with the sensor HAL |
| `timer` | Implemented | Verify the 10 ms tick and expose the callback/service needed by the scheduler |
| `interrupt` / `exti` | Implemented | Verify INT0/INT1 configuration, callback behavior, and safe ISR flags |

### 1.2 LIB layer

| Module | Required work | Main API / contents |
| --- | --- | --- |
| `STD_TYPES` | Common fixed-width types and status values | `uint8`, `uint16`, `uint32`, `Std_ReturnType`, `E_OK`, `E_NOK` |
| `BIT_MATH` | Register bit operations | `SET_BIT`, `CLR_BIT`, `TOGGLE_BIT`, `GET_BIT` |
| `ring_buffer` | RAM ring buffer for UART RX and fault records | `RB_Init`, `RB_Put`, `RB_Get`, `RB_IsEmpty` |
| `common` | Shared enums and constants | `TankState_t`, `Trip_t`, system tick constants |

### 1.3 MCAL drivers

These are the remaining low-level drivers required by the project. The existing
`adc`, `timer`, and `interrupt` drivers are excluded from this list.

| Driver | Hardware responsibility | Required API |
| --- | --- | --- |
| `counter` | Timer1 external rising-edge pulse counter | `TIMER1_CounterInit`, `TIMER1_ReadCount`, `TIMER1_ResetCount` |
| `usart` | 9600 8N1 serial console and telemetry | `USART_Init`, `USART_SendByte`, `USART_SendString`, `USART_ReadByte`, `USART_SetRxCallback` |
| `spi` | SPI master, mode 0, f/16 for 74HC595 | `SPI_Init`, `SPI_Transmit`, `SPI_TransmitBuffer` |
| `i2c` | TWI master at 100 kHz for PCF8574 LCD adapter | `I2C_Init`, `I2C_Start`, `I2C_Stop`, `I2C_Write`, `I2C_Read` |

### 1.4 HAL drivers

These drivers translate project signals into usable application functions.

| Driver | Responsibility | Required API |
| --- | --- | --- |
| `level` | Scale ADC0 to 0-100%, detect stuck sensor, calculate rate | `LVL_Init`, `LVL_Update`, `LVL_GetPercent`, `LVL_GetRate` |
| `reservoir` | Scale ADC1 and validate the low reservoir condition | `RES_Init`, `RES_Update`, `RES_GetPercent`, `RES_IsLow` |
| `current` | Scale ADC2 to 0-10 A and filter noise | `CUR_Init`, `CUR_Update`, `CUR_GetmA`, `CUR_IsOverLimit` |
| `pump` | Contactor output, run-time accounting, cycle counter | `PMP_Init`, `PMP_Set`, `PMP_IsOn`, `PMP_GetRunSeconds`, `PMP_GetCycles` |
| `valve` | Inlet solenoid output | `VLV_Init`, `VLV_Set`, `VLV_IsOn` |
| `floats` | Debounce high and low float switches | `FLT_Init`, `FLT_Update`, `FLT_IsHighActive`, `FLT_IsLowActive` |
| `buttons` | Debounce mode, acknowledge, and manual-start buttons | `BTN_Init`, `BTN_Update`, `BTN_ModePressed`, `BTN_AckPressed`, `BTN_ManualPressed` |
| `bargraph` | Four level LEDs and pump/fault indicators | `BAR_Init`, `BAR_ShowLevel`, `BAR_ShowPump`, `BAR_ShowFault` |
| `shiftreg` | Send the 8 status/fault bits to 74HC595 over SPI | `SHR_Init`, `SHR_Write`, `SHR_SetBit` |
| `lcd_i2c` | 16x2 LCD commands and text over PCF8574 | `LCD_Init`, `LCD_Clear`, `LCD_SetCursor`, `LCD_WriteString`, `LCD_WriteNumber` |

### 1.5 APP modules

These modules implement the behavior described in the README and are not
hardware drivers, but they are required for a complete working project.

| Module | Responsibility | Required API |
| --- | --- | --- |
| `scheduler` | Run 10 ms, 100 ms, 500 ms, and 1 s jobs | `SCH_Init`, `SCH_Run`, `SCH_Tick10ms` |
| `interlocks` | Fixed-priority trip checks and confirmation timers | `ILK_Init`, `ILK_Evaluate`, `ILK_Reset` |
| `demand` | Roof-level hysteresis and minimum-off timer | `DMD_Init`, `DMD_WantPump`, `DMD_GetWaitSeconds` |
| `flowmeter` | Timer1 delta, L/min conversion, and litre totaliser | `FLW_Init`, `FLW_Update1Hz`, `FLW_GetLpm`, `FLW_GetLitres` |
| `tank_fsm` | IDLE, FILLING, TRIPPED, SERVICE states | `FSM_Init`, `FSM_Run`, `FSM_GetState`, `FSM_Ack` |
| `faultlog` | 16-entry RAM fault-history ring | `FLG_Init`, `FLG_Append`, `FLG_Dump` |
| `console` | Parse UART commands and transmit telemetry | `CON_Init`, `CON_Run`, `CON_ProcessCommand`, `CON_SendStatus` |
| `main` | Initialization, watchdog policy, and main scheduler loop | `main`, `APP_Init`, `APP_Run` |

## 2. Important Implementation Rules

1. Initialize GPIO directions before enabling outputs. Pump and valve outputs
  must start OFF.
2. The high-float INT0 ISR must immediately switch off pump and valve, set an
  overflow flag, and return. Full trip processing remains in the scheduler.
3. Read `TCNT1` atomically with interrupts disabled and calculate the delta
  using unsigned subtraction so 16-bit wrap-around is safe.
4. The order in every control cycle is: sample inputs, evaluate interlocks,
  latch a trip, run the state machine, run demand logic only when safe, then
  update outputs and displays.
5. No trip may clear automatically. `ACK` clears a trip only after its cause is
  gone; otherwise the trip remains latched.
6. Shared ISR variables must be declared `volatile`. UART RX and fault-log
  access must not corrupt ring-buffer indexes.
7. Every driver needs a header, a source file, initialization, normal use,
  invalid-input behavior, and a small test checklist.

## 3. Team Assignment

The four members have a similar number of modules and each member owns both
implementation and verification for their assigned area. Integration rules
and interfaces are shared so that no module is delivered without its header.

## Project Explanation

This project is a smart controller for a pump that transfers water from a
ground tank to a roof tank. The controller reads the two tank levels, pump
current, flow pulses, float switches, and operator buttons. It then decides
whether the pump and inlet valve may run.

The normal cycle is simple: when the roof tank is below the low set point, the
pump fills it until the high set point is reached. The important part is the
safety system around this cycle. The controller must stop the pump if the
reservoir is empty, the pipe has no flow, the motor current is too high or too
low, the tank overflows, the level sensor is stuck, the pump runs too long, or
the tank level falls unexpectedly.

The software is divided into four layers. `MCAL` talks directly to the
ATmega32 peripherals, `HAL` converts hardware signals into project functions,
`APP` implements the pump state machine and protection rules, and `LIB` holds
shared types and reusable utilities. GPIO, ADC, Timer, and Interrupt drivers
already exist and are used by the new modules. The team only implements the
remaining modules listed below.

### Member 1 - Sama Rizk El Saeed Azzam

#### SPI and flow owner

- `common.h/.c`
- `spi.c/.h`
- `shiftreg.c/.h`
- `counter.c/.h`
- `flowmeter.c/.h`
- `scheduler.c/.h`

**What Sama will do:** Define the shared data types used by all modules, then
implement SPI in master mode 0 for communication with the 74HC595. The
`shiftreg` module will convert fault and status flags into the eight output
bits and latch them safely. She will also configure the Timer1 pulse counter,
read its value atomically, calculate the pulse difference every second, and
convert it to flow and total litres. She must provide headers, initialization
functions, boundary handling, and tests for counter wrap-around and SPI bit
ordering. She will also connect the existing 10 ms Timer driver to the
scheduler and provide the periodic job hooks used by the application.

**Integration deliverable:** shared types, the SPI driver, the complete
SPI-to-74HC595 status-bar path, flow-pulse counting/measurement, and the
periodic scheduler service. The existing GPIO, ADC, Timer, and Interrupt
drivers are used as-is.

### Member 2 - Samah Ahmed Mahmoud Ahmed

#### Main control and remaining HAL owner

- `interlocks.c/.h`
- `demand.c/.h`
- `tank_fsm.c/.h`
- `main.c/.h`
- `current.c/.h`
- `floats.c/.h`

**What Samah will do:** Implement the control decision order so interlocks are
checked before demand, write the pump state machine, and enforce hysteresis and
the minimum-off time. She will also convert the pump-current ADC reading,
debounce the float switches, and connect the application startup to the
existing drivers. Her tests must cover normal filling, an empty reservoir,
overflow input, sensor limits, and a latched trip that blocks the pump.

**Integration deliverable:** state machine, demand logic, pump-current input,
float debounce, and final application startup.

### Member 3 - Doaa Shaker Mohamed Aziz Awad

#### UART and UART services owner

- `usart.c/.h`
- `ring_buffer.c/.h`
- `console.c/.h`
- `faultlog.c/.h`
- `pump.c/.h`
- `valve.c/.h`
- Verify UART RX/TX, ring-buffer safety, console commands, fault-history dump,
  and actuator runtime accounting

**What Doaa will do:** Configure the USART at 9600 8N1 and handle received
characters without blocking the control loop. The ring buffer will protect
UART data between the RX interrupt and the main loop. She will parse commands
such as `ACK`, `STATUS?`, and `FAULTS?`, transmit telemetry, and store or dump
the 16-entry fault history. She will also implement the pump contactor and
inlet-valve outputs, including safe OFF startup, run-time accounting, and
cycle counting. Tests must cover long UART messages, unknown commands, fault
log output, and actuator shutdown.

**Integration deliverable:** complete UART service path and safe pump/valve
functions for the application layer.

### Member 4 - Aya Mohamed Refaat Naguib

#### I2C and display owner

- `i2c.c/.h`
- `lcd_i2c.c/.h`
- `buttons.c/.h`
- `bargraph.c/.h`
- `level.c/.h`
- `reservoir.c/.h`
- Verify TWI transactions, LCD initialization, cursor/write operations, and
  display error handling, button debounce, bargraph levels, and tank-level
  scaling

**What Aya will do:** Implement the TWI master at 100 kHz and handle start,
write, read, acknowledge, stop, and bus-error conditions. She will build the
PCF8574 LCD layer on top of I2C, initialize the 16x2 display, position the
cursor, print numbers and status text, and refresh the screen without
flicker. The display must show level, flow, pump state, wait time, and active
fault information supplied by the application layer. She will also debounce
the mode, acknowledge, and manual-start buttons and drive the four-level
bargraph. Tests must cover LCD startup, both display lines, numeric formatting,
button bounce, bargraph thresholds, roof/reservoir level scaling, and an I2C
failure.

**Integration deliverable:** complete I2C-to-PCF8574-to-LCD display path using
the application data supplied by the control modules.

## 4. Shared Integration and Test Ownership

Integration is done together after each member's module passes its local
checklist. The work is split by test area to keep the overall effort balanced:

| Member | Shared test responsibility |
| --- | --- |
| Sama | SPI, 74HC595 status bits, Timer1 wrap, flow totaliser, and scheduler jobs |
| Samah | State machine, interlock priority, pump current, and float safety |
| Doaa | UART commands, fault log dump, sensor limits, and pump/valve behavior |
| Aya | I2C transactions, LCD content, level scaling, button debounce, and bargraph |

All members participate in the final SimulIDE demonstration, code review, and
report. A module is considered complete only when its `.c`, `.h`, test result,
and integration notes are committed to the shared project folder.

## 5. Recommended Build Order

1. Create the folder structure and shared types.
2. Finish MCAL initialization and verify pins with LEDs or the simulator.
3. Finish HAL sensor and actuator drivers.
4. Finish LCD, UART, SPI, and I2C communication paths.
5. Implement flow measurement, demand, interlocks, and the state machine.
6. Integrate the scheduler and console, then run the fault-injection tests.
7. Review the README requirements and record evidence for every requirement.
