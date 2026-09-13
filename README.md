# Project 03 — Smart Water Tank Controller

> Part of the **Embedded Systems Projects Book** — see the
> [book README](../README.md) for the shared platform baseline, layer rules and
> common rubric. Everything in this file is *in addition to* those rules.

---

## 1. Project Identity

| Field | Value |
|-------|-------|
| **Project code** | `PRJ-03-WATERTANK` |
| **Team size** | 4 students |
| **Team Names** | Sama Rizk El Saeed Azzam<br>Samah Ahmed Mahmoud Ahmed<br>Doaa Shaker Mohamed Aziz Awad<br>Aya Mohamed Refaat Naguib |
| **Build window** | Days 11 – 15 (Sep 13 – Sep 17, 2026) |
| **Demo & submission** | September 17, 2026 |
| **Dominant skill** | Safety interlocks, latched faults, cross-checked sensors |
| **MCU** | ATmega32A @ 8 MHz |
| **Simulator** | SimulIDE 1.x |

---

## 2. Description

### In one sentence

**You are building the controller for a pump that fills a roof tank from a
ground tank — and, much more importantly, all the protections that stop it
destroying itself.**

### What the circuit looks like

```
                    +--------------+
                    |  ROOF TANK   |   <- keep the level between
                    |  ~~~~~~~~~~  |      a low and a high mark
                    +------+-------+
                           ^
                           |  pipe (with a flow sensor)
                        [ PUMP ]
                           ^
                    +------+-------+
                    | GROUND TANK  |   <- must never run dry
                    |  ~~~~~~~~~~  |
                    +--------------+
```

Potentiometers stand in for the roof level, the ground level, the flow through
the pipe, and the pump motor current. Switches stand in for the float switch and
the operator buttons.

### The easy part (about ten lines)

```c
if (roof_level < LOW)  pump = ON;
if (roof_level > HIGH) pump = OFF;
```

That is the whole useful function of the system, and it is **not** the project.
A controller that only does that will destroy a real pump inside a week.

### The actual project: the other 90 %

| What can go wrong | What you must build |
|-------------------|--------------------|
| The ground tank empties while the pump is running | **Dry-run protection** — three separate checks: ground level, flow in the pipe, and motor current |
| The level sensor sticks at "full" | A **float switch** that overrides the analog reading |
| The level sensor sticks at "empty" | A **maximum run time** — no matter what, stop after N minutes |
| The inlet valve jams open | **Overflow detection** |
| A pipe leaks | Level drops while the pump is off and nobody is drawing water |
| The level sits exactly on the set point | **Hysteresis** plus a minimum-off timer |
| The pump seizes | **Over-current trip** |

### The one thing you actually have to get right: a trip is not an alarm

This distinction is the professional lesson of the project, and it is worth
learning properly.

| | **Alarm** | **Trip** |
|---|---|---|
| What it means | "Something looks wrong" | "I have shut down to protect the equipment" |
| Clears itself when the condition goes away? | **Yes** | **Never** |
| How does it clear? | On its own | Only when a **human** presses acknowledge |

Why a trip must latch: suppose the pump trips because the ground tank is dry.
Water sloshes, the sensor reads OK for half a second, and a self-clearing
controller starts the pump again. It runs dry, trips, sloshes, starts, runs dry,
trips... all night. The pump burns out and nobody ever finds out why, because
every time anyone looked, the system seemed fine.

A latched trip stops there, stays stopped, and *tells you what tripped it*. Then
a person looks at the tank, fixes the actual problem, and presses acknowledge.

**Every protection in the table above must latch.**

### The rest of it

- The **LCD** shows level, flow, total volume pumped and the fault history.
- The **serial link** streams status and accepts an acknowledge command.
- The **74HC595** drives an 8-lamp fault and status bar over SPI. The volume
  totaliser and the fault log live in RAM — including a trip
  that is still active.

> **Note on saving.** There is no non-volatile memory in this project — SimulIDE
> has no part that could provide it. One consequence is worth stating plainly:
> **a power cycle clears a latched trip.** On a real controller that is a defeat
> — an operator could "fix" a dry-run trip by switching the panel off and on.
> Name the limitation in your report. See the book README, §4.

---

## 3. Objectives

1. Build a control loop whose safety interlocks are evaluated **before** the
   demand logic, in a fixed priority order.
2. Cross-check three independent sensors (level, flow, current) to distinguish
   *no water* from *no pump* from *no sensor*.
3. Implement latched trips with acknowledgement, and prove they cannot be
   cleared while the cause persists.
4. Count flow-meter pulses with Timer1 in external-counter mode and convert to
   L/min and litres.
5. Enforce minimum-off and maximum-run timers to protect the motor.
6. Maintain a volume totaliser and a 16-entry fault-history ring in RAM.
7. Display a live level bargraph without flicker.

---

## 4. Learning Outcomes

| ID | Outcome |
|----|---------|
| LO-1 | Order interlock, demand and manual logic so that safety always wins, and defend the ordering |
| LO-2 | Configure Timer1 as an external counter on the `T1` pin and read the count atomically |
| LO-3 | Convert a pulse frequency to flow (L/min) and accumulate volume with integer maths |
| LO-4 | Explain the difference between a latching trip and a self-clearing alarm, and implement both |
| LO-5 | Design sensor plausibility checks that detect a stuck-high and a stuck-low transducer |
| LO-6 | Size a minimum-off timer from a motor's thermal limit and justify the value |
| LO-7 | Keep a fixed-size fault-history ring in RAM and dump it on request over UART |

---

## 5. Estimated Duration

| Phase | Hours | Course day |
|-------|:-----:|-----------|
| Requirements analysis, hazard list, pin freeze | 4 | Day 11 |
| Interlock design & state machine | 4 | Day 11 |
| Level/reservoir/current ADC + outputs | 6 | Day 12 |
| Timer0 tick, Timer1 flow counter, timers | 6 | Day 13 |
| LCD, 74HC595 totaliser & fault log, UART | 6 | Day 14 |
| Testing (fault injection) | 5 | Day 15 |
| Documentation, report, video | 4 | Day 15 + evening |
| **Total** | **35 h** | |

---

## 6. Hardware Components

| # | Component | Qty | SimulIDE part | Purpose |
|---|-----------|:---:|---------------|---------|
| 1 | ATmega32A | 1 | `atmega32` | Controller |
| 2 | Potentiometer 10 kΩ | 1 | `Potentiometer` | Roof tank level (0 – 100 %) |
| 3 | Potentiometer 10 kΩ | 1 | `Potentiometer` | Ground reservoir level |
| 4 | Potentiometer 10 kΩ | 1 | `Potentiometer` | Pump motor current (0 – 10 A) |
| 5 | Clock / square-wave source | 1 | `Clock` | Flow-meter pulse train |
| 6 | Switch (SPST) | 2 | `Switch` | High float, low float |
| 7 | Push button | 3 | `Push` | Mode, Acknowledge, Manual-start |
| 8 | LED (green) | 4 | `Led` | Level bargraph 25/50/75/100 % |
| 9 | LED (blue) | 1 | `Led` | Pump running |
| 10 | LED (red) | 1 | `Led` | Fault |
| 11 | Relay / LED | 2 | `Relay` / `Led` | Pump contactor, inlet valve |
| 12 | Buzzer | 1 | `Buzzer` | Trip annunciation |
| 13 | 16×2 LCD + PCF8574 | 1 | `Lcd` + `I2CToParallel` | Local display |
| 14 | 74HC595 shift register | 1 | `74HC595` | 8-LED fault / status lamp bar |
| 15 | Serial terminal | 1 | `SerialPort` | Telemetry + console |

