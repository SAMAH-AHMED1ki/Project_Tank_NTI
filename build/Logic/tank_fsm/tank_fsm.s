	.file	"tank_fsm.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
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
	ldi r24,0
	call PMP_Set
	sbiw r24,0
	brne .L1
	ldi r24,0
	jmp Valve_Set
.L1:
/* epilogue start */
	ret
	.size	FSM_Init, .-FSM_Init
	.section	.text.FSM_Run,"ax",@progbits
.global	FSM_Run
	.type	FSM_Run, @function
FSM_Run:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(1)
	ldi r25,0
	sbiw r28,0
	breq .L3
	movw r24,r28
	call ILK_Evaluate
	or r24,r25
	breq .L5
.L7:
	ldi r24,0
	call PMP_Set
	ldi r24,0
	call Valve_Set
	ldi r24,lo8(5)
	rjmp .L20
.L5:
	lds r30,Global_eCurrentState
	lds r31,Global_eCurrentState+1
	cpi r30,8
	cpc r31,__zero_reg__
	brsh .L7
	subi r30,lo8(-(gs(.L9)))
	sbci r31,hi8(-(gs(.L9)))
	jmp __tablejump2__
	.section	.jumptables.gcc.FSM_Run,"a",@progbits
	.p2align	1
	.type	.L9, @object
.L9:
	.word gs(.L11)
	.word gs(.L13)
	.word gs(.L12)
	.word gs(.L11)
	.word gs(.L10)
	.word gs(.L8)
	.word gs(.L6)
	.word gs(.L8)
	.section	.text.FSM_Run
.L11:
	ldi r24,0
	call PMP_Set
	ldi r24,0
	call Valve_Set
.L23:
	ldi r24,lo8(1)
	rjmp .L20
.L13:
	ldi r24,0
	call PMP_Set
	ldi r24,0
	call Valve_Set
	ldd r24,Y+7
	cpi r24,lo8(25)
	brsh .L14
.L22:
	ldi r24,lo8(4)
	rjmp .L20
.L14:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L15
.L6:
	ldi r24,0
	ldi r25,0
.L3:
/* epilogue start */
	pop r29
	pop r28
	ret
.L15:
	ldi r24,lo8(2)
.L20:
	sts Global_eCurrentState,r24
	sts Global_eCurrentState+1,__zero_reg__
	rjmp .L6
.L12:
	ldd r24,Y+7
	cpi r24,lo8(25)
	brsh .L16
	ldi r24,0
	call PMP_Set
	ldi r24,0
	call Valve_Set
	rjmp .L22
.L16:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L17
	call PMP_Set
	ldi r24,0
	call Valve_Set
	ldi r24,lo8(3)
	rjmp .L20
.L17:
	ldi r24,lo8(1)
	call PMP_Set
	ldi r24,lo8(1)
.L21:
	call Valve_Set
	rjmp .L6
.L10:
	ldi r24,0
	call PMP_Set
	ldi r24,0
	call Valve_Set
	ldd r24,Y+7
	cpi r24,lo8(25)
	brlo .L6
	rjmp .L23
.L8:
	ldi r24,0
	call PMP_Set
	ldi r24,0
	rjmp .L21
	.size	FSM_Run, .-FSM_Run
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
	jmp ILK_Reset
	.size	FSM_Ack, .-FSM_Ack
	.section	.bss.Global_eCurrentState,"aw",@nobits
	.type	Global_eCurrentState, @object
	.size	Global_eCurrentState, 2
Global_eCurrentState:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
