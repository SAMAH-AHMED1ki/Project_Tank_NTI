	.file	"Ringbuffer.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.RB_Init,"ax",@progbits
.global	RB_Init
	.type	RB_Init, @function
RB_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L1
	movw r30,r24
	subi r30,-64
	sbci r31,-1
	st Z,__zero_reg__
	adiw r30,1
	st Z,__zero_reg__
	adiw r30,1
	st Z,__zero_reg__
.L1:
/* epilogue start */
	ret
	.size	RB_Init, .-RB_Init
	.section	.text.RB_Put,"ax",@progbits
.global	RB_Put
	.type	RB_Put, @function
RB_Put:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L7
	in r18,__SREG__
/* #APP */
 ;  39 "LIB/Ringbuffer/Ringbuffer.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	movw r30,r24
	subi r30,-66
	sbci r31,-1
	ld r19,Z
	cpi r19,lo8(64)
	brlo .L8
	out __SREG__,r18
.L7:
	ldi r24,lo8(1)
	ldi r25,0
.L6:
/* epilogue start */
	pop r29
	pop r28
	ret
.L8:
	movw r26,r24
	subi r26,-64
	sbci r27,-1
	ld r19,X
	add r24,r19
	adc r25,__zero_reg__
	movw r28,r24
	st Y,r22
	ld r24,X
	subi r24,lo8(-(1))
	cpi r24,lo8(64)
	brlo .L10
	ldi r24,0
.L10:
	st X,r24
	ld r24,Z
	subi r24,lo8(-(1))
	st Z,r24
	out __SREG__,r18
	ldi r24,0
	ldi r25,0
	rjmp .L6
	.size	RB_Put, .-RB_Put
	.section	.text.RB_Get,"ax",@progbits
.global	RB_Get
	.type	RB_Get, @function
RB_Get:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbiw r24,0
	breq .L16
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L16
	in r18,__SREG__
/* #APP */
 ;  65 "LIB/Ringbuffer/Ringbuffer.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	movw r30,r24
	subi r30,-66
	sbci r31,-1
	ld r19,Z
	cpse r19,__zero_reg__
	rjmp .L17
	out __SREG__,r18
.L16:
	ldi r24,lo8(1)
	ldi r25,0
.L15:
/* epilogue start */
	pop r29
	pop r28
	ret
.L17:
	movw r26,r24
	subi r26,-65
	sbci r27,-1
	ld r19,X
	add r24,r19
	adc r25,__zero_reg__
	movw r28,r24
	ld r24,Y
	movw r28,r22
	st Y,r24
	ld r24,X
	subi r24,lo8(-(1))
	cpi r24,lo8(64)
	brlo .L19
	ldi r24,0
.L19:
	st X,r24
	ld r24,Z
	subi r24,lo8(-(-1))
	st Z,r24
	out __SREG__,r18
	ldi r24,0
	ldi r25,0
	rjmp .L15
	.size	RB_Get, .-RB_Get
	.section	.text.RB_IsEmpty,"ax",@progbits
.global	RB_IsEmpty
	.type	RB_IsEmpty, @function
RB_IsEmpty:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L30
	in r18,__SREG__
/* #APP */
 ;  92 "LIB/Ringbuffer/Ringbuffer.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	movw r30,r24
	subi r30,-66
	sbci r31,-1
	ld r25,Z
	out __SREG__,r18
	ldi r24,lo8(1)
	cp r25, __zero_reg__
	breq .L27
	ldi r24,0
	ret
.L30:
	ldi r24,lo8(1)
.L27:
/* epilogue start */
	ret
	.size	RB_IsEmpty, .-RB_IsEmpty
	.section	.text.RB_IsFull,"ax",@progbits
.global	RB_IsFull
	.type	RB_IsFull, @function
RB_IsFull:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L37
	in r18,__SREG__
/* #APP */
 ;  110 "LIB/Ringbuffer/Ringbuffer.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	movw r30,r24
	subi r30,-66
	sbci r31,-1
	ld r25,Z
	out __SREG__,r18
	ldi r24,lo8(1)
	cpi r25,lo8(64)
	brsh .L34
.L37:
	ldi r24,0
.L34:
/* epilogue start */
	ret
	.size	RB_IsFull, .-RB_IsFull
	.ident	"GCC: (GNU) 15.2.0"