---

## 7. Pin Map

| Signal | Pin | Port bit | Direction | Notes |
|--------|-----|----------|-----------|-------|
| Roof tank level | 40 | `PA0` / ADC0 | Analog in | 0 – 1023 → 0 – 100 % |
| Reservoir level | 39 | `PA1` / ADC1 | Analog in | 0 – 1023 → 0 – 100 % |
| Pump current | 38 | `PA2` / ADC2 | Analog in | 0 – 1023 → 0.0 – 10.0 A |
| Pump contactor | 1 | `PB0` | Out | Active high |
| Flow-meter pulses | 2 | `PB1` / `T1` | In | Timer1 external counter, rising edge |
| Inlet solenoid valve | 3 | `PB2` | Out | Active high |
| Buzzer | 4 | `PB3` / OC0 | Out | PWM tone in bonus |
| 74HC595 `RCLK` | 5 | `PB4` | Out | Rising edge latches the shift register |
| SPI `MOSI` | 6 | `PB5` | Out | |
| SPI `MISO` | 7 | `PB6` | In | |
| SPI `SCK` | 8 | `PB7` | Out | |
| I2C `SCL` | 22 | `PC0` | Out | 4.7 kΩ pull-up |
| I2C `SDA` | 23 | `PC1` | Bidir | 4.7 kΩ pull-up |
| Bargraph 25 % | 24 | `PC2` | Out | |
| Bargraph 50 % | 25 | `PC3` | Out | |
| Bargraph 75 % | 26 | `PC4` | Out | |
| Bargraph 100 % | 27 | `PC5` | Out | |
| Pump-run LED | 28 | `PC6` | Out | |
| Fault LED | 29 | `PC7` | Out | |
| USART `RXD` | 14 | `PD0` | In | 9600 8N1 |
| USART `TXD` | 15 | `PD1` | Out | 9600 8N1 |
| High float switch | 16 | `PD2` / INT0 | In, pull-up | **Hardware overflow guard** |
| Acknowledge button | 17 | `PD3` / INT1 | In, pull-up | Falling edge |
| Mode button | 18 | `PD4` | In, pull-up | Polled + debounced |
| Manual-start button | 19 | `PD5` | In, pull-up | Polled + debounced |
| Low float switch | 20 | `PD6` | In, pull-up | Reservoir empty guard |
| Spare / CPU-load pin | 21 | `PD7` | Out | Timing measurement |

> `PC2` – `PC7` drive the bargraph and status LEDs, so **clear the `JTAGEN`
> fuse** (or set `JTD` twice in `MCUCSR`). Otherwise four of your six LEDs will
> not respond.

---

## 8. Peripherals Used

| Peripheral | Configuration | Role |
|------------|---------------|------|
| **GPIO** | `PB0`, `PB2`, `PC2..PC7` out; floats and buttons in + pull-up | Actuators, indicators, guards |
| **ADC** | Single conversion, prescaler 64, AVCC ref, right adjust | Level ×2, current |
| **Timer0** | CTC, prescaler 1024, `OCR0 = 77` | 10 ms system tick |
| **Timer1** | Normal mode, external clock source on `T1`, rising edge (`CS12:0 = 111`) | Flow-meter pulse counter |
| **Timer2** | Fast PWM (bonus) | Buzzer tone |
| **INT0** | Falling edge | High float switch — overflow guard |
| **INT1** | Falling edge | Acknowledge |
| **USART** | 9600 8N1, RX interrupt | Telemetry + console |
| **SPI** | Master, Mode 0, f/16 | 74HC595 shift register |
| **I2C (TWI)** | Master, 100 kHz | PCF8574 → LCD |

### Flow-meter maths (put this in your report)

A YF-S201-class turbine meter produces **450 pulses per litre**:

```
f(Hz) = 7.5 × Q(L/min)          →      Q(L/min) = pulses_per_second / 7.5
litres = total_pulses / 450
```

Read `TCNT1` once per second, take the difference from the previous read, and
handle the 16-bit wrap with unsigned subtraction:

```c
uint16_t now  = TIMER1_ReadCount();
uint16_t diff = (uint16_t)(now - g_lastCount);   /* wrap-safe */
g_lastCount   = now;
```

At 10 L/min the meter produces 75 Hz — `TCNT1` wraps every ~14.5 minutes, which
the unsigned subtraction handles transparently. Explain why casting to `int16_t`
here would be a bug.

---

## 9. Software Architecture

### 9.1 Layer view

```
┌───────────────────────────────────────────────────────────────────┐
│ APP                                                               │
│  ┌────────────┐ ┌────────────┐ ┌──────────┐ ┌───────┐ ┌────────┐  │
│  │ tank_fsm   │ │ interlocks │ │ demand   │ │ flow  │ │console │  │
│  │            │ │ (priority) │ │ (hyst.)  │ │ meter │ │        │  │
│  └─────┬──────┘ └─────┬──────┘ └────┬─────┘ └───┬───┘ └───┬────┘  │
│        └──────────────┴──── scheduler (10 ms) ──┴─────────┘       │
├───────────────────────────────────────────────────────────────────┤
│ HAL                                                               │
│  level.c  current.c  pump.c  valve.c  bargraph.c  lcd_i2c.c       │
│  shiftreg.c  buttons.c  floats.c                                │
├───────────────────────────────────────────────────────────────────┤
│ MCAL                                                              │
│  dio.c  adc.c  timer.c  counter.c  exti.c  usart.c  spi.c  i2c.c  │
├───────────────────────────────────────────────────────────────────┤
│ LIB    STD_TYPES.h  BIT_MATH.h  ring_buffer.c                     │
└───────────────────────────────────────────────────────────────────┘
```

### 9.2 The interlock chain — the heart of this project

`interlocks.c` exposes exactly one function, called before any demand logic:

```c
/* Returns TRIP_NONE, or the highest-priority active trip.
   Priority order is fixed and documented; do not reorder without
   updating the hazard analysis in the report. */
Trip_t ILK_Evaluate(const TankData_t *d);
```

| Priority | Trip | Condition | Latches |
|:--------:|------|-----------|:-------:|
| 1 | `TRIP_OVERFLOW` | High float active ∨ level ≥ 99 % for 2 s | Yes |
| 2 | `TRIP_OVERCURRENT` | Current > 8.0 A for 500 ms | Yes |
| 3 | `TRIP_DRY_RESERVOIR` | Low float active ∨ reservoir < 10 % | Yes |
| 4 | `TRIP_DRY_RUN` | Pump on ≥ 10 s ∧ flow < 1 L/min | Yes |
| 5 | `TRIP_NO_CURRENT` | Pump on ≥ 3 s ∧ current < 0.5 A | Yes |
| 6 | `TRIP_MAX_RUNTIME` | Continuous run > 15 min | Yes |
| 7 | `TRIP_LEVEL_SENSOR` | ADC0 pinned at 0 or 1023 for 5 s | Yes |
| 8 | `TRIP_LEAK` | Pump off ∧ level fell > 5 % in 60 s | Yes |
| 9 | `TRIP_NO_RISE` | Pump on 120 s ∧ level rose < 2 % | Yes |

