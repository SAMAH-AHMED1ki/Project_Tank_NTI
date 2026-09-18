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
	sts Global_u8SampleIndex,__zero_reg__
	sts Global_u32SampleSum,__zero_reg__
	sts Global_u32SampleSum+1,__zero_reg__
	sts Global_u32SampleSum+2,__zero_reg__
	sts Global_u32SampleSum+3,__zero_reg__
	sts Global_u16Samples,__zero_reg__
	sts Global_u16Samples+1,__zero_reg__
	sts Global_u16Samples+2,__zero_reg__
	sts Global_u16Samples+3,__zero_reg__
	sts Global_u16Samples+4,__zero_reg__
	sts Global_u16Samples+5,__zero_reg__
	sts Global_u16Samples+6,__zero_reg__
	sts Global_u16Samples+7,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	CUR_Init, .-CUR_Init
	.section	.text.CUR_Update,"ax",@progbits
.global	CUR_Update
	.type	CUR_Update, @function
CUR_Update:
	push r8
	push r9
	push r10
	push r11
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
/* stack size = 13 */
.L__stack_usage = 13
	std Y+1,__zero_reg__
	std Y+2,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	ldi r24,lo8(2)
	call ADC_ReadChannel
	movw r16,r24
	or r24,r25
	breq .+2
	rjmp .L2
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
	lds r13,Global_u8SampleIndex
	mov r22,r13
	ldi r23,0
	movw r24,r18
	ldi r26,0
	ldi r27,0
	movw r14,r22
	lsl r14
	rol r15
	movw r30,r14
	subi r30,lo8(-(Global_u16Samples))
	sbci r31,hi8(-(Global_u16Samples))
	ld r22,Z
	ldd r23,Z+1
	sub r24,r22
	sbc r25,r23
	sbc r26,__zero_reg__
	sbc r27,__zero_reg__
	lds r8,Global_u32SampleSum
	lds r9,Global_u32SampleSum+1
	lds r10,Global_u32SampleSum+2
	lds r11,Global_u32SampleSum+3
	add r24,r8
	adc r25,r9
	adc r26,r10
	adc r27,r11
	ldi r22,lo8(1)
	add r22,r13
	cpi r22,lo8(4)
	brlo .L4
	ldi r22,0
.L4:
	movw r30,r14
	subi r30,lo8(-(Global_u16Samples))
	sbci r31,hi8(-(Global_u16Samples))
	st Z,r18
	std Z+1,r19
	sts Global_u32SampleSum,r24
	sts Global_u32SampleSum+1,r25
	sts Global_u32SampleSum+2,r26
	sts Global_u32SampleSum+3,r27
	sts Global_u8SampleIndex,r22
	ldi r18,2
	1:
	lsr r27
	ror r26
	ror r25
	ror r24
	dec r18
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
	pop r11
	pop r10
	pop r9
	pop r8
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
	breq .L8
	lds r18,Global_u16CurrentmA
	lds r19,Global_u16CurrentmA+1
	movw r30,r24
	st Z,r18
	std Z+1,r19
	ldi r24,0
	ldi r25,0
	ret
.L8:
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
	brlo .L10
	ldi r24,0
.L10:
/* epilogue start */
	ret
	.size	CUR_IsOverLimit, .-CUR_IsOverLimit
	.section	.bss.Global_u32SampleSum,"aw",@nobits
	.type	Global_u32SampleSum, @object
	.size	Global_u32SampleSum, 4
Global_u32SampleSum:
	.zero	4
	.section	.bss.Global_u8SampleIndex,"aw",@nobits
	.type	Global_u8SampleIndex, @object
	.size	Global_u8SampleIndex, 1
Global_u8SampleIndex:
	.zero	1
	.section	.bss.Global_u16Samples,"aw",@nobits
	.type	Global_u16Samples, @object
	.size	Global_u16Samples, 8
Global_u16Samples:
	.zero	8
	.section	.bss.Global_u16CurrentmA,"aw",@nobits
	.type	Global_u16CurrentmA, @object
	.size	Global_u16CurrentmA, 2
Global_u16CurrentmA:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
