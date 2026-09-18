	.file	"UART.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.__vector_13,"ax",@progbits
.global	__vector_13
	.type	__vector_13, @function
__vector_13:
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
	in r22,0xc
	lds r24,g_uartRxBuffer
	lds r25,g_uartRxBuffer+1
	sbiw r24,0
	breq .L1
	call RB_Put
.L1:
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
	.size	__vector_13, .-__vector_13
	.section	.text.UART_Init,"ax",@progbits
.global	UART_Init
	.type	UART_Init, @function
UART_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	sbci r23,hi8(0)
	sbci r22,lo8(0)
	breq .L8
	movw r18,r22
	movw r20,r24
	ldi r24,4
	1:
	lsl r18
	rol r19
	rol r20
	rol r21
	dec r24
	brne 1b
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	subi r18,1
	sbc r19,__zero_reg__
	out 0x20,r19
	out 0x9,r18
	ldi r24,lo8(-122)
	out 0x20,r24
	ldi r24,lo8(24)
	out 0xa,r24
	ldi r24,0
	ldi r25,0
	ret
.L8:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_Init, .-UART_Init
	.section	.text.UART_SendByte,"ax",@progbits
.global	UART_SendByte
	.type	UART_SendByte, @function
UART_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L10:
	sbis 0xb,5
	rjmp .L10
	out 0xc,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SendByte, .-UART_SendByte
	.section	.text.UART_ReceiveByte,"ax",@progbits
.global	UART_ReceiveByte
	.type	UART_ReceiveByte, @function
UART_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L16
.L15:
	sbis 0xb,7
	rjmp .L15
	in r18,0xc
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
	ret
.L16:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_ReceiveByte, .-UART_ReceiveByte
	.section	.text.UART_SendString,"ax",@progbits
.global	UART_SendString
	.type	UART_SendString, @function
UART_SendString:
	push r16
	push r17
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r16,r24
	ldi r28,0
	or r24,r25
	brne .L21
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L19
.L22:
	call UART_SendByte
	subi r28,lo8(-(1))
.L21:
	movw r30,r16
	add r30,r28
	adc r31,__zero_reg__
	ld r24,Z
	cpse r24,__zero_reg__
	rjmp .L22
	ldi r24,0
	ldi r25,0
.L19:
/* epilogue start */
	pop r28
	pop r17
	pop r16
	ret
	.size	UART_SendString, .-UART_SendString
	.section	.text.UART_IsDataReady,"ax",@progbits
.global	UART_IsDataReady
	.type	UART_IsDataReady, @function
UART_IsDataReady:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	clr r24
	sbis 0xb,7
	inc r24
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_IsDataReady, .-UART_IsDataReady
	.section	.text.UART_SetRxInterrupt,"ax",@progbits
.global	UART_SetRxInterrupt
	.type	UART_SetRxInterrupt, @function
UART_SetRxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	brne .L26
	sbi 0xa,7
.L27:
	ldi r24,0
	ldi r25,0
	ret
.L26:
	brsh .L29
	cbi 0xa,7
	rjmp .L27
.L29:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetRxInterrupt, .-UART_SetRxInterrupt
	.section	.text.UART_SetRxBuffer,"ax",@progbits
.global	UART_SetRxBuffer
	.type	UART_SetRxBuffer, @function
UART_SetRxBuffer:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts g_uartRxBuffer,r24
	sts g_uartRxBuffer+1,r25
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetRxBuffer, .-UART_SetRxBuffer
	.section	.text.UART_SetTxInterrupt,"ax",@progbits
.global	UART_SetTxInterrupt
	.type	UART_SetTxInterrupt, @function
UART_SetTxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	brne .L32
	sbi 0xa,5
.L33:
	ldi r24,0
	ldi r25,0
	ret
.L32:
	brsh .L35
	cbi 0xa,5
	rjmp .L33
.L35:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetTxInterrupt, .-UART_SetTxInterrupt
	.section	.bss.g_uartRxBuffer,"aw",@nobits
	.type	g_uartRxBuffer, @object
	.size	g_uartRxBuffer, 2
g_uartRxBuffer:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