The demand controller is only consulted when `ILK_Evaluate()` returns
`TRIP_NONE`. **An interlock check placed after the demand logic loses the
Application-logic marks** — by then the pump is already commanded on.

### 9.3 Module responsibilities

| Module | Owns | Public API (suggested) |
|--------|------|------------------------|
| `tank_fsm` | State, latch, acknowledgement | `FSM_Init`, `FSM_Run`, `FSM_GetState`, `FSM_Ack` |
| `interlocks` | Trip evaluation + per-trip timers | `ILK_Evaluate`, `ILK_Reset` |
| `demand` | Level hysteresis, min-off timer | `DMD_WantPump(levelPct)` |
| `flowmeter` | Timer1 delta, L/min, totaliser | `FLW_Update1Hz`, `FLW_GetLpm`, `FLW_GetLitres` |
| `level` | ADC scaling, plausibility, rate-of-change | `LVL_Get`, `LVL_RatePerMin` |
| `pump` | Contactor + run-time accounting | `PMP_Set`, `PMP_RunSeconds`, `PMP_Cycles` |
| `bargraph` | Four LEDs from one percentage | `BAR_Show(pct)` |
| `faultlog` | Fixed 16-entry ring in RAM | `FLG_Append`, `FLG_Dump` |

### 9.4 Concurrency contract

- The high float switch is wired to `INT0` so overflow is caught even if the
  scheduler is starved. The ISR **immediately** clears `PB0` (pump) and `PB2`
  (valve) with a direct register write, then sets a flag. This is the single
  documented exception to the layer rule — justify it in your report.
- `TCNT1` is read with interrupts disabled (16-bit register, `TEMP` shadow).
- All trip timers live in `interlocks.c` and advance only from the 10 ms task.

---

## 10. Data Dictionary (required data)

### 10.1 Runtime data — `DD-01 TankData_t`

```c
typedef struct {
    uint16_t levelRaw;        /* ADC0                                   */
    uint16_t reservoirRaw;    /* ADC1                                   */
    uint16_t currentRaw;      /* ADC2                                   */
    uint8_t  levelPct;        /* 0..100 %                               */
    uint8_t  reservoirPct;    /* 0..100 %                               */
    uint16_t currentmA;       /* 0..10000 mA                            */
    uint16_t flowLpmX10;      /* L/min × 10  (e.g. 87 = 8.7 L/min)      */
    uint32_t totalLitres;     /* lifetime totaliser                     */
    int8_t   levelRatePctMin; /* signed rate of change, %/min           */
    uint8_t  pumpOn    : 1;
    uint8_t  valveOn   : 1;
    uint8_t  highFloat : 1;   /* debounced                              */
    uint8_t  lowFloat  : 1;   /* debounced                              */
    uint8_t  reserved  : 4;
    uint8_t  state;           /* TankState_t                            */
    uint8_t  activeTrip;      /* Trip_t, 0 = none                       */
    uint16_t pumpRunSec;      /* current continuous run                 */
    uint32_t pumpTotalSec;    /* lifetime                               */
    uint16_t pumpCycles;      /* lifetime start count                   */
    uint32_t upTimeSec;
} TankData_t;
```

### 10.2 Runtime configuration — `DD-02 TankCfg_t`

```c
#define TNK_MAGIC   0x5754u      /* 'W','T'                             */
#define TNK_VERSION 0x01u

typedef struct {
    uint16_t magic;
    uint8_t  version;
    uint8_t  startPct;           /* pump ON  below this   (default 30)  */
    uint8_t  stopPct;            /* pump OFF above this   (default 90)  */
    uint8_t  reserveMinPct;      /* reservoir trip level  (default 10)  */
    uint8_t  overflowPct;        /* overflow trip         (default 99)  */
    uint8_t  overCurrentA_X10;   /* 0.1 A units           (default 80)  */
    uint8_t  minCurrentA_X10;    /* 0.1 A units           (default  5)  */
    uint8_t  minFlowLpm;         /* dry-run flow floor    (default  1)  */
    uint16_t maxRunSec;          /* max continuous run    (default 900) */
    uint16_t minOffSec;          /* anti-cycling          (default  60) */
    uint8_t  leakDropPct;        /* leak trip drop        (default   5) */
    uint32_t totalLitres;        /* totaliser, zeroed at power-on       */
    uint32_t pumpTotalSec;
    uint16_t pumpCycles;
    uint8_t  faultHead;          /* ring index 0..15                    */
    uint8_t  checksum;
} TankCfg_t;                     /* 30 bytes                            */
```

### 10.3 Fault record — `DD-03 FaultRec_t`

```c
typedef struct {
    uint8_t  trip;            /* Trip_t                                 */
    uint32_t timeSec;         /* uptime at trip                         */
    uint8_t  levelPct;        /* snapshot                               */
    uint8_t  reservoirPct;
    uint16_t currentmA;
} FaultRec_t;                 /* 9 bytes; 16 of these = 144 B of RAM    */
```

### 10.4 Enumerations — `DD-04`

```c
typedef enum { ST_INIT = 0, ST_IDLE, ST_FILLING, ST_SETTLING,
               ST_RESERVOIR_WAIT, ST_TRIPPED, ST_MANUAL,
               ST_SERVICE }                                  TankState_t;

typedef enum { TRIP_NONE = 0, TRIP_OVERFLOW, TRIP_OVERCURRENT,
               TRIP_DRY_RESERVOIR, TRIP_DRY_RUN, TRIP_NO_CURRENT,
               TRIP_MAX_RUNTIME, TRIP_LEVEL_SENSOR, TRIP_LEAK,
               TRIP_NO_RISE }                                Trip_t;
```

### 10.5 Derived constants — `DD-05`

| Constant | Value | Meaning |
|----------|-------|---------|
| `LEVEL_SCALE` | `(uint16_t)(((uint32_t)raw * 100u) / 1023u)` | ADC → % |
| `CURRENT_SCALE` | `(uint16_t)(((uint32_t)raw * 10000u) / 1023u)` | ADC → mA (0 – 10 A) |
| `PULSES_PER_LITRE` | 450 | Flow meter constant |
| `FLOW_DIVISOR` | 75 | `Lpm×10 = pulses_per_sec × 10 / 7.5` → `× 4 / 3` |
| `DRY_RUN_DELAY_S` | 10 | Grace before a dry-run trip |
| `NO_CURRENT_DELAY_S` | 3 | Grace before a no-current trip |
| `OVERCURRENT_MS` | 500 | Over-current confirm time |
| `MIN_OFF_SEC` | 60 | Anti-cycling |
| `MAX_RUN_SEC` | 900 | 15 min |
| `SETTLE_SEC` | 5 | Level settle after stopping |
| `ACK_HOLD_TICKS` | 100 | 1 s acknowledge press |

