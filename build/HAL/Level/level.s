	.file	"level.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LEVEL_Init,"ax",@progbits
.global	LEVEL_Init
	.type	LEVEL_Init, @function
LEVEL_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(6)
	ldi r24,lo8(1)
	jmp ADC_Init
	.size	LEVEL_Init, .-LEVEL_Init
	.section	.text.LEVEL_ReadPercentage,"ax",@progbits
.global	LEVEL_ReadPercentage
	.type	LEVEL_ReadPercentage, @function
LEVEL_ReadPercentage:
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
	mov r17,r24
	movw r14,r22
	or r22,r23
	brne .L3
.L5:
	ldi r16,lo8(1)
	ldi r17,0
.L2:
	movw r24,r16
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
.L3:
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	call ADC_ReadChannel
	or r24,r25
	brne .L5
	movw r22,r28
	subi r22,-3
	sbci r23,-1
	mov r24,r17
	call ADC_ReadChannel
	or r24,r25
	brne .L5
	movw r22,r28
	subi r22,-5
	sbci r23,-1
	mov r24,r17
	call ADC_ReadChannel
	movw r16,r24
	or r24,r25
	brne .L5
	ldd r20,Y+1
	ldd r21,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	cp r24,r20
	cpc r25,r21
	brlo .L6
	mov r19,r20
	mov r18,r21
	movw r20,r24
	mov r24,r19
	mov r25,r18
.L6:
	ldd r18,Y+5
	ldd r19,Y+6
	cp r20,r18
	cpc r21,r19
	brsh .L7
	movw r18,r20
.L7:
	cp r18,r24
	cpc r19,r25
	brsh .L8
	movw r18,r24
.L8:
	ldi r26,lo8(100)
	ldi r27,0
	call __umulhisi3
	cpi r22,-101
	ldi r18,-109
	cpc r23,r18
	ldi r18,1
	cpc r24,r18
	cpc r25,__zero_reg__
	brsh .L10
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
.L9:
	movw r30,r14
	st Z,r18
	rjmp .L2
.L10:
	ldi r18,lo8(100)
	rjmp .L9
	.size	LEVEL_ReadPercentage, .-LEVEL_ReadPercentage
	.section	.text.LEVEL_GetBand,"ax",@progbits
.global	LEVEL_GetBand
	.type	LEVEL_GetBand, @function
LEVEL_GetBand:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r22
	sbiw r30,0
	breq .L18
	cpi r24,lo8(10)
	brsh .L13
	st Z,__zero_reg__
	std Z+1,__zero_reg__
.L15:
	ldi r24,0
	ldi r25,0
	ret
.L13:
	cpi r24,lo8(30)
	brsh .L14
	ldi r24,lo8(1)
.L19:
	st Z,r24
	std Z+1,__zero_reg__
	rjmp .L15
.L14:
	cpi r24,lo8(90)
	brsh .L16
	ldi r24,lo8(2)
	rjmp .L19
.L16:
	cpi r24,lo8(99)
	brsh .L17
	ldi r24,lo8(3)
	rjmp .L19
.L17:
	ldi r24,lo8(4)
	rjmp .L19
.L18:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	LEVEL_GetBand, .-LEVEL_GetBand
	.ident	"GCC: (GNU) 15.2.0"
