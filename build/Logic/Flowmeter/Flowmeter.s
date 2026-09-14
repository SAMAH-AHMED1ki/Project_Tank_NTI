	.file	"Flowmeter.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.FLOWMETER_Init,"ax",@progbits
.global	FLOWMETER_Init
	.type	FLOWMETER_Init, @function
FLOWMETER_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	sbiw r24,0
	brne .L1
	jmp TIMER1_ExternalCounterInit
.L1:
/* epilogue start */
	ret
	.size	FLOWMETER_Init, .-FLOWMETER_Init
	.section	.text.FLOWMETER_StartMeasurement,"ax",@progbits
.global	FLOWMETER_StartMeasurement
	.type	FLOWMETER_StartMeasurement, @function
FLOWMETER_StartMeasurement:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp TIMER1_ResetCounter
	.size	FLOWMETER_StartMeasurement, .-FLOWMETER_StartMeasurement
	.section	.text.FLOWMETER_GetPulses,"ax",@progbits
.global	FLOWMETER_GetPulses
	.type	FLOWMETER_GetPulses, @function
FLOWMETER_GetPulses:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp TIMER1_GetCounter
	.size	FLOWMETER_GetPulses, .-FLOWMETER_GetPulses
	.section	.text.FLOWMETER_GetMilliliters,"ax",@progbits
.global	FLOWMETER_GetMilliliters
	.type	FLOWMETER_GetMilliliters, @function
FLOWMETER_GetMilliliters:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER1_GetCounter
	movw r18,r24
	ldi r26,lo8(-24)
	ldi r27,lo8(3)
	call __umulhisi3
	ldi r18,lo8(-62)
	ldi r19,lo8(1)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
/* epilogue start */
	ret
	.size	FLOWMETER_GetMilliliters, .-FLOWMETER_GetMilliliters
	.section	.text.FLOWMETER_ResetMeasurement,"ax",@progbits
.global	FLOWMETER_ResetMeasurement
	.type	FLOWMETER_ResetMeasurement, @function
FLOWMETER_ResetMeasurement:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp TIMER1_ResetCounter
	.size	FLOWMETER_ResetMeasurement, .-FLOWMETER_ResetMeasurement
	.ident	"GCC: (GNU) 15.2.0"