> **Overflow trap (again).** `raw * 10000` reaches 10 230 000 — far past
> `uint16_t` and past `int32_t` only if you are careless. Cast to `uint32_t`
> **before** the multiply, not after.

---

## 11. System Specifications

### 11.1 Roof tank level bands

| Band | Range | Meaning |
|------|-------|---------|
| Critical low | 0 – 9 % | Pump on, `LOW` warning on LCD |
| Low | 10 – 29 % | Pump on |
| Normal | 30 – 89 % | Hysteresis zone — state held |
| High | 90 – 98 % | Pump off |
| Overflow | 99 – 100 % | **Trip** |

### 11.2 Reservoir bands

| Band | Range | Meaning |
|------|-------|---------|
| Empty | 0 – 9 % | `TRIP_DRY_RESERVOIR` |
| Low | 10 – 24 % | Pumping allowed, `RES LOW` warning |
| OK | 25 – 100 % | Normal |

### 11.3 Motor current bands

| Band | Range | Meaning |
|------|-------|---------|
| No current | 0.0 – 0.4 A | `TRIP_NO_CURRENT` (open circuit / contactor fault) |
| Unloaded | 0.5 – 1.9 A | Running dry — corroborates a dry-run trip |
| Normal | 2.0 – 7.9 A | Healthy |
| Over-current | ≥ 8.0 A | `TRIP_OVERCURRENT` (stall / blockage) |

### 11.4 Control set points and timers

| Parameter | Default | Range |
|-----------|:-------:|-------|
| Start level | 30 % | 5 – 80 % |
| Stop level | 90 % | 20 – 98 % |
| Hysteresis band | 60 % | ≥ 10 % enforced |
| Minimum off time | 60 s | 10 – 600 s |
| Maximum continuous run | 900 s | 60 – 3600 s |
| Settle time after stop | 5 s | fixed |

### 11.5 Trip clearing rules

| Trip | Clears when acknowledged **and** |
|------|----------------------------------|
| `TRIP_OVERFLOW` | Level ≤ 95 % ∧ high float released |
| `TRIP_OVERCURRENT` | Current < 1.0 A (pump off) |
| `TRIP_DRY_RESERVOIR` | Reservoir ≥ 25 % ∧ low float released |
| `TRIP_DRY_RUN` | Reservoir ≥ 25 % |
| `TRIP_NO_CURRENT` | — (acknowledge alone; it is an electrical fault) |
| `TRIP_MAX_RUNTIME` | Minimum-off timer expired |
| `TRIP_LEVEL_SENSOR` | Reading back in 1 – 1022 for 5 s |
| `TRIP_LEAK` | — (acknowledge alone; operator must inspect) |
| `TRIP_NO_RISE` | — (acknowledge alone) |

---

## 12. Inputs & Outputs

### 12.1 Inputs

| ID | Name | Channel | Type | Sample rate |
|----|------|---------|------|-------------|
| IN-1 | Roof tank level | ADC0 | Analog 0 – 100 % | 10 Hz |
| IN-2 | Reservoir level | ADC1 | Analog 0 – 100 % | 10 Hz |
| IN-3 | Pump current | ADC2 | Analog 0 – 10 A | 20 Hz |
| IN-4 | Flow pulses | `PB1`/`T1` | Pulse train | Counted continuously, read 1 Hz |
| IN-5 | High float | `PD2`/INT0 | Digital, edge | Interrupt + 50 ms debounce |
| IN-6 | Low float | `PD6` | Digital, polled | 20 Hz |
| IN-7 | Acknowledge | `PD3`/INT1 | Digital, edge | Interrupt |
| IN-8 | Mode | `PD4` | Digital, polled | 100 Hz |
| IN-9 | Manual start | `PD5` | Digital, polled | 100 Hz |
| IN-10 | Console | USART RX | ASCII line | Interrupt |

### 12.2 Outputs

| ID | Name | Pin | Type | Meaning |
|----|------|-----|------|---------|
| OUT-1 | Pump contactor | `PB0` | Digital | High = pump running |
| OUT-2 | Inlet valve | `PB2` | Digital | High = valve open |
| OUT-3 | Bargraph | `PC2`…`PC5` | Digital ×4 | 25 / 50 / 75 / 100 % |
| OUT-4 | Pump-run LED | `PC6` | Digital | Steady on while pumping |
| OUT-5 | Fault LED | `PC7` | Digital | Steady = latched trip, 1 Hz blink = warning |
| OUT-6 | Buzzer | `PB3` | Digital / PWM | Trip annunciation |
| OUT-7 | LCD | I2C | 16×2 text | Level, flow, state |
| OUT-8 | Telemetry | USART TX | ASCII | Every 5 s + events |

---

## 13. Functional Requirements

### FR-01 — Level acquisition

The system **shall** sample ADC0 every **100 ms** and publish the roof tank level
as 0 – 100 %, median-of-3 filtered.

**Acceptance criteria**
- Conversion ≤ 120 µs; resolution 1 %.
- The published value is stable to ±1 % with a fixed input over 60 s.
- Integer scaling only, with a `uint32_t` intermediate.

### FR-02 — Reservoir acquisition

The system **shall** sample ADC1 every **100 ms** and publish the reservoir level
as 0 – 100 %, median-of-3 filtered.

### FR-03 — Motor current acquisition

The system **shall** sample ADC2 every **50 ms** and publish the pump current in
milliamps (0 – 10 000 mA).

**Acceptance criteria**
- Faster sampling than the levels — over-current must be caught in 500 ms.
- A 4-sample moving average is applied before the trip comparison, so a single
  noisy conversion cannot trip the pump.

### FR-04 — Flow measurement

The system **shall** count flow-meter pulses with Timer1 in external-counter mode
and compute flow every **1 s**.

**Acceptance criteria**
- `Q(L/min) = pulses_per_second / 7.5`, reported to 0.1 L/min.
- The 16-bit counter wrap is handled by unsigned subtraction — verified by
  running the meter past 65 535 pulses.
- `TCNT1` is read atomically.
- Total volume `= totalPulses / 450` litres, accumulated into a `uint32_t`.

### FR-05 — Pump demand (hysteresis + anti-cycling)

When no trip is active and the mode is `AUTO`, the system **shall** request the
pump as:

```
level < cfg.startPct  (default 30 %)  → request ON
level > cfg.stopPct   (default 90 %)  → request OFF
otherwise                             → hold
```

**Acceptance criteria**
- `stopPct − startPct ≥ 10` is enforced; a violating `SET` returns `ERR RANGE`.
- After the pump stops, it **shall not** restart for `minOffSec` (default 60 s)
  even if the level is below `startPct`. The LCD shows `WAIT 42s`.
- A slow sweep across the band produces exactly one ON edge and one OFF edge.
- Holding the level at 50 % for 5 min produces zero transitions.

### FR-06 — Interlock evaluation order

The system **shall** evaluate all interlocks of §9.2 **before** the demand logic,
every **10 ms**, in the stated priority order.

