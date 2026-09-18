	.file	"tank_fsm.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.FSM_StartFilling,"ax",@progbits
	.type	FSM_StartFilling, @function
FSM_StartFilling:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	call PMP_Set
	ldi r24,lo8(1)
	jmp Valve_Set
	.size	FSM_StartFilling, .-FSM_StartFilling
	.section	.text.FSM_StopOutputs,"ax",@progbits
	.type	FSM_StopOutputs, @function
FSM_StopOutputs:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,0
	call PMP_Set
	ldi r24,0
	jmp Valve_Set
	.size	FSM_StopOutputs, .-FSM_StopOutputs
	.section	.text.FSM_Init,"ax",@progbits
.global	FSM_Init
	.type	FSM_Init, @function
FSM_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_eCurrentState,__zero_reg__
	sts Global_eCurrentState+1,__zero_reg__
	sts Global_eActiveTrip,__zero_reg__
	sts Global_eActiveTrip+1,__zero_reg__
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	sts Global_u16MinOffTicks,r24
	sts Global_u16MinOffTicks+1,r25
	sts Global_u8BuzzerSilenced,__zero_reg__
	ldi r24,0
	call PMP_Set
	sbiw r24,0
	brne .L3
	ldi r24,0
	jmp Valve_Set
.L3:
/* epilogue start */
	ret
	.size	FSM_Init, .-FSM_Init
	.section	.text.FSM_GetState,"ax",@progbits
.global	FSM_GetState
	.type	FSM_GetState, @function
FSM_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_eCurrentState
	lds r25,Global_eCurrentState+1
/* epilogue start */
	ret
	.size	FSM_GetState, .-FSM_GetState
	.section	.text.FSM_SetServiceMode,"ax",@progbits
.global	FSM_SetServiceMode
	.type	FSM_SetServiceMode, @function
FSM_SetServiceMode:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cp r24, __zero_reg__
	breq .L7
	call FSM_StopOutputs
	ldi r24,lo8(7)
	ldi r25,0
.L8:
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
	ldi r24,0
/* epilogue start */
	ret
.L7:
	call FSM_StopOutputs
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L8
	.size	FSM_SetServiceMode, .-FSM_SetServiceMode
	.section	.text.FSM_Ack,"ax",@progbits
.global	FSM_Ack
	.type	FSM_Ack, @function
FSM_Ack:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	sts Global_u8BuzzerSilenced,r24
	call ILK_Reset
	sbiw r24,0
	brne .L9
	sts Global_eActiveTrip,__zero_reg__
	sts Global_eActiveTrip+1,__zero_reg__
	ldi r18,lo8(1)
	sts Global_eCurrentState,r18
	sts Global_eCurrentState+1,__zero_reg__
.L9:
/* epilogue start */
	ret
	.size	FSM_Ack, .-FSM_Ack
	.section	.text.FSM_Run,"ax",@progbits
.global	FSM_Run
	.type	FSM_Run, @function
FSM_Run:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 6 */
/* stack size = 12 */
.L__stack_usage = 12
	movw r16,r24
	std Y+5,__zero_reg__
	std Y+6,__zero_reg__
	std Y+3,__zero_reg__
	std Y+4,__zero_reg__
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	ldi r24,lo8(1)
	ldi r25,0
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	brne .+2
	rjmp .L11
	movw r30,r16
	ldd r24,Z+17
	sbrc r24,0
	rjmp .L13
	lds r24,Global_u16MinOffTicks
	lds r25,Global_u16MinOffTicks+1
	cpi r24,-12
	ldi r31,1
	cpc r25,r31
	brsh .L14
	adiw r24,1
	sts Global_u16MinOffTicks,r24
	sts Global_u16MinOffTicks+1,r25
.L14:
	movw r22,r28
	subi r22,-5
	sbci r23,-1
	ldi r24,0
	ldi r25,0
	call BTN_GetEvent
	movw r22,r28
	subi r22,-3
	sbci r23,-1
	ldi r24,lo8(1)
	ldi r25,0
	call BTN_GetEvent
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(2)
	ldi r25,0
	call BTN_GetEvent
	movw r24,r16
	call ILK_Evaluate
	movw r14,r24
	or r24,r25
	breq .L15
	call FSM_StopOutputs
	lds r24,Global_eCurrentState
	lds r25,Global_eCurrentState+1
	sbiw r24,5
	breq .L16
	sts Global_u8BuzzerSilenced,__zero_reg__
	sts Global_eActiveTrip,r14
	sts Global_eActiveTrip+1,r15
.L16:
	ldi r24,lo8(5)
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
.L15:
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,3
	sbiw r24,2
	brsh .L17
	call FSM_Ack
.L17:
	or r14,r15
	breq .L18
.L25:
	call FSM_StopOutputs
	rjmp .L19
.L13:
	sts Global_u16MinOffTicks,__zero_reg__
	sts Global_u16MinOffTicks+1,__zero_reg__
	rjmp .L14
.L18:
	lds r30,Global_eCurrentState
	lds r31,Global_eCurrentState+1
	ldd r24,Y+5
	ldd r25,Y+6
	sbiw r24,3
	breq .+2
	rjmp .L20
	cpi r30,6
	cpc r31,__zero_reg__
	brne .L21
	sts Global_u8ManualPumpOn,__zero_reg__
	call FSM_StopOutputs
	ldi r24,lo8(1)
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
.L22:
	call FSM_StopOutputs
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
	movw r30,r16
	ldd r24,Z+7
	cpi r24,lo8(25)
	brsh .L31
.L54:
	ldi r24,lo8(4)
	rjmp .L52
