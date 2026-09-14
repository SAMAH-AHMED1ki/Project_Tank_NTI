	.file	"floats.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.FLT_Init,"ax",@progbits
.global	FLT_Init
	.type	FLT_Init, @function
FLT_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(2)
	ldi r22,0
	ldi r24,0
	call GPIO_SetPinDirection
	ldi r20,lo8(2)
	ldi r22,lo8(1)
	ldi r24,0
	call GPIO_SetPinDirection
	sts Global_u8HighState,__zero_reg__
	sts Global_u8LowState,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	FLT_Init, .-FLT_Init
	.section	.text.FLT_Update,"ax",@progbits
.global	FLT_Update
	.type	FLT_Update, @function
FLT_Update:
	push r28
	push r29
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 6 */
.L__stack_usage = 6
	std Y+2,__zero_reg__
	std Y+1,__zero_reg__
	movw r20,r28
	subi r20,-2
	sbci r21,-1
	ldi r22,0
	ldi r24,0
	call GPIO_GetPinValue
	std Y+3,r24
	std Y+4,r25
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	ldi r22,lo8(1)
	ldi r24,0
	call GPIO_GetPinValue
	ldd r18,Y+3
	ldd r19,Y+4
	or r24,r18
	or r25,r19
	sbiw r24,0
	brne .L2
	ldd r18,Y+2
	sts Global_u8HighState,r18
	ldd r18,Y+1
	sts Global_u8LowState,r18
.L2:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	FLT_Update, .-FLT_Update
	.section	.text.FLT_IsHighActive,"ax",@progbits
.global	FLT_IsHighActive
	.type	FLT_IsHighActive, @function
FLT_IsHighActive:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_u8HighState
/* epilogue start */
	ret
	.size	FLT_IsHighActive, .-FLT_IsHighActive
	.section	.text.FLT_IsLowActive,"ax",@progbits
.global	FLT_IsLowActive
	.type	FLT_IsLowActive, @function
FLT_IsLowActive:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_u8LowState
/* epilogue start */
	ret
	.size	FLT_IsLowActive, .-FLT_IsLowActive
	.section	.bss.Global_u8LowState,"aw",@nobits
	.type	Global_u8LowState, @object
	.size	Global_u8LowState, 1
Global_u8LowState:
	.zero	1
	.section	.bss.Global_u8HighState,"aw",@nobits
	.type	Global_u8HighState, @object
	.size	Global_u8HighState, 1
Global_u8HighState:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