**Acceptance criteria**
- `ILK_Evaluate()` is called first in the FSM tick; code inspection confirms it.
- When two trips are simultaneously true, the higher-priority one is reported.
- Any active trip drives the pump and valve outputs low within **100 ms**.

### FR-07 — Overflow protection (dual path)

The system **shall** trip on overflow via **two independent paths**: the high
float switch on `INT0`, and the analog level ≥ `overflowPct` for 2 s.

**Acceptance criteria**
- The `INT0` ISR clears the pump and valve outputs directly, before any
  scheduler involvement — measured response ≤ 1 ms.
- Either path alone raises `TRIP_OVERFLOW`.
- Disconnecting the analog sensor (stuck low) and asserting the float still trips
  — this is the test that proves the redundancy.

### FR-08 — Dry-run protection (triple cross-check)

The system **shall** detect a dry-running pump from three independent signals:
reservoir level, flow rate, and motor current.

**Acceptance criteria**
- Reservoir < `reserveMinPct` **or** low float asserted → `TRIP_DRY_RESERVOIR`
  immediately, and the pump is prevented from starting at all.
- Pump on ≥ 10 s with flow < `minFlowLpm` → `TRIP_DRY_RUN`.
- Pump on ≥ 3 s with current < `minCurrentA_X10` → `TRIP_NO_CURRENT`.
- The UART event names which signal caused the trip.

### FR-09 — Over-current protection

Current above `overCurrentA_X10` (default 8.0 A) sustained for **500 ms**
**shall** raise `TRIP_OVERCURRENT`.

**Acceptance criteria**
- A 200 ms spike does **not** trip (proves the confirm timer).
- A sustained 8.5 A trips within 600 ms.
- Pump output goes low within 100 ms of the trip.

### FR-10 — Maximum run-time protection

A continuous run exceeding `maxRunSec` (default 900 s) **shall** raise
`TRIP_MAX_RUNTIME`.

**Acceptance criteria**
- The timer resets only when the pump actually stops, not on state changes.
- For the demo the limit may be reduced via `SET MAXRUN 60`; the test must show
  the trip firing at that value.

### FR-11 — Level sensor plausibility

If ADC0 reads `0` or `1023` continuously for **5 s**, the system **shall** raise
`TRIP_LEVEL_SENSOR`.

**Acceptance criteria**
- The pump is stopped; the float switches remain the only trusted level source.
- The trip clears when the reading returns to 1 – 1022 for 5 s **and** is
  acknowledged.

### FR-12 — Leak detection

With the pump off, a level drop greater than `leakDropPct` (default 5 %) within
**60 s** **shall** raise `TRIP_LEAK`.

**Acceptance criteria**
- The check is suppressed for `SETTLE_SEC` after the pump stops (sloshing).
- The check is suppressed entirely in `ST_MANUAL` and `ST_SERVICE`.
- Normal household draw must not false-trip: document the rate you chose and
  why.

### FR-13 — No-rise detection

If the pump runs for 120 s and the level rises by less than 2 %, the system
**shall** raise `TRIP_NO_RISE`.

**Acceptance criteria**
- Detects a blocked delivery pipe or a closed isolation valve that the flow
  meter alone would not catch (meter upstream of the blockage).

### FR-14 — Trip latching and acknowledgement

Every trip **shall** latch. It clears only when the operator acknowledges **and**
the per-trip clearing condition of §11.5 is satisfied.

**Acceptance criteria**
- Acknowledgement = press `PD3` for ≥ 1 s, or send `ACK`.
- Acknowledging while the cause persists returns `ERR ACTIVE` and leaves the
  trip latched.
- The fault LED is steady while latched; the buzzer sounds 200 ms on / 800 ms
  off until acknowledged, then goes silent even if the trip is still latched.
- Every trip is appended to the fault log (FR-18).

### FR-15 — Manual mode

Pressing the Mode button **shall** toggle `AUTO ↔ MANUAL`.

**Acceptance criteria**
- In `MANUAL` the demand logic is bypassed; the Manual-start button and the
  `PUMP ON|OFF` command control the pump directly.
- **All interlocks remain active in `MANUAL`.** A manual start into a dry
  reservoir is refused with `ERR INTERLOCK`.
- Entering `MANUAL` does not change the current pump output.
- The mode is shown on the LCD and in the telemetry frame.

### FR-16 — Service mode

The command `SERVICE ON` **shall** enter `ST_SERVICE`, in which the pump is
forced off, the valve is forced closed, and the leak and no-rise checks are
suspended.

**Acceptance criteria**
- Overflow, over-current and dry-reservoir interlocks **remain** active.
- `SERVICE OFF` returns to `ST_IDLE`; the minimum-off timer restarts.
- Service mode is logged at entry and exit.

### FR-17 — LCD display

The LCD **shall** refresh every **500 ms**:

```
Line 1: L:72% R:55% 8.4A
Line 2: FILL  Q:9.3 12345L
```

**Acceptance criteria**
- In `ST_TRIPPED` line 2 becomes `!TRIP: DRY RESERVOIR` alternating with the
  data line every 1.5 s.
- In the anti-cycling wait, line 2 shows `WAIT 42s`.
- Only changed characters are rewritten — no full clear per refresh.

### FR-18 — Fault log

The system **shall** keep a **16-entry ring buffer** of fault records in RAM.

**Acceptance criteria**
- Each record holds trip code, uptime, level, reservoir level and current.
- The ring wraps; the newest entry overwrites the oldest.
- `FAULTS?` dumps all 16 records newest-first over UART.
- The log holds the last 16 faults since power-on.

### FR-19 — Volume totaliser

The system **shall** accumulate `totalLitres`, `pumpTotalSec` and `pumpCycles` in
RAM and report them on demand over
the console on request, and emitted immediately over UART on every trip.

**Acceptance criteria**
- Values accumulate from power-on; the arithmetic must not overflow in 30 days
  is not.
- Write throttling is present (unthrottled writes are a design defect).

### FR-20 — Telemetry and console

The system **shall** transmit the frame of §18.1 every **5 s** and accept the
commands of §18.2, following the book's parser robustness rules.

---

## 14. Non-Functional Requirements

| ID | Requirement |
|----|-------------|
| **NFR-01** | Compiles with `avr-gcc -std=c99 -Wall -Wextra -Os`, zero warnings. |
| **NFR-02** | No blocking delay > 10 ms in the super-loop; `_delay_ms` only in `*_Init()`. |
| **NFR-03** | Interlocks are evaluated before demand logic, always, in every path. |
| **NFR-04** | Any trip drives the pump output low within **100 ms**; the `INT0` overflow path within **1 ms**. |
| **NFR-05** | No floating-point arithmetic; flow and current use scaled integers. |
| **NFR-06** | All set points, timers and trip limits live in `config.h` / `TankCfg_t`. |
| **NFR-07** | Layer rule respected, with the one documented `INT0` exception. |
| **NFR-08** | ISRs ≤ 10 lines; the `INT0` ISR does exactly two register writes and one flag set. |
| **NFR-09** | 16-bit timer registers are accessed atomically. |
| **NFR-10** | The fault ring is a fixed array in RAM — its length never changes at run time. |
| **NFR-11** | Tick jitter ≤ ±1 ms; CPU load ≤ 60 %, measured on `PD7`. |
| **NFR-12** | `.data + .bss` ≤ 1 KB. |
| **NFR-14** | The controller must reach a safe state (pump off, valve closed) on **any** reset, before any sensor is trusted. |
| **NFR-15** | A latched trip must survive a **watchdog reset** — keep `activeTrip` in a `.noinit` variable and re-check `MCUCSR` at boot. |
| **NFR-16** | **No dynamic memory.** `malloc`, `calloc`, `realloc`, `free`, `alloca` and variable-length arrays are banned. Every buffer, table, queue and log is a fixed-size array whose length is a `#define` in `config.h`. Prove it: `avr-nm main.elf \| grep -i malloc` must print nothing. |
| **NFR-17** | **No recursion.** No function may call itself, directly or through any chain of calls — the call graph must be acyclic. Every search, scan, parse and traversal is written as a loop. State your worst-case stack depth in the report. |

