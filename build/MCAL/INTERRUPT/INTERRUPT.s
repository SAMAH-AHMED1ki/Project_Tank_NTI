	.file	"INTERRUPT.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.INTERRUPT_EnableGlobal,"ax",@progbits
.global	INTERRUPT_EnableGlobal
	.type	INTERRUPT_EnableGlobal, @function
INTERRUPT_EnableGlobal:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	ori r24,lo8(-128)
	out __SREG__,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_EnableGlobal, .-INTERRUPT_EnableGlobal
	.section	.text.INTERRUPT_DisableGlobal,"ax",@progbits
.global	INTERRUPT_DisableGlobal
	.type	INTERRUPT_DisableGlobal, @function
INTERRUPT_DisableGlobal:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,__SREG__
	andi r24,lo8(127)
	out __SREG__,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INTERRUPT_DisableGlobal, .-INTERRUPT_DisableGlobal
	.section	.text.EXTI_SetSense,"ax",@progbits
.global	EXTI_SetSense
	.type	EXTI_SetSense, @function
EXTI_SetSense:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L4
	cpi r24,lo8(2)
	breq .L5
	cpse r24,__zero_reg__
	rjmp .L12
	cpi r22,lo8(4)
	brsh .L12
	in r24,0x35
	andi r24,lo8(-4)
	out 0x35,r24
	in r24,0x35
	or r24,r22
	out 0x35,r24
.L7:
	ldi r24,0
	ldi r25,0
	ret
.L4:
	cpi r22,lo8(4)
	brsh .L12
	in r24,0x35
	andi r24,lo8(-13)
	out 0x35,r24
	in r24,0x35
	lsl r22
	lsl r22
	or r22,r24
	out 0x35,r22
	rjmp .L7
.L5:
	cpi r22,lo8(2)
	brne .L8
	in r24,0x34
	andi r24,lo8(-65)
.L13:
	out 0x34,r24
	rjmp .L7
.L8:
	cpi r22,lo8(3)
	brne .L12
	in r24,0x34
	ori r24,lo8(64)
	rjmp .L13
.L12:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_SetSense, .-EXTI_SetSense
	.section	.text.EXTI_ClearFlag,"ax",@progbits
.global	EXTI_ClearFlag
	.type	EXTI_ClearFlag, @function
EXTI_ClearFlag:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L15
	cpi r24,lo8(2)
	breq .L16
	cpse r24,__zero_reg__
	rjmp .L19
	in r24,0x3a
	ori r24,lo8(64)
.L20:
	out 0x3a,r24
	ldi r24,0
	ldi r25,0
	ret
.L15:
	in r24,0x3a
	ori r24,lo8(-128)
	rjmp .L20
.L16:
	in r24,0x3a
	ori r24,lo8(32)
	rjmp .L20
.L19:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_ClearFlag, .-EXTI_ClearFlag
	.section	.text.EXTI_Enable,"ax",@progbits
.global	EXTI_Enable
	.type	EXTI_Enable, @function
EXTI_Enable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L22
	cpi r24,lo8(2)
	breq .L23
	cpse r24,__zero_reg__
	rjmp .L26
	in r24,0x3a
	ori r24,lo8(64)
	out 0x3a,r24
	in r24,0x3b
	ori r24,lo8(64)
.L27:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
	ret
.L22:
	in r24,0x3a
	ori r24,lo8(-128)
	out 0x3a,r24
	in r24,0x3b
	ori r24,lo8(-128)
	rjmp .L27
.L23:
	in r24,0x3a
	ori r24,lo8(32)
	out 0x3a,r24
	in r24,0x3b
	ori r24,lo8(32)
	rjmp .L27
.L26:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Enable, .-EXTI_Enable
	.section	.text.EXTI_Disable,"ax",@progbits
.global	EXTI_Disable
	.type	EXTI_Disable, @function
EXTI_Disable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L29
	cpi r24,lo8(2)
	breq .L30
	cpse r24,__zero_reg__
	rjmp .L33
	in r24,0x3b
	andi r24,lo8(-65)
.L34:
	out 0x3b,r24
	ldi r24,0
	ldi r25,0
	ret
.L29:
	in r24,0x3b
	andi r24,lo8(127)
	rjmp .L34
.L30:
	in r24,0x3b
	andi r24,lo8(-33)
	rjmp .L34
.L33:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_Disable, .-EXTI_Disable
	.section	.text.EXTI_SetCallback,"ax",@progbits
.global	EXTI_SetCallback
	.type	EXTI_SetCallback, @function
EXTI_SetCallback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L41
	cpi r24,lo8(1)
	breq .L37
	cpi r24,lo8(2)
	breq .L38
	cpse r24,__zero_reg__
	rjmp .L41
	sts EXTI_INT0_Callback,r22
	sts EXTI_INT0_Callback+1,r23
.L39:
	ldi r24,0
	ldi r25,0
	ret
.L37:
	sts EXTI_INT1_Callback,r22
	sts EXTI_INT1_Callback+1,r23
	rjmp .L39
.L38:
	sts EXTI_INT2_Callback,r22
	sts EXTI_INT2_Callback+1,r23
	rjmp .L39
.L41:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	EXTI_SetCallback, .-EXTI_SetCallback
	.section	.text.__vector_1,"ax",@progbits
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,EXTI_INT0_Callback
	lds r31,EXTI_INT0_Callback+1
	sbiw r30,0
	breq .L42
	icall
.L42:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_1, .-__vector_1
	.section	.text.__vector_2,"ax",@progbits
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,EXTI_INT1_Callback
	lds r31,EXTI_INT1_Callback+1
	sbiw r30,0
	breq .L47
	icall
.L47:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_2, .-__vector_2
	.section	.text.__vector_3,"ax",@progbits
.global	__vector_3
	.type	__vector_3, @function
__vector_3:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	lds r30,EXTI_INT2_Callback
	lds r31,EXTI_INT2_Callback+1
	sbiw r30,0
	breq .L52
	icall
.L52:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_3, .-__vector_3
	.section	.bss.EXTI_INT2_Callback,"aw",@nobits
	.type	EXTI_INT2_Callback, @object
	.size	EXTI_INT2_Callback, 2
EXTI_INT2_Callback:
	.zero	2
	.section	.bss.EXTI_INT1_Callback,"aw",@nobits
	.type	EXTI_INT1_Callback, @object
	.size	EXTI_INT1_Callback, 2
EXTI_INT1_Callback:
	.zero	2
	.section	.bss.EXTI_INT0_Callback,"aw",@nobits
	.type	EXTI_INT0_Callback, @object
	.size	EXTI_INT0_Callback, 2
EXTI_INT0_Callback:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
