	.file	"buttons.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.BTN_Init,"ax",@progbits
.global	BTN_Init
	.type	BTN_Init, @function
BTN_Init:
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
	ldi r22,lo8(4)
	call GPIO_SetPinDirection
	std Y+2,r24
	std Y+3,r25
	ldi r20,0
	ldi r22,lo8(5)
	ldd r24,Y+1
	call GPIO_SetPinDirection
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,0
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
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,lo8(1)
	ldi r22,lo8(5)
	ldd r24,Y+1
	call GPIO_SetPinValue
	ldd r18,Y+2
	ldd r19,Y+3
	or r18,r24
	or r19,r25
	std Y+2,r18
	std Y+3,r19
	ldi r20,lo8(1)
	ldi r22,lo8(3)
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
	.size	BTN_Init, .-BTN_Init
	.section	.text.BTN_Update10ms,"ax",@progbits
.global	BTN_Update10ms
	.type	BTN_Update10ms, @function
BTN_Update10ms:
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 7 */
.L__stack_usage = 7
	std Y+2,r24
	ldi r16,lo8(s_buttons)
	ldi r17,hi8(s_buttons)
	mov r15,__zero_reg__
.L14:
	movw r20,r28
	subi r20,-1
	sbci r21,-1
	movw r30,r16
	ld r22,Z
	ldd r24,Y+2
	call GPIO_GetPinValue
	ldi r25,lo8(1)
	ldd r24,Y+1
	cpse r24,__zero_reg__
	ldi r25,0
.L3:
	movw r30,r16
	ldd r24,Z+1
	cpse r24,r25
	rjmp .L4
	ldd r24,Z+4
	cpi r24,lo8(5)
	brsh .L5
	subi r24,lo8(-(1))
	std Z+4,r24
	cpi r24,lo8(5)
	breq .L5
.L6:
	movw r30,r16
	ldd r24,Z+2
	ldd r25,Z+3
	cp r24,r25
	brne .+2
	rjmp .L7
	cpi r24,lo8(1)
	brne .L8
	ldi r18,lo8(1)
	std Z+8,r18
	std Z+9,__zero_reg__
	std Z+5,__zero_reg__
	std Z+6,__zero_reg__
	std Z+7,__zero_reg__
	std Z+3,r24
.L9:
	movw r30,r16
	ldd r24,Z+5
	ldd r25,Z+6
	cpi r24,100
	cpc r25,__zero_reg__
	brsh .L12
	adiw r24,1
	std Z+5,r24
	std Z+6,r25
.L12:
	ldi r31,lo8(2)
	cpse r15,r31
	rjmp .L11
	lds r24,s_buttons+25
	lds r25,s_buttons+26
	cpi r24,100
	cpc r25,__zero_reg__
	brlo .L11
	lds r24,s_buttons+27
	cpse r24,__zero_reg__
	rjmp .L11
	ldi r24,lo8(4)
	sts s_buttons+28,r24
	sts s_buttons+29,__zero_reg__
	ldi r24,lo8(1)
	sts s_buttons+27,r24
	rjmp .L11
.L4:
	std Z+1,r25
	std Z+4,__zero_reg__
	rjmp .L6
.L5:
	movw r30,r16
	std Z+2,r25
	rjmp .L6
.L8:
	ldd r25,Z+7
	ldi r18,lo8(3)
	cpse r25,__zero_reg__
	ldi r18,lo8(2)
.L25:
	std Z+8,r18
	std Z+9,__zero_reg__
	std Z+3,r24
.L11:
	inc r15
	subi r16,-10
	sbci r17,-1
	ldi r24,lo8(3)
	cpse r15,r24
	rjmp .L14
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
.L7:
	cpi r24,lo8(1)
	brne .L11
	rjmp .L9
	.size	BTN_Update10ms, .-BTN_Update10ms
	.section	.text.BTN_GetEvent,"ax",@progbits
.global	BTN_GetEvent
	.type	BTN_GetEvent, @function
BTN_GetEvent:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,3
	cpc r25,__zero_reg__
	brsh .L29
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L29
	ldi r18,lo8(10)
	mul r18,r24
	movw r30,r0
	mul r18,r25
	add r31,r0
	clr __zero_reg__
	subi r30,lo8(-(s_buttons))
	sbci r31,hi8(-(s_buttons))
	ldd r24,Z+8
	ldd r25,Z+9
	movw r26,r22
	st X+,r24
	st X+,r25
	std Z+8,__zero_reg__
	std Z+9,__zero_reg__
	ldi r24,0
	ldi r25,0
	ret
.L29:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	BTN_GetEvent, .-BTN_GetEvent
	.section	.text.BTN_IsPressed,"ax",@progbits
.global	BTN_IsPressed
	.type	BTN_IsPressed, @function
BTN_IsPressed:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r22,3
	cpc r23,__zero_reg__
	brsh .L33
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L33
	ldi r18,lo8(10)
	mul r18,r22
	movw r24,r0
	mul r18,r23
	add r25,r0
	clr __zero_reg__
	subi r24,lo8(-(s_buttons))
	sbci r25,hi8(-(s_buttons))
	movw r30,r24
	ldd r24,Z+2
	movw r30,r20
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L33:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	BTN_IsPressed, .-BTN_IsPressed
	.section	.data.s_buttons,"aw"
	.type	s_buttons, @object
	.size	s_buttons, 30
s_buttons:
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.word	0
	.byte	0
	.word	0
	.byte	5
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.word	0
	.byte	0
	.word	0
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.word	0
	.byte	0
	.word	0
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