---

## 15. Operating Modes

| Mode | Entered by | Demand logic | Interlocks | Pump control |
|------|-----------|:------------:|:----------:|--------------|
| `ST_INIT` | Power-on / reset | — | — | Forced off |
| `ST_IDLE` | Init done, level satisfied | Active | Active | Off |
| `ST_FILLING` | Demand ON | Active | Active | On |
| `ST_SETTLING` | Pump just stopped | Suspended 5 s | Active | Off |
| `ST_RESERVOIR_WAIT` | Reservoir low but not empty | Suspended | Active | Off |
| `ST_TRIPPED` | Any trip | Suspended | Active | Forced off |
| `ST_MANUAL` | Mode button / `MODE MANUAL` | Bypassed | **Active** | Operator |
| `ST_SERVICE` | `SERVICE ON` | Bypassed | Partly (see FR-16) | Forced off |

---

## 16. System Flow

```
        ┌──────────────┐
        │  Power ON    │
        └──────┬───────┘
               ▼
   ┌────────────────────────────────────┐
   │ FIRST ACTION: PB0 = 0, PB2 = 0     │   ← before anything else
   │ (pump and valve off, DDR set out)  │
   └──────┬─────────────────────────────┘
          ▼
   ┌────────────────────────────────────┐
   │ MCAL init: ADC, T0, T1 counter,    │
   │ EXTI, USART, SPI, I2C              │
   └──────┬─────────────────────────────┘
          ▼
   ┌────────────────────────────────────┐  invalid  ┌──────────────┐
   │ Load TankCfg_t, verify CRC         ├──────────▶│ Defaults +   │
   └──────┬─────────────────────────────┘           │ log          │
          │ valid                                   └──────┬───────┘
          ▼◀─────────────────────────────────────────────── ┘
   ┌────────────────────────────────────┐
   │ Clear trip state, load defaults    │
   │ If a trip was latched → ST_TRIPPED │
   └──────┬─────────────────────────────┘
          ▼
╔════════════════════════════════════════════════════════════╗
║             SUPER-LOOP (dispatch on 10 ms tick)            ║
║                                                            ║
║   10 ms → buttons, floats, ILK_Evaluate(), tank FSM        ║
║   50 ms → ADC2 current + moving average                    ║
║  100 ms → ADC0/ADC1 levels + median filter                 ║
║  500 ms → LCD repaint, bargraph                            ║
║    1 s  → flow calc, totaliser, rate-of-change, run timers ║
║    5 s  → telemetry frame                                  ║
║  event  → fault log append, trip annunciation              ║
╚════════════════════════════════════════════════════════════╝
```

---

## 17. State Machine

### 17.1 Diagram

```
                     ┌──────────────┐
          power on   │   ST_INIT    │  outputs forced off
         ───────────▶│              │
                     └──────┬───────┘
                            │ init done, no latched trip
                            ▼
                  ┌────────────────────┐
       ┌─────────▶│      ST_IDLE       │◀──────────┐
       │          └─────┬──────────┬───┘           │
       │  level>stop    │          │ level<start   │ min-off
       │  (via SETTLE)  │          │ && off-timer  │ expired
       │                │          ▼               │
       │                │   ┌────────────────┐     │
       │                │   │   ST_FILLING   │     │
       │                │   └───┬────────┬───┘     │
       │                │       │        │ reservoir low
       │  ┌─────────────┴───────┘        ▼         │
       │  │        level > stopPct  ┌──────────────────────┐
       │  ▼                         │ ST_RESERVOIR_WAIT    │
       │ ┌──────────────┐           └──────────┬───────────┘
       │ │ ST_SETTLING  │  5 s                 │ reservoir OK
       │ └──────┬───────┘──────────────────────┘
       └────────┘
                      any trip (from ANY state)
       ┌──────────────────────────────────────────────────┐
       │                  ST_TRIPPED                      │
       │  pump off, valve closed, cause latched, logged   │
       └──────────┬───────────────────────────────────────┘
                  │ ACK && cause cleared (§11.5)
                  ▼
               ST_IDLE

   ST_IDLE / ST_FILLING ──MODE btn──▶ ST_MANUAL ──MODE btn──▶ ST_IDLE
   any                  ──SERVICE ON──▶ ST_SERVICE ──SERVICE OFF──▶ ST_IDLE
```

### 17.2 Transition table

| # | From | Event / guard | To | Actions |
|---|------|---------------|----|---------|
| T1 | `ST_INIT` | Init done ∧ no latched trip | `ST_IDLE` | Log `!EVT,BOOT` |
| T2 | `ST_INIT` | Interlock already unsafe at boot | `ST_TRIPPED` | Latch cause, log `!EVT,TRIP,BOOT` |
| T3 | `ST_IDLE` | `level < startPct` ∧ off-timer expired ∧ no trip | `ST_FILLING` | Pump on, valve open, `pumpCycles++` |
| T4 | `ST_IDLE` | `level < startPct` ∧ off-timer running | `ST_IDLE` | LCD `WAIT ns` |
| T5 | `ST_FILLING` | `level > stopPct` | `ST_SETTLING` | Pump off, start settle + min-off timers |
| T6 | `ST_FILLING` | Reservoir < `reserveMinPct` but low float clear | `ST_RESERVOIR_WAIT` | Pump off, log warning |
| T7 | `ST_RESERVOIR_WAIT` | Reservoir ≥ 25 % | `ST_IDLE` | — |
| T8 | `ST_RESERVOIR_WAIT` | Low float asserts | `ST_TRIPPED` | `TRIP_DRY_RESERVOIR` |
| T9 | `ST_SETTLING` | 5 s elapsed | `ST_IDLE` | Enable leak check |
| T10 | any | `ILK_Evaluate() != TRIP_NONE` | `ST_TRIPPED` | Pump + valve off, latch, log, buzzer |
| T11 | `ST_TRIPPED` | ACK ∧ clearing condition met | `ST_IDLE` | Clear latch, silence, start min-off timer |
| T12 | `ST_TRIPPED` | ACK ∧ cause still active | `ST_TRIPPED` | `ERR ACTIVE`, silence buzzer only |
| T13 | `ST_IDLE` ∨ `ST_FILLING` | Mode button | `ST_MANUAL` | Hold current outputs |
| T14 | `ST_MANUAL` | Mode button | `ST_IDLE` | Pump off, start min-off timer |
| T15 | `ST_MANUAL` | Manual start ∧ interlocks clear | `ST_MANUAL` | Pump on |
| T16 | `ST_MANUAL` | Manual start ∧ interlock active | `ST_MANUAL` | Refuse, `ERR INTERLOCK` |
| T17 | any | `SERVICE ON` | `ST_SERVICE` | Force outputs off, suspend leak/no-rise |
| T18 | `ST_SERVICE` | `SERVICE OFF` | `ST_IDLE` | Restart min-off timer |

