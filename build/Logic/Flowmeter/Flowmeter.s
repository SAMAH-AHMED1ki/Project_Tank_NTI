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
	brne .L2
	call TIMER1_ExternalCounterInit
.L2:
	sts g_lastCount,__zero_reg__
	sts g_lastCount+1,__zero_reg__
	sts g_pulsesLastSecond,__zero_reg__
	sts g_pulsesLastSecond+1,__zero_reg__
	sts g_totalPulses,__zero_reg__
	sts g_totalPulses+1,__zero_reg__
	sts g_totalPulses+2,__zero_reg__
	sts g_totalPulses+3,__zero_reg__
/* epilogue start */
	ret
	.size	FLOWMETER_Init, .-FLOWMETER_Init
	.section	.text.FLOWMETER_Update1Hz,"ax",@progbits
.global	FLOWMETER_Update1Hz
	.type	FLOWMETER_Update1Hz, @function
FLOWMETER_Update1Hz:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER1_GetCounter
	lds r18,g_lastCount
	lds r19,g_lastCount+1
	movw r20,r24
	sub r20,r18
	sbc r21,r19
	movw r18,r20
	sts g_lastCount,r24
	sts g_lastCount+1,r25
	sts g_pulsesLastSecond,r20
	sts g_pulsesLastSecond+1,r19
	lds r24,g_totalPulses
	lds r25,g_totalPulses+1
	lds r26,g_totalPulses+2
	lds r27,g_totalPulses+3
	add r24,r20
	adc r25,r21
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts g_totalPulses,r24
	sts g_totalPulses+1,r25
	sts g_totalPulses+2,r26
	sts g_totalPulses+3,r27
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	FLOWMETER_Update1Hz, .-FLOWMETER_Update1Hz
	.section	.text.FLOWMETER_GetPulsesPerSec,"ax",@progbits
.global	FLOWMETER_GetPulsesPerSec
	.type	FLOWMETER_GetPulsesPerSec, @function
FLOWMETER_GetPulsesPerSec:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_pulsesLastSecond
	lds r25,g_pulsesLastSecond+1
/* epilogue start */
	ret
	.size	FLOWMETER_GetPulsesPerSec, .-FLOWMETER_GetPulsesPerSec
	.section	.text.FLOWMETER_GetFlowLpmX10,"ax",@progbits
.global	FLOWMETER_GetFlowLpmX10
	.type	FLOWMETER_GetFlowLpmX10, @function
FLOWMETER_GetFlowLpmX10:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,g_pulsesLastSecond
	lds r23,g_pulsesLastSecond+1
	ldi r24,0
	ldi r25,0
	ldi r18,2
	1:
	lsl r22
	rol r23
	rol r24
	rol r25
	dec r18
	brne 1b
	ldi r18,lo8(3)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r24,r18
/* epilogue start */
	ret
	.size	FLOWMETER_GetFlowLpmX10, .-FLOWMETER_GetFlowLpmX10
	.section	.text.FLOWMETER_GetTotalMilliliters,"ax",@progbits
.global	FLOWMETER_GetTotalMilliliters
	.type	FLOWMETER_GetTotalMilliliters, @function
FLOWMETER_GetTotalMilliliters:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,g_totalPulses
	lds r19,g_totalPulses+1
	lds r20,g_totalPulses+2
	lds r21,g_totalPulses+3
	ldi r26,lo8(-24)
	ldi r27,lo8(3)
	call __muluhisi3
	ldi r18,lo8(-62)
	ldi r19,lo8(1)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r22,r18
	movw r24,r20
/* epilogue start */
	ret
	.size	FLOWMETER_GetTotalMilliliters, .-FLOWMETER_GetTotalMilliliters
	.section	.text.FLOWMETER_ResetTotaliser,"ax",@progbits
.global	FLOWMETER_ResetTotaliser
	.type	FLOWMETER_ResetTotaliser, @function
FLOWMETER_ResetTotaliser:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_totalPulses,__zero_reg__
	sts g_totalPulses+1,__zero_reg__
	sts g_totalPulses+2,__zero_reg__
	sts g_totalPulses+3,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	FLOWMETER_ResetTotaliser, .-FLOWMETER_ResetTotaliser
	.section	.bss.g_totalPulses,"aw",@nobits
	.type	g_totalPulses, @object
	.size	g_totalPulses, 4
g_totalPulses:
	.zero	4
	.section	.bss.g_pulsesLastSecond,"aw",@nobits
	.type	g_pulsesLastSecond, @object
	.size	g_pulsesLastSecond, 2
g_pulsesLastSecond:
	.zero	2
	.section	.bss.g_lastCount,"aw",@nobits
	.type	g_lastCount, @object
	.size	g_lastCount, 2
g_lastCount:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
