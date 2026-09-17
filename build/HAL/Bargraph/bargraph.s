	.file	"bargraph.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.BARGRAPH_SetLevel,"ax",@progbits
.global	BARGRAPH_SetLevel
	.type	BARGRAPH_SetLevel, @function
BARGRAPH_SetLevel:
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 8 */
.L__stack_usage = 8
	std Y+1,r24
	ldi r24,lo8(1)
	ldi r25,0
	cpi r22,lo8(101)
	brsh .L1
	cpi r22,lo8(25)
	brlo .L6
	cpi r22,lo8(50)
	brlo .L7
	cpi r22,lo8(75)
	brlo .L8
	ldi r17,lo8(1)
	cpi r22,lo8(95)
	brsh .L4
	ldi r17,0
.L4:
	ldi r16,lo8(1)
	mov r15,r16
	ldi r20,lo8(1)
.L3:
	ldi r22,lo8(2)
	ldd r24,Y+1
	call GPIO_SetPinValue
	std Y+2,r24
	std Y+3,r25
	mov r20,r15
	ldi r22,lo8(3)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	mov r20,r16
	ldi r22,lo8(4)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	mov r20,r17
	ldi r22,lo8(5)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r24,r18
	or r25,r19
.L1:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
.L6:
	ldi r16,0
	mov r15,__zero_reg__
	ldi r20,0
.L9:
	ldi r17,0
	rjmp .L3
.L7:
	ldi r16,0
	mov r15,__zero_reg__
.L10:
	ldi r20,lo8(1)
	rjmp .L9
.L8:
	ldi r16,0
	clr r15
	inc r15
	rjmp .L10
	.size	BARGRAPH_SetLevel, .-BARGRAPH_SetLevel
	.section	.text.BARGRAPH_Off,"ax",@progbits
.global	BARGRAPH_Off
	.type	BARGRAPH_Off, @function
BARGRAPH_Off:
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+1,r24
	ldi r20,0
	ldi r22,lo8(2)
	call GPIO_SetPinValue
	std Y+2,r24
	std Y+3,r25
	ldi r20,0
	ldi r22,lo8(3)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,0
	ldi r22,lo8(4)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,0
	ldi r22,lo8(5)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r24,r18
	or r25,r19
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	BARGRAPH_Off, .-BARGRAPH_Off
	.section	.text.BARGRAPH_Init,"ax",@progbits
.global	BARGRAPH_Init
	.type	BARGRAPH_Init, @function
BARGRAPH_Init:
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+1,r24
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	call GPIO_SetPinDirection
	std Y+2,r24
	std Y+3,r25
	ldi r20,lo8(1)
	ldi r22,lo8(3)
	ldd r24,Y+1
	call GPIO_SetPinDirection
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldd r24,Y+1
	call GPIO_SetPinDirection
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldd r24,Y+1
	call GPIO_SetPinDirection
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldd r24,Y+1
	call BARGRAPH_Off
	ldd r18,Y+2
	ldd r19,Y+3
	or r24,r18
	or r25,r19
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	BARGRAPH_Init, .-BARGRAPH_Init
	.ident	"GCC: (GNU) 15.2.0"