---

## 18. UART Protocol

**Link:** 9600 8N1. Device sends `\r\n`; accepts `\r`, `\n`, `\r\n`.

### 18.1 Telemetry frame (every 5 s)

```
$WT,L=72,R=55,I=8400,Q=93,V=12345,P=1,V2=1,ST=FILL,TR=0,RUN=245,UP=7200*3A
```

| Field | Meaning | Units |
|-------|---------|-------|
| `L` | Roof tank level | % |
| `R` | Reservoir level | % |
| `I` | Pump current | mA |
| `Q` | Flow rate ×10 | L/min ×10 |
| `V` | Lifetime volume | litres |
| `P` | Pump output | 0/1 |
| `V2` | Valve output | 0/1 |
| `ST` | `INIT`\|`IDLE`\|`FILL`\|`SETL`\|`RWAIT`\|`TRIP`\|`MAN`\|`SVC` | |
| `TR` | Active trip code (`Trip_t`) | 0 – 9 |
| `RUN` | Current continuous run | s |
| `UP` | Uptime | s |
| `*3A` | XOR checksum between `$` and `*` | |

### 18.2 Command set

| Command | Response | Effect |
|---------|----------|--------|
| `STATUS` | telemetry frame | Immediate report |
| `LEVEL?` | `LEVEL=72` | |
| `FLOW?` | `FLOW=9.3` | |
| `VOLUME?` | `VOLUME=12345` | Lifetime litres |
| `CURRENT?` | `CURRENT=8400` | mA |
| `CFG?` | `CFG=30,90,10,99,80,5,1,900,60,5` | All set points in `TankCfg_t` order |
| `SET START <n>` | `OK` / `ERR RANGE` | 5 – 80 %, must be ≤ `STOP` − 10 |
| `SET STOP <n>` | `OK` / `ERR RANGE` | 20 – 98 % |
| `SET RESERVE <n>` | `OK` / `ERR RANGE` | 5 – 50 % |
| `SET OVERCUR <n>` | `OK` / `ERR RANGE` | 0.1 A units, 20 – 100 |
| `SET MINFLOW <n>` | `OK` / `ERR RANGE` | 0 – 20 L/min |
| `SET MAXRUN <n>` | `OK` / `ERR RANGE` | 60 – 3600 s |
| `SET MINOFF <n>` | `OK` / `ERR RANGE` | 10 – 600 s |
| `SET LEAK <n>` | `OK` / `ERR RANGE` | 1 – 50 % |
| `MODE AUTO` / `MODE MANUAL` | `OK` | |
| `PUMP ON` / `PUMP OFF` | `OK` / `ERR MODE` / `ERR INTERLOCK` | Manual only |
| `VALVE ON` / `VALVE OFF` | `OK` / `ERR MODE` | Manual only |
| `SERVICE ON` / `SERVICE OFF` | `OK` | |
| `ACK` | `OK` / `ERR ACTIVE` | Acknowledge the latched trip |
| `TRIP?` | `TRIP=3,DRY_RESERVOIR` | Active trip code and name |
| `FAULTS?` | 16 log lines, newest first | `FLT,n,trip,timeSec,L,R,I` |
| `CLRFAULTS` | `OK` | Erase the fault ring |
| `HELP` | command list | |

### 18.3 Asynchronous events

```
!EVT,BOOT
!EVT,PUMP,ON
!EVT,PUMP,OFF,LEVEL
!EVT,TRIP,DRY_RESERVOIR,L=18,R=6,I=1200
!EVT,TRIP,OVERCURRENT,I=8700
!EVT,TRIP,RESTORED,OVERFLOW
!EVT,ACK,OK
!EVT,ACK,REFUSED,ACTIVE
!EVT,MODE,MANUAL
!EVT,SERVICE,ON
!EVT,WAIT,MINOFF,42
!EVT,SAVE,OK
```

---

## 19. Task Scheduling

| ID | Task | Period | Offset | Budget | Work |
|----|------|:------:|:------:|:------:|------|
| T-1 | `Task_Inputs` | 10 ms | 0 | 150 µs | Buttons, floats, debounce |
| T-2 | `Task_Interlocks` | 10 ms | 0 | 250 µs | `ILK_Evaluate` + trip timers |
| T-3 | `Task_FSM` | 10 ms | 0 | 200 µs | One `switch` pass |
| T-4 | `Task_Current` | 50 ms | 1 | 300 µs | ADC2 + 4-sample average |
| T-5 | `Task_Levels` | 100 ms | 2 | 800 µs | ADC0/ADC1 + median-3 |
| T-6 | `Task_Display` | 500 ms | 4 | 4 ms | LCD + bargraph |
| T-7 | `Task_1Hz` | 1 s | 6 | 600 µs | Flow, totaliser, rates, run timers |
| T-8 | `Task_Report` | 5 s | 8 | 2 ms | Telemetry frame |
| T-9 | `Task_Console` | 20 ms | 3 | 500 µs | Parse one line |

**Ordering matters:** T-2 must run before T-3 in the same tick. Encode that in
the task table order, and say so in your report.

---

## 20. Testing Requirements

Fault injection is the point of this project's test plan — most rows below make
something go *wrong*.

