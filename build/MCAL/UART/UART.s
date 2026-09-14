	.file	"UART.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
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
	breq .L3
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
	ldi r24,lo8(-125)
	out 0x20,r24
	ldi r24,lo8(24)
	out 0xa,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
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
.L5:
	sbis 0xb,5
	rjmp .L6
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L6:
	out 0xc,r24
	rjmp .L5
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
	brne .L9
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
.L10:
	in r18,0xc
	movw r30,r24
	st Z,r18
.L9:
	sbis 0xb,7
	rjmp .L10
	ldi r24,0
	ldi r25,0
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
	brne .L14
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L12
.L15:
	call UART_SendByte
	subi r28,lo8(-(1))
.L14:
	movw r30,r16
	add r30,r28
	adc r31,__zero_reg__
	ld r24,Z
	cpse r24,__zero_reg__
	rjmp .L15
	ldi r24,0
	ldi r25,0
.L12:
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
	brne .L19
	sbi 0xa,7
.L20:
	ldi r24,0
	ldi r25,0
	ret
.L19:
	brsh .L22
	cbi 0xa,7
	rjmp .L20
.L22:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetRxInterrupt, .-UART_SetRxInterrupt
	.section	.text.UART_SetTxInterrupt,"ax",@progbits
.global	UART_SetTxInterrupt
	.type	UART_SetTxInterrupt, @function
UART_SetTxInterrupt:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	brne .L24
	sbi 0xa,5
.L25:
	ldi r24,0
	ldi r25,0
	ret
.L24:
	brsh .L27
	cbi 0xa,5
	rjmp .L25
.L27:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	UART_SetTxInterrupt, .-UART_SetTxInterrupt
	.ident	"GCC: (GNU) 15.2.0"
