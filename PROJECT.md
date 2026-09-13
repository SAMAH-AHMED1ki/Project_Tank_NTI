# Smart Water Tank Controller - Driver Plan and Team Assignment

This document turns the project specification in `README.md` into an
implementation plan. The code should be organized into `LIB`, `MCAL`, `HAL`,
and `APP` layers. Each module must keep its public API in a header file and
must not access another layer's private registers or variables.

## 1. Missing Drivers and Modules

### 1.1 LIB layer

| Module | Required work | Main API / contents |
| --- | --- | --- |
| `STD_TYPES` | Common fixed-width types and status values | `uint8`, `uint16`, `uint32`, `Std_ReturnType`, `E_OK`, `E_NOK` |
| `BIT_MATH` | Register bit operations | `SET_BIT`, `CLR_BIT`, `TOGGLE_BIT`, `GET_BIT` |
| `ring_buffer` | RAM ring buffer for UART RX and fault records | `RB_Init`, `RB_Put`, `RB_Get`, `RB_IsEmpty` |
| `common` | Shared enums and constants | `TankState_t`, `Trip_t`, system tick constants |

### 1.2 MCAL drivers

These are the low-level drivers missing from the project implementation. They
must be implemented first because the HAL and APP layers depend on them.

| Driver | Hardware responsibility | Required API |
| --- | --- | --- |
| `dio` | Configure/read/write ATmega32 digital pins | `DIO_Init`, `DIO_SetPinDirection`, `DIO_WritePin`, `DIO_ReadPin`, `DIO_TogglePin` |
| `adc` | Read ADC0, ADC1, and ADC2 using AVCC and prescaler 64 | `ADC_Init`, `ADC_StartConversion`, `ADC_GetValue`, `ADC_ReadChannel` |
| `timer` | Timer0 CTC 10 ms tick and Timer2 buzzer PWM bonus | `TIMER0_Init`, `TIMER0_SetCallback`, `TIMER2_InitPwm`, `TIMER2_SetDuty` |
| `counter` | Timer1 external rising-edge pulse counter | `TIMER1_CounterInit`, `TIMER1_ReadCount`, `TIMER1_ResetCount` |
| `exti` | INT0 high-float emergency input and INT1 acknowledge input | `EXTI_Init`, `EXTI_SetCallback`, `EXTI_Enable`, `EXTI_Disable` |
| `usart` | 9600 8N1 serial console and telemetry | `USART_Init`, `USART_SendByte`, `USART_SendString`, `USART_ReadByte`, `USART_SetRxCallback` |
| `spi` | SPI master, mode 0, f/16 for 74HC595 | `SPI_Init`, `SPI_Transmit`, `SPI_TransmitBuffer` |
| `i2c` | TWI master at 100 kHz for PCF8574 LCD adapter | `I2C_Init`, `I2C_Start`, `I2C_Stop`, `I2C_Write`, `I2C_Read` |

### 1.3 HAL drivers

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

### 1.4 APP modules

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

### Member 1: Aya Mohamed Refaat Naguib (System Integrator, FSM & Actuators)
* **MCAL Layer:** `i2c.c`
* **APP Layer:** `tank_fsm.c`, `scheduler` (`main.c`)
* **HAL Layer:** `pump.c`, `valve.c`
* **Responsibilities:**
  * Implements the 10 ms non-blocking tick scheduler in `main.c`.
  * Manages executive FSM transitions (`ST_INIT`, `ST_IDLE`, `ST_FILLING`, `ST_SETTLING`, `ST_RESERVOIR_WAIT`, `ST_TRIPPED`, `ST_MANUAL`, `ST_SERVICE`).
  * Drives output pins (`PB0` for pump contactor, `PB2` for inlet solenoid valve).

### Member 2: Doaa Shaker Mohamed Aziz Awad (Safety Interlocks & Hardware Guards)
* **MCAL Layer:** `usart.c`
* **APP Layer:** `interlocks.c`
* **HAL Layer:** `floats.c`, `buttons.c`
* **LIB Layer:** `STD_TYPES.h`, `BIT_MATH.h`
* **Responsibilities:**
  * Defines common types, data structures, bit macros, and safety enums.
  * Implements `ILK_Evaluate()` prioritizing safety over demand logic.
  * Configures `INT0` falling-edge interrupt for physical high float switch overflow override (direct hardware register shutdown $\le 1\text{ ms}$).
  * Handles software debouncing for Mode (`PD4`), Acknowledge (`PD3`/`INT1`), and Manual Start (`PD5`) buttons.

### Member 3: Samah Ahmed Mahmoud Ahmed (Process Sensing & Demand Logic)
* **APP Layer:** `demand.c`
* **HAL Layer:** `level.c`, `current.c`
* **Responsibilities:**
  * Samples analog channels via ADC MCAL (`ADC0`, `ADC1`, `ADC2`).
  * Implements median-of-3 noise filtering for roof/ground levels and 4-sample moving average for motor current.
  * Calculates hysteresis bounds (pump start $<30\%$, stop $>90\%$).
  * Enforces the 60-second minimum-off anti-cycling protection timer.
### Member 4: Sama Rizk El Saeed Azzam (Telemetry, Memory Logs & Display UI)
* **MCAL Layer:** `spi.c`
* **APP Layer:** `flowmeter.c`, `console.c`
* **HAL Layer:** `lcd_i2c.c`, `bargraph.c`, `shiftreg.c`
* **LIB Layer:** `ring_buffer.c`
* **Responsibilities:**
  * Uses Timer1 in external counter mode (`PB1`/`T1`) to calculate L/min flow rate and track volume.
  * Maintains the 16-entry RAM ring buffer (`FaultRec_t`) for historical trip logging.
  * Controls PCF8574 I2C 16x2 LCD display and SPI 74HC595 shift register status bar.
  * Implements UART telemetry output (5 s periodic frame) and command line parser.

## 4. Shared Integration and Test Ownership

Integration is done together after each member's module passes its local
checklist. The work is split by test area to keep the overall effort balanced:

| Member | Shared test responsibility |
| --- | --- |
| Sama | Timing, ADC values, Timer1 wrap, and CPU-load pin |
| Samah | LCD, UART commands, telemetry frames, SPI, and I2C failure handling |
| Doaa | Button/float debounce, actuator startup state, sensor limits, and scaling |
| Aya | Nine trip scenarios, latch/ACK behavior, hysteresis, flow totaliser, and fault log |

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