| ID | Test | Method | Pass criterion |
|----|------|--------|----------------|
| TC-01 | Safe state on reset | Reset with pump on | `PB0`/`PB2` low within 1 ms of reset |
| TC-02 | Cold boot | Power on | Defaults, `!EVT,CFG,DEFAULT` |
| TC-03 | Live set-point change | `SET START 25`, watch the pump | Starts at the new level |
| TC-04 | Corrupted config | Flip a byte | Defaults, no crash |
| TC-05 | Level scaling | Pot at 0 / 50 / 100 % | 0, 50±1, 100 % |
| TC-06 | Current scaling | Pot at 0 / 50 / 100 % | 0, 5000±100, 10000 mA |
| TC-07 | Flow calculation | 75 Hz pulse train | `Q=10.0` L/min ±0.2 |
| TC-08 | Counter wrap | Run past 65 535 pulses | Volume keeps increasing correctly |
| TC-09 | Volume totaliser | 4500 pulses | `VOLUME` +10 L |
| TC-10 | Pump start | Level to 25 % | Pump on within 200 ms |
| TC-11 | Pump stop | Level to 95 % | Pump off within 200 ms |
| TC-12 | Hysteresis | Hold level 50 %, 5 min | Zero transitions |
| TC-13 | Anti-cycling | Stop, immediately drop level | No restart for 60 s, `WAIT ns` on LCD |
| TC-14 | Hysteresis guard | `SET STOP 35` with `START`=30 | `ERR RANGE` |
| TC-15 | **Overflow via float** | Assert high float | Pump + valve off ≤ 1 ms, `TRIP_OVERFLOW` |
| TC-16 | **Overflow via analog** | Level to 100 % for 3 s | Same trip |
| TC-17 | Overflow redundancy | Stick level sensor at 0, assert float | Still trips |
| TC-18 | Over-current spike | 8.5 A for 200 ms | **No** trip |
| TC-19 | Over-current sustained | 8.5 A for 1 s | `TRIP_OVERCURRENT` within 600 ms |
| TC-20 | Dry reservoir | Reservoir to 5 % | `TRIP_DRY_RESERVOIR`, pump refuses to start |
| TC-21 | Low float | Assert low float | Same trip regardless of the analog reading |
| TC-22 | Dry run | Pump on, flow 0 for 12 s | `TRIP_DRY_RUN` |
| TC-23 | No current | Pump on, current 0.2 A for 4 s | `TRIP_NO_CURRENT` |
| TC-24 | Max run-time | `SET MAXRUN 60`, run 65 s | `TRIP_MAX_RUNTIME` |
| TC-25 | Level sensor stuck high | Pin ADC0 at 1023 for 6 s | `TRIP_LEVEL_SENSOR` |
| TC-26 | Level sensor stuck low | Pin ADC0 at 0 for 6 s | Same trip |
| TC-27 | Leak | Pump off, drop level 8 % in 30 s | `TRIP_LEAK` |
| TC-28 | Leak suppressed on settle | Drop level within 5 s of stopping | No trip |
| TC-29 | No rise | Pump on 130 s, level flat | `TRIP_NO_RISE` |
| TC-30 | Trip priority | Force overflow + dry reservoir together | `TRIP_OVERFLOW` reported |
| TC-31 | Latch persists | Trip, then clear the cause | Trip stays latched |
| TC-32 | ACK refused | ACK while cause active | `ERR ACTIVE`, still latched |
| TC-33 | ACK accepted | Clear cause, then ACK | Returns to `ST_IDLE` |
| TC-34 | Latch survives watchdog | Trip, force a WDT reset | Boots into `ST_TRIPPED` with the same cause |
| TC-35 | Buzzer silence | ACK a still-active trip | Buzzer silent, LED still on |
| TC-36 | Manual interlocks | `MANUAL`, dry reservoir, `PUMP ON` | `ERR INTERLOCK` |
| TC-37 | Manual normal | `MANUAL`, healthy, `PUMP ON` | Pump runs regardless of level |
| TC-38 | Service mode | `SERVICE ON` | Outputs off, leak check suspended, overflow still armed |
| TC-39 | Fault log | Cause 3 trips, `FAULTS?` | 3 records with correct snapshots |
| TC-40 | Fault ring wrap | Cause 18 trips | 16 newest kept, oldest overwritten |
| TC-41 | Fault log wrap | Force 20 faults, `FAULTS?` | Newest 16 kept, oldest dropped |
| TC-42 | Telemetry cadence | Capture 60 s | 12 frames ±1, checksums valid |
| TC-43 | Console robustness | `FOO`, 40-char line, `SET START 200` | `ERR CMD`, `ERR LONG`, `ERR RANGE` |
| TC-44 | LCD flicker | Watch 60 s | No visible redraw |
| TC-45 | Tick jitter | Scope tick pin | 10 ms ±1 ms |
| TC-46 | CPU load | `PD7` duty | ≤ 60 % |
| TC-47 | RAM budget | `avr-size -C` | ≤ 1024 B |
| TC-48 | Soak | 15 min of level sweeps and injected faults | No hang, totaliser monotonic |
| TC-49 | **No heap linked** | `avr-nm main.elf \| grep -i malloc` | Prints nothing |
| TC-50 | **No recursion** | Inspect the call graph; state the deepest chain | Acyclic, depth stated in the report |

---

## 21. Bonus Features

Maximum **+20**; final score capped at 100.

| # | Feature | Marks | Requirement |
|---|---------|:-----:|-------------|
| B1 | Consumption profiling | +10 | Hourly usage histogram (24 buckets) in RAM, dumped by `PROFILE?` |
| B2 | Predictive empty time | +10 | From the level rate of change, display `EMPTY IN 3h20m` |
| B3 | Scheduled filling | +10 | Fill only inside an operator-set window (e.g. 22:00 – 06:00) using a DS1307 over I2C |
| B4 | True cooperative scheduler | +15 | Task table with period/offset/order, overrun counter over UART |
| B5 | Watchdog recovery | +10 | WDT 250 ms; a deliberate hang recovers, `MCUCSR` reason logged, latch preserved |
| B6 | Buzzer trip patterns | +5 | A distinct beep pattern per trip class, driven by Timer2 PWM |
| B7 | Pump alternation | +10 | Two pumps alternated per cycle to equalise wear; run-hours tracked separately |
| B8 | Soft-start valve ramp | +10 | Valve opened by PWM ramp over 3 s to suppress water hammer |

---

## 22. Deliverables

| # | Item | Detail |
|---|------|--------|
| 1 | Source code | Layered per §9.1; interlocks in their own module |
| 2 | `Simulation/watertank.sim1` | Runs unmodified |
| 3 | `Docs/hazard_analysis.md` | The table of §2 extended: hazard → detection → protection → test case |
| 4 | `Docs/flowchart.png` | Matches §16 |
| 5 | `Docs/state_machine.png` | Matches §17 with the transition table |
| 6 | `Docs/test_report.md` | All 50 `TC` rows with evidence |
| 7 | Final report | 15 – 20 pages incl. flow-meter maths, trip-priority justification, timing budget |
| 8 | Demo video | 5 – 10 min: normal cycle plus **at least five injected faults** and their latching |
| 9 | Live defence | Any member, any file |

---

## 23. Evaluation Rubric

| Item | Marks | Full-mark criteria |
|------|:-----:|--------------------|
| GPIO | 5 | Own DIO driver; safe-state-first initialisation |
| ADC | 10 | Three channels at two different rates, correct filtering and scaling |
| Timer | 10 | 10 ms tick **and** Timer1 external counter with wrap handling |
| Interrupts | 5 | `INT0` overflow path ≤ 1 ms; short ISRs |
| USART | 10 | Frame, event stream and parser per §18 |
| SPI | 10 | 74HC595 fault/status bar correct: shift then latch, no flicker |
| I2C | 10 | LCD via PCF8574, flicker-free, trip banner alternation |
| Application logic | 20 | All nine interlocks implemented, prioritised and latching |
| Architecture | 10 | Interlocks evaluated before demand; layer rule respected |
| Testing | 10 | 49 cases including all fault injections |
| Documentation & demo | 10 | Hazard analysis present; five faults demonstrated live |
| **Total** | **100** | Bonus up to +20, capped at 100 |

---

*Prepared by Ahmed Ellamie | ahmed.ellamiee@gmail.com*
??? ??????? ?? ????? ???? ???? ??? ??????? ????? ??????.
