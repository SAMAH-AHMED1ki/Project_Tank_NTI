	.file	"Valve.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.Valve_Init,"ax",@progbits
.global	Valve_Init
	.type	Valve_Init, @function
Valve_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	sbiw r24,0
	brne .L1
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	sbiw r24,0
	brne .L1
	sts Valve_u8State,__zero_reg__
.L1:
/* epilogue start */
	ret
	.size	Valve_Init, .-Valve_Init
	.section	.text.Valve_Set,"ax",@progbits
.global	Valve_Set
	.type	Valve_Set, @function
Valve_Set:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,lo8(1)
	ldi r25,0
	cpi r28,lo8(2)
	brsh .L5
	mov r20,r28
	ldi r22,lo8(2)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	sbiw r24,0
	brne .L5
	sts Valve_u8State,r28
.L5:
/* epilogue start */
	pop r28
	ret
	.size	Valve_Set, .-Valve_Set
	.section	.text.Valve_GetState,"ax",@progbits
.global	Valve_GetState
	.type	Valve_GetState, @function
Valve_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L12
	lds r18,Valve_u8State
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
	ret
.L12:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Valve_GetState, .-Valve_GetState
	.section	.bss.Valve_u8State,"aw",@nobits
	.type	Valve_u8State, @object
	.size	Valve_u8State, 1
Valve_u8State:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
