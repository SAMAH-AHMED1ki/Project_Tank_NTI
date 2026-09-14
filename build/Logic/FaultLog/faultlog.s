	.file	"faultlog.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.FLG_WriteUint32,"ax",@progbits
	.type	FLG_WriteUint32, @function
FLG_WriteUint32:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,10
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 10 */
/* stack size = 21 */
.L__stack_usage = 21
	movw r12,r22
	movw r14,r24
	movw r8,r20
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L1
	cp r12,__zero_reg__
	cpc r13,__zero_reg__
	cpc r14,__zero_reg__
	cpc r15,__zero_reg__
	brne .L6
	ldi r24,lo8(48)
	movw r30,r20
/* epilogue start */
	adiw r28,10
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ijmp
.L6:
	ldi r17,0
	movw r10,r28
	ldi r31,-1
	sub r10,r31
	sbc r11,r31
.L3:
	movw r22,r12
	movw r24,r14
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r30,r10
	add r30,r17
	adc r31,__zero_reg__
	st Z,r22
	movw r24,r12
	movw r26,r14
	movw r12,r18
	movw r14,r20
	subi r17,lo8(-(1))
	sbiw r24,10
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brsh .L3
	movw r14,r10
	add r14,r17
	adc r15,__zero_reg__
.L4:
	cp r10,r14
	cpc r11,r15
	brne .L5
.L1:
/* epilogue start */
	adiw r28,10
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
.L5:
	movw r30,r14
	ld r24,-Z
	movw r14,r30
	subi r24,lo8(-(48))
	movw r30,r8
	icall
	rjmp .L4
	.size	FLG_WriteUint32, .-FLG_WriteUint32
	.section	.text.FLG_Init,"ax",@progbits
.global	FLG_Init
	.type	FLG_Init, @function
FLG_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L11
	movw r30,r24
	movw r18,r24
	subi r18,112
	sbci r19,-1
.L13:
	st Z,__zero_reg__
	std Z+1,__zero_reg__
	std Z+2,__zero_reg__
	std Z+3,__zero_reg__
	std Z+4,__zero_reg__
	std Z+5,__zero_reg__
	std Z+6,__zero_reg__
	std Z+7,__zero_reg__
	std Z+8,__zero_reg__
	adiw r30,9
	cp r30,r18
	cpc r31,r19
	brne .L13
	st Z,__zero_reg__
	movw r30,r24
	subi r30,111
	sbci r31,-1
	st Z+,__zero_reg__
	st Z,__zero_reg__
.L11:
/* epilogue start */
	ret
	.size	FLG_Init, .-FLG_Init
	.section	.text.FLG_Append,"ax",@progbits
.global	FLG_Append
	.type	FLG_Append, @function
FLG_Append:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r30,r22
	sbiw r24,0
	breq .L26
	sbiw r30,0
	breq .L26
	movw r22,r24
	subi r22,110
	sbci r23,-1
	movw r26,r22
	ld r19,X
	movw r20,r24
	subi r20,112
	sbci r21,-1
	movw r28,r20
	ld r26,Y
	ldi r18,lo8(1)
	add r18,r26
	ldi r29,lo8(9)
	mul r26,r29
	movw r26,r0
	clr __zero_reg__
	add r26,r24
	adc r27,r25
	cpi r19,lo8(16)
	brlo .L20
	ldi r19,lo8(9)
	0:
	ld r0,Z+
	st X+,r0
	dec r19
	brne 0b
	cpi r18,lo8(16)
	brlo .L21
	ldi r18,0
.L21:
	movw r30,r20
	st Z,r18
	movw r26,r24
	subi r26,111
	sbci r27,-1
	ld r25,X
	subi r25,lo8(-(1))
	cpi r25,lo8(16)
	brlo .L22
	ldi r25,0
.L22:
	st X,r25
.L24:
	ldi r24,0
	ldi r25,0
.L18:
/* epilogue start */
	pop r29
	pop r28
	ret
.L20:
	ldi r24,lo8(9)
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	cpi r18,lo8(16)
	brlo .L23
	ldi r18,0
.L23:
	movw r26,r20
	st X,r18
	subi r19,lo8(-(1))
	movw r28,r22
	st Y,r19
	rjmp .L24
.L26:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L18
	.size	FLG_Append, .-FLG_Append
	.section	.text.FLG_GetCount,"ax",@progbits
.global	FLG_GetCount
	.type	FLG_GetCount, @function
FLG_GetCount:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L32
	movw r30,r24
	subi r30,110
	sbci r31,-1
	ld r24,Z
	ret
.L32:
	ldi r24,0
/* epilogue start */
	ret
	.size	FLG_GetCount, .-FLG_GetCount
	.section	.text.FLG_IsFull,"ax",@progbits
.global	FLG_IsFull
	.type	FLG_IsFull, @function
