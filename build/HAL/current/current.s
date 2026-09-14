	.file	"current.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.CUR_Init,"ax",@progbits
.global	CUR_Init
	.type	CUR_Init, @function
CUR_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_u16CurrentmA,__zero_reg__
	sts Global_u16CurrentmA+1,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	CUR_Init, .-CUR_Init
	.section	.text.CUR_Update,"ax",@progbits
.global	CUR_Update
	.type	CUR_Update, @function
CUR_Update:
	push r12
	push r13
	push r14
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
/* stack size = 10 */
.L__stack_usage = 10
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(2)
	call ADC_ReadChannel
	movw r16,r24
	or r24,r25
	brne .L2
	ldd r18,Y+1
	ldd r19,Y+2
	ldi r26,lo8(16)
	ldi r27,lo8(39)
	call __umulhisi3
	ldi r18,lo8(-1)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	lds r22,Global_u16CurrentmA
	lds r23,Global_u16CurrentmA+1
	movw r24,r22
	lsl r24
	rol r25
	add r24,r22
	adc r25,r23
	movw r12,r18
	movw r14,r20
	add r12,r24
	adc r13,r25
	adc r14,__zero_reg__
	adc r15,__zero_reg__
	movw r24,r12
	movw r26,r14
	ldi r31,2
	1:
	lsr r27
	ror r26
	ror r25
	ror r24
	dec r31
	brne 1b
	sts Global_u16CurrentmA,r24
	sts Global_u16CurrentmA+1,r25
.L2:
	movw r24,r16
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	CUR_Update, .-CUR_Update
	.section	.text.CUR_GetmA,"ax",@progbits
.global	CUR_GetmA
	.type	CUR_GetmA, @function
CUR_GetmA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L6
	lds r18,Global_u16CurrentmA
	lds r19,Global_u16CurrentmA+1
	movw r30,r24
	st Z,r18
	std Z+1,r19
	ldi r24,0
	ldi r25,0
	ret
.L6:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	CUR_GetmA, .-CUR_GetmA
	.section	.text.CUR_IsOverLimit,"ax",@progbits
.global	CUR_IsOverLimit
	.type	CUR_IsOverLimit, @function
CUR_IsOverLimit:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r20,r24
	ldi r24,lo8(1)
	lds r18,Global_u16CurrentmA
	lds r19,Global_u16CurrentmA+1
	cp r20,r18
	cpc r21,r19
	brlo .L8
	ldi r24,0
.L8:
/* epilogue start */
	ret
	.size	CUR_IsOverLimit, .-CUR_IsOverLimit
	.section	.bss.Global_u16CurrentmA,"aw",@nobits
	.type	Global_u16CurrentmA, @object
	.size	Global_u16CurrentmA, 2
Global_u16CurrentmA:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
