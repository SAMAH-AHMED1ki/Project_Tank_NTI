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
	brne .L6
	ldi r18,lo8(1)
	sts Global_eCurrentState,r18
	sts Global_eCurrentState+1,__zero_reg__
.L6:
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
	rjmp .L8
	movw r30,r16
	ldd r24,Z+17
	sbrc r24,0
	rjmp .L10
	lds r24,Global_u16MinOffTicks
	lds r25,Global_u16MinOffTicks+1
	cpi r24,-12
	ldi r31,1
	cpc r25,r31
	brsh .L11
	adiw r24,1
	sts Global_u16MinOffTicks,r24
	sts Global_u16MinOffTicks+1,r25
.L11:
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
	breq .L12
	call FSM_StopOutputs
	lds r24,Global_eCurrentState
	lds r25,Global_eCurrentState+1
	sbiw r24,5
	breq .L13
	sts Global_u8BuzzerSilenced,__zero_reg__
.L13:
	ldi r24,lo8(5)
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
.L12:
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,3
	sbiw r24,2
	brsh .L14
	call FSM_Ack
.L14:
	or r14,r15
	breq .L15
.L22:
	call FSM_StopOutputs
	rjmp .L16
.L10:
	sts Global_u16MinOffTicks,__zero_reg__
	sts Global_u16MinOffTicks+1,__zero_reg__
	rjmp .L11
.L15:
	lds r30,Global_eCurrentState
	lds r31,Global_eCurrentState+1
	ldd r24,Y+5
	ldd r25,Y+6
	sbiw r24,3
	breq .+2
	rjmp .L17
	cpi r30,6
	cpc r31,__zero_reg__
	brne .L18
	sts Global_u8ManualPumpOn,__zero_reg__
	call FSM_StopOutputs
	ldi r24,lo8(1)
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
.L19:
	call FSM_StopOutputs
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
	movw r30,r16
	ldd r24,Z+7
	cpi r24,lo8(25)
	brsh .L28
.L51:
	ldi r24,lo8(4)
	rjmp .L49
.L18:
	movw r24,r30
	sbiw r24,1
	sbiw r24,2
	brsh .L17
	sts Global_u8ManualPumpOn,__zero_reg__
	call FSM_StopOutputs
	ldi r24,lo8(6)
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
.L20:
	ldd r24,Y+3
	ldd r25,Y+4
	sbiw r24,3
	brne .L35
	lds r24,Global_u8ManualPumpOn
	cpse r24,__zero_reg__
	rjmp .L36
	lds r24,Global_u16MinOffTicks
	lds r25,Global_u16MinOffTicks+1
	cpi r24,-12
	sbci r25,1
	brsh .+2
	rjmp .L22
	ldi r24,lo8(1)
	sts Global_u8ManualPumpOn,r24
	call FSM_StartFilling
.L35:
	lds r24,Global_u8ManualPumpOn
	cp r24, __zero_reg__
	brne .+2
	rjmp .L22
.L32:
	call FSM_StartFilling
	rjmp .L16
.L17:
	cpi r30,8
	cpc r31,__zero_reg__
	brlo .+2
	rjmp .L21
	subi r30,lo8(-(gs(.L23)))
	sbci r31,hi8(-(gs(.L23)))
	jmp __tablejump2__
	.section	.jumptables.gcc.FSM_Run,"a",@progbits
	.p2align	1
	.type	.L23, @object
.L23:
	.word gs(.L27)
	.word gs(.L19)
	.word gs(.L26)
	.word gs(.L25)
	.word gs(.L24)
	.word gs(.L22)
	.word gs(.L20)
	.word gs(.L22)
	.section	.text.FSM_Run
.L27:
	call FSM_StopOutputs
.L34:
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
.L50:
	ldi r24,lo8(1)
	rjmp .L49
.L28:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L29
.L16:
	ldi r24,0
	ldi r25,0
.L8:
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
.L29:
	lds r24,Global_u16MinOffTicks
	lds r25,Global_u16MinOffTicks+1
	cpi r24,-12
	sbci r25,1
	brlo .L16
	ldi r24,lo8(2)
.L49:
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
	rjmp .L16
.L26:
	movw r30,r16
	ldd r24,Z+7
	cpi r24,lo8(25)
	brsh .L31
	call FSM_StopOutputs
	rjmp .L51
.L31:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L32
	call FSM_StopOutputs
	sts Global_u16SettlingTicks,__zero_reg__
	sts Global_u16SettlingTicks+1,__zero_reg__
	ldi r24,lo8(3)
	rjmp .L49
.L25:
	call FSM_StopOutputs
	lds r24,Global_u16SettlingTicks
	lds r25,Global_u16SettlingTicks+1
	cpi r24,-12
	ldi r31,1
	cpc r25,r31
	brlo .+2
	rjmp .L34
	adiw r24,1
	sts Global_u16SettlingTicks,r24
	sts Global_u16SettlingTicks+1,r25
	cpi r24,-12
	sbci r25,1
	breq .+2
	rjmp .L16
	rjmp .L34
.L24:
	call FSM_StopOutputs
	movw r30,r16
	ldd r24,Z+7
	cpi r24,lo8(25)
	brsh .+2
	rjmp .L16
	rjmp .L50
.L36:
	sts Global_u8ManualPumpOn,__zero_reg__
	call FSM_StopOutputs
	rjmp .L35
.L21:
	call FSM_StopOutputs
	ldi r24,lo8(5)
	rjmp .L49
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
	brne .L55
	ldi r24,lo8(1)
	lds r25,Global_u8BuzzerSilenced
	cpse r25,__zero_reg__
.L55:
	ldi r24,0
.L52:
/* epilogue start */
	ret
	.size	FSM_IsBuzzerEnabled, .-FSM_IsBuzzerEnabled
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
	.section	.bss.Global_eCurrentState,"aw",@nobits
	.type	Global_eCurrentState, @object
	.size	Global_eCurrentState, 2
Global_eCurrentState:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