FLG_IsFull:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L36
	movw r30,r24
	subi r30,110
	sbci r31,-1
	ldi r24,lo8(1)
	ld r25,Z
	cpi r25,lo8(16)
	brsh .L33
.L36:
	ldi r24,0
.L33:
/* epilogue start */
	ret
	.size	FLG_IsFull, .-FLG_IsFull
	.section	.text.FLG_GetNewestFirst,"ax",@progbits
.global	FLG_GetNewestFirst
	.type	FLG_GetNewestFirst, @function
FLG_GetNewestFirst:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	sbiw r24,0
	breq .L41
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L41
	movw r26,r24
	subi r26,110
	sbci r27,-1
	ld r24,X
	cp r22,r24
	brsh .L41
	sbiw r26,2
	ldi r25,lo8(15)
	sub r25,r22
	ld r24,X
	add r25,r24
	andi r25,lo8(15)
	ldi r24,lo8(9)
	mul r24,r25
	add r30,r0
	adc r31,r1
	clr __zero_reg__
	movw r26,r20
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	ldi r24,0
	ldi r25,0
	ret
.L41:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	FLG_GetNewestFirst, .-FLG_GetNewestFirst
	.section	.text.FLG_Clear,"ax",@progbits
.global	FLG_Clear
	.type	FLG_Clear, @function
FLG_Clear:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L42
	jmp FLG_Init
.L42:
/* epilogue start */
	ret
	.size	FLG_Clear, .-FLG_Clear
	.section	.rodata.FLG_Dump.str1.1,"aMS",@progbits,1
.LC0:
	.string	"FLT,"
	.section	.text.FLG_Dump,"ax",@progbits
.global	FLG_Dump
	.type	FLG_Dump, @function
FLG_Dump:
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 8 */
/* stack size = 22 */
.L__stack_usage = 22
	movw r16,r24
	std Y+7,r22
	std Y+8,r23
	sbiw r24,0
	breq .L44
	or r22,r23
	breq .L44
	movw r10,r24
	ldi r24,-110
	add r10,r24
	adc r11,__zero_reg__
	movw r26,r10
	ld r24,X
	cp r24, __zero_reg__
	breq .L44
	mov r9,__zero_reg__
	movw r30,r16
	subi r30,112
	sbci r31,-1
	std Y+5,r30
	std Y+6,r31
.L47:
	movw r26,r10
	ld r24,X
	cp r9,r24
	brlo .L49
.L44:
/* epilogue start */
	adiw r28,8
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	ret
.L49:
	ldd r26,Y+5
	ldd r27,Y+6
	ld r24,X
	subi r24,lo8(-(15))
	sub r24,r9
	andi r24,lo8(15)
	movw r30,r16
	ldi r27,lo8(9)
	mul r24,r27
	add r30,r0
	adc r31,r1
	clr __zero_reg__
	ld r8,Z
	ldd r24,Z+1
	ldd r25,Z+2
	ldd r26,Z+3
	ldd r27,Z+4
	std Y+1,r24
	std Y+2,r25
	std Y+3,r26
	std Y+4,r27
	ldd r7,Z+5
	ldd r6,Z+6
	ldd r14,Z+7
	ldd r15,Z+8
	ldi r24,lo8(.LC0)
	mov r12,r24
	ldi r24,hi8(.LC0)
	mov r13,r24
.L48:
	movw r26,r12
	ld r24,X+
	movw r12,r26
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	ldi r31,lo8(.LC0+4)
	cp r12,r31
	ldi r31,hi8(.LC0+4)
	cpc r13,r31
	brne .L48
	mov r22,r9
	ldi r23,0
	ldi r24,0
	ldi r25,0
	ldd r20,Y+7
	ldd r21,Y+8
	call FLG_WriteUint32
	ldi r24,lo8(44)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	mov r22,r8
	ldi r23,0
	ldi r24,0
	ldi r25,0
	ldd r20,Y+7
	ldd r21,Y+8
	call FLG_WriteUint32
	ldi r24,lo8(44)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	ldd r20,Y+7
	ldd r21,Y+8
	ldd r22,Y+1
	ldd r23,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	call FLG_WriteUint32
	ldi r24,lo8(44)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	mov r22,r7
	ldi r23,0
	ldi r24,0
	ldi r25,0
	ldd r20,Y+7
	ldd r21,Y+8
	call FLG_WriteUint32
	ldi r24,lo8(44)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	mov r22,r6
	ldi r23,0
	ldi r24,0
	ldi r25,0
	ldd r20,Y+7
	ldd r21,Y+8
	call FLG_WriteUint32
	ldi r24,lo8(44)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	movw r22,r14
	ldi r24,0
	ldi r25,0
	ldd r20,Y+7
	ldd r21,Y+8
	call FLG_WriteUint32
	ldi r24,lo8(13)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	ldi r24,lo8(10)
	ldd r30,Y+7
	ldd r31,Y+8
	icall
	inc r9
	rjmp .L47
	.size	FLG_Dump, .-FLG_Dump
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