.L21:
	movw r24,r30
	sbiw r24,1
	sbiw r24,2
	brsh .L20
	sts Global_u8ManualPumpOn,__zero_reg__
	call FSM_StopOutputs
	ldi r24,lo8(6)
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
.L23:
	ldd r24,Y+3
	ldd r25,Y+4
	sbiw r24,3
	brne .L38
	lds r24,Global_u8ManualPumpOn
	cpse r24,__zero_reg__
	rjmp .L39
	lds r24,Global_u16MinOffTicks
	lds r25,Global_u16MinOffTicks+1
	cpi r24,-12
	sbci r25,1
	brsh .+2
	rjmp .L25
	ldi r24,lo8(1)
	sts Global_u8ManualPumpOn,r24
	call FSM_StartFilling
.L38:
	lds r24,Global_u8ManualPumpOn
	cp r24, __zero_reg__
	brne .+2
	rjmp .L25
.L35:
	call FSM_StartFilling
	rjmp .L19
.L20:
	cpi r30,8
	cpc r31,__zero_reg__
	brlo .+2
	rjmp .L24
	subi r30,lo8(-(gs(.L26)))
	sbci r31,hi8(-(gs(.L26)))
	jmp __tablejump2__
	.section	.jumptables.gcc.FSM_Run,"a",@progbits
	.p2align	1
	.type	.L26, @object
.L26:
	.word gs(.L30)
	.word gs(.L22)
	.word gs(.L29)
	.word gs(.L28)
	.word gs(.L27)
	.word gs(.L25)
	.word gs(.L23)
	.word gs(.L25)
	.section	.text.FSM_Run
.L30:
	call FSM_StopOutputs
.L37:
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
.L53:
	ldi r24,lo8(1)
	rjmp .L52
.L31:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L32
.L19:
	ldi r24,0
	ldi r25,0
.L11:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L32:
	lds r24,Global_u16MinOffTicks
	lds r25,Global_u16MinOffTicks+1
	cpi r24,-12
	sbci r25,1
	brlo .L19
	ldi r24,lo8(2)
.L52:
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
	rjmp .L19
.L29:
	movw r30,r16
	ldd r24,Z+7
	cpi r24,lo8(25)
	brsh .L34
	call FSM_StopOutputs
	rjmp .L54
.L34:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L35
	call FSM_StopOutputs
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
	ldi r24,lo8(3)
	rjmp .L52
.L28:
	call FSM_StopOutputs
	lds r24,Global_u16SettlingTicks
	lds r25,Global_u16SettlingTicks+1
	cpi r24,-12
	ldi r31,1
	cpc r25,r31
	brlo .+2
	rjmp .L37
	adiw r24,1
	sts Global_u16SettlingTicks,r24
	sts Global_u16SettlingTicks+1,r25
	cpi r24,-12
	sbci r25,1
	breq .+2
	rjmp .L19
	rjmp .L37
.L27:
	call FSM_StopOutputs
	movw r30,r16
	ldd r24,Z+7
	cpi r24,lo8(25)
	brsh .+2
	rjmp .L19
	rjmp .L53
.L39:
	sts Global_u8ManualPumpOn,__zero_reg__
	call FSM_StopOutputs
	rjmp .L38
.L24:
	call FSM_StopOutputs
	ldi r24,lo8(5)
	rjmp .L52
	.size	FSM_Run, .-FSM_Run
	.section	.text.FSM_IsBuzzerEnabled,"ax",@progbits
.global	FSM_IsBuzzerEnabled
	.type	FSM_IsBuzzerEnabled, @function
FSM_IsBuzzerEnabled:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_eCurrentState
	lds r25,Global_eCurrentState+1
	sbiw r24,5
	brne .L58
	ldi r24,lo8(1)
	lds r25,Global_u8BuzzerSilenced
	cpse r25,__zero_reg__
.L58:
	ldi r24,0
.L55:
/* epilogue start */
	ret
	.size	FSM_IsBuzzerEnabled, .-FSM_IsBuzzerEnabled
	.section	.text.FSM_GetActiveTrip,"ax",@progbits
.global	FSM_GetActiveTrip
	.type	FSM_GetActiveTrip, @function
FSM_GetActiveTrip:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_eActiveTrip
	lds r25,Global_eActiveTrip+1
/* epilogue start */
	ret
	.size	FSM_GetActiveTrip, .-FSM_GetActiveTrip
	.section	.bss.Global_u8ManualPumpOn,"aw",@nobits
	.type	Global_u8ManualPumpOn, @object
	.size	Global_u8ManualPumpOn, 1
Global_u8ManualPumpOn:
	.zero	1
	.section	.bss.Global_u8BuzzerSilenced,"aw",@nobits
	.type	Global_u8BuzzerSilenced, @object
	.size	Global_u8BuzzerSilenced, 1
Global_u8BuzzerSilenced:
	.zero	1
	.section	.data.Global_u16MinOffTicks,"aw"
	.type	Global_u16MinOffTicks, @object
	.size	Global_u16MinOffTicks, 2
Global_u16MinOffTicks:
	.word	500
	.section	.bss.Global_u16SettlingTicks,"aw",@nobits
	.type	Global_u16SettlingTicks, @object
	.size	Global_u16SettlingTicks, 2
Global_u16SettlingTicks:
	.zero	2
	.section	.bss.Global_eActiveTrip,"aw",@nobits
	.type	Global_eActiveTrip, @object
	.size	Global_eActiveTrip, 2
Global_eActiveTrip:
	.zero	2
	.section	.bss.Global_eCurrentState,"aw",@nobits
	.type	Global_eCurrentState, @object
	.size	Global_eCurrentState, 2
Global_eCurrentState:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
