	.file	"tamk_fsm.c"
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
	sts Global_CurrentState,__zero_reg__
	sts Global_CurrentState+1,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	FSM_Init, .-FSM_Init
	.section	.text.FSM_Run,"ax",@progbits
.global	FSM_Run
	.type	FSM_Run, @function
FSM_Run:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call INT_IsSystemTripped
	cpi r24,lo8(1)
	brne .L3
	ldi r24,lo8(2)
.L10:
	sts Global_CurrentState,r24
	sts Global_CurrentState+1,__zero_reg__
.L4:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L3:
	lds r24,Global_CurrentState
	lds r25,Global_CurrentState+1
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L5
	brlo .L6
	sbiw r24,2
	sbiw r24,2
	brlo .L4
.L7:
	sts Global_CurrentState,__zero_reg__
	sts Global_CurrentState+1,__zero_reg__
	rjmp .L4
.L6:
	call DEM_GetPumpDemand
	cpi r24,lo8(1)
	brne .L4
	ldi r24,lo8(1)
	rjmp .L10
.L5:
	call DEM_GetPumpDemand
	cpse r24,__zero_reg__
	rjmp .L4
	rjmp .L7
	.size	FSM_Run, .-FSM_Run
	.section	.text.FSM_GetState,"ax",@progbits
.global	FSM_GetState
	.type	FSM_GetState, @function
FSM_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_CurrentState
	lds r25,Global_CurrentState+1
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
	call INT_IsSystemTripped
	cpse r24,__zero_reg__
	rjmp .L14
	sts Global_CurrentState,__zero_reg__
	sts Global_CurrentState+1,__zero_reg__
	ldi r24,0
	ldi r25,0
	ret
.L14:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	FSM_Ack, .-FSM_Ack
	.section	.bss.Global_CurrentState,"aw",@nobits
	.type	Global_CurrentState, @object
	.size	Global_CurrentState, 2
Global_CurrentState:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
