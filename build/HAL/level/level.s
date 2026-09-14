	.file	"level.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LVL_Init,"ax",@progbits
.global	LVL_Init
	.type	LVL_Init, @function
LVL_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts loc_u8PreviousPercent,__zero_reg__
	ldi r24,lo8(1)
	sts loc_u8IsFirstRead,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	LVL_Init, .-LVL_Init
	.section	.text.LVL_Update,"ax",@progbits
.global	LVL_Update
	.type	LVL_Update, @function
LVL_Update:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	rcall .
	rcall .
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 7 */
/* stack size = 13 */
.L__stack_usage = 13
	std Y+7,r24
	movw r14,r22
	or r22,r23
	brne .L3
.L5:
	ldi r16,lo8(1)
	ldi r17,0
.L2:
	movw r24,r16
/* epilogue start */
	adiw r28,7
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
	ret
.L3:
	std Y+5,__zero_reg__
	std Y+6,__zero_reg__
	std Y+3,__zero_reg__
	std Y+4,__zero_reg__
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	movw r22,r28
	subi r22,-5
	sbci r23,-1
	ldd r24,Y+7
	call ADC_ReadChannel
	or r24,r25
	brne .L5
	movw r22,r28
	subi r22,-3
	sbci r23,-1
	ldd r24,Y+7
	call ADC_ReadChannel
	or r24,r25
	brne .L5
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldd r24,Y+7
	call ADC_ReadChannel
	movw r16,r24
	or r24,r25
	brne .L5
	ldd r20,Y+1
	ldd r21,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r18,Y+5
	ldd r19,Y+6
	ldi r23,lo8(1)
	cp r24,r18
	cpc r25,r19
	brlo .L7
	ldi r23,0
.L7:
	ldi r22,lo8(1)
	cp r20,r18
	cpc r21,r19
	brlo .L8
	ldi r22,0
.L8:
	cpse r23,r22
	rjmp .L6
	ldi r22,lo8(1)
	cp r18,r24
	cpc r19,r25
	brlo .L9
	ldi r22,0
.L9:
	ldi r18,lo8(1)
	cp r20,r24
	cpc r21,r25
	brlo .L10
	ldi r18,0
.L10:
	cp r22,r18
	breq .L13
	movw r18,r24
.L6:
	cpi r19,4
	brlo .L11
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
.L11:
	ldi r26,lo8(100)
	ldi r27,0
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r30,r14
	st Z,r18
	ldd r31,Y+7
	cpse r31,__zero_reg__
	rjmp .L2
	lds r24,loc_u8IsFirstRead
	cp r24, __zero_reg__
	brne .+2
	rjmp .L2
	sts loc_u8PreviousPercent,r18
	sts loc_u8IsFirstRead,__zero_reg__
	rjmp .L2
.L13:
	movw r18,r20
	rjmp .L6
	.size	LVL_Update, .-LVL_Update
	.section	.text.LVL_GetPercent,"ax",@progbits
.global	LVL_GetPercent
	.type	LVL_GetPercent, @function
LVL_GetPercent:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L18
	movw r22,r24
	ldi r24,0
	jmp LVL_Update
.L18:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	LVL_GetPercent, .-LVL_GetPercent
	.section	.text.LVL_GetRate,"ax",@progbits
.global	LVL_GetRate
	.type	LVL_GetRate, @function
LVL_GetRate:
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 5 */
.L__stack_usage = 5
	movw r16,r24
	or r24,r25
	brne .L20
.L22:
	ldi r24,lo8(1)
	ldi r25,0
.L19:
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L20:
	std Y+1,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,0
	call LVL_Update
	sbiw r24,0
	brne .L22
	ldd r18,Y+1
	movw r20,r18
	lds r19,loc_u8PreviousPercent
	sub r20,r19
	movw r30,r16
	st Z,r20
	sts loc_u8PreviousPercent,r18
	rjmp .L19
	.size	LVL_GetRate, .-LVL_GetRate
	.section	.data.loc_u8IsFirstRead,"aw"
	.type	loc_u8IsFirstRead, @object
	.size	loc_u8IsFirstRead, 1
loc_u8IsFirstRead:
	.byte	1
	.section	.bss.loc_u8PreviousPercent,"aw",@nobits
	.type	loc_u8PreviousPercent, @object
	.size	loc_u8PreviousPercent, 1
loc_u8PreviousPercent:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
