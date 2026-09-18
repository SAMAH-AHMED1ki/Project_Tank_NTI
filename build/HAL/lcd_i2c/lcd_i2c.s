	.file	"lcd_i2c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LCD_I2C_Write,"ax",@progbits
	.type	LCD_I2C_Write, @function
LCD_I2C_Write:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	mov r29,r24
	mov r28,r22
	call I2C_SendStart
	or r24,r25
	brne .L2
	ldi r24,lo8(62)
	call I2C_SendSlaveAddressWithWrite
	or r24,r25
	breq .L3
.L5:
	call I2C_SendStop
.L2:
	ldi r28,lo8(1)
	ldi r29,0
.L1:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L3:
	mov r24,r29
	call I2C_SendByte
	or r24,r25
	brne .L5
	mov r24,r28
	call I2C_SendByte
	movw r28,r24
	or r24,r25
	brne .L5
	call I2C_SendStop
	rjmp .L1
	.size	LCD_I2C_Write, .-LCD_I2C_Write
	.section	.text.LCD_I2C_SendCommand,"ax",@progbits
.global	LCD_I2C_SendCommand
	.type	LCD_I2C_SendCommand, @function
LCD_I2C_SendCommand:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,r24
	ldi r24,0
	call LCD_I2C_Write
	ldi r30,lo8(3999)
	ldi r31,hi8(3999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
/* epilogue start */
	ret
	.size	LCD_I2C_SendCommand, .-LCD_I2C_SendCommand
	.section	.text.LCD_I2C_SendData,"ax",@progbits
.global	LCD_I2C_SendData
	.type	LCD_I2C_SendData, @function
LCD_I2C_SendData:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,r24
	ldi r24,lo8(64)
	call LCD_I2C_Write
	ldi r30,lo8(1999)
	ldi r31,hi8(1999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
/* epilogue start */
	ret
	.size	LCD_I2C_SendData, .-LCD_I2C_SendData
	.section	.text.LCD_I2C_Init,"ax",@progbits
.global	LCD_I2C_Init
	.type	LCD_I2C_Init, @function
LCD_I2C_Init:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(56)
	call LCD_I2C_SendCommand
	or r24,r25
	breq .L9
.L11:
	ldi r28,lo8(1)
	ldi r29,0
.L8:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L9:
	ldi r24,lo8(9999)
	ldi r25,hi8(9999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(57)
	call LCD_I2C_SendCommand
	or r24,r25
	brne .L11
	ldi r24,lo8(1999)
	ldi r25,hi8(1999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(20)
	call LCD_I2C_SendCommand
	movw r28,r24
	or r24,r25
	brne .L11
	ldi r24,lo8(112)
	call LCD_I2C_SendCommand
	ldi r24,lo8(86)
	call LCD_I2C_SendCommand
	ldi r24,lo8(108)
	call LCD_I2C_SendCommand
	ldi r25,lo8(319999)
	ldi r18,hi8(319999)
	ldi r24,hlo8(319999)
1:	subi r25,1
	sbci r18,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(56)
	call LCD_I2C_SendCommand
	ldi r24,lo8(12)
	call LCD_I2C_SendCommand
	ldi r24,lo8(1)
	call LCD_I2C_SendCommand
	ldi r24,lo8(9999)
	ldi r25,hi8(9999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(6)
	call LCD_I2C_SendCommand
	rjmp .L8
	.size	LCD_I2C_Init, .-LCD_I2C_Init
	.section	.text.LCD_I2C_SendChar,"ax",@progbits
.global	LCD_I2C_SendChar
	.type	LCD_I2C_SendChar, @function
LCD_I2C_SendChar:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp LCD_I2C_SendData
	.size	LCD_I2C_SendChar, .-LCD_I2C_SendChar
	.section	.text.LCD_I2C_SendString,"ax",@progbits
.global	LCD_I2C_SendString
	.type	LCD_I2C_SendString, @function
LCD_I2C_SendString:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	or r24,r25
	brne .L15
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L13
.L16:
	adiw r28,1
	call LCD_I2C_SendChar
.L15:
	ld r24,Y
	cpse r24,__zero_reg__
	rjmp .L16
	ldi r24,0
	ldi r25,0
.L13:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	LCD_I2C_SendString, .-LCD_I2C_SendString
	.section	.text.LCD_I2C_SetCursor,"ax",@progbits
.global	LCD_I2C_SetCursor
	.type	LCD_I2C_SetCursor, @function
LCD_I2C_SetCursor:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	brsh .L18
	cpi r22,lo8(16)
	brsh .L18
	cpse r24,__zero_reg__
	subi r22,lo8(-(64))
.L20:
	mov r24,r22
	ori r24,lo8(-128)
	jmp LCD_I2C_SendCommand
.L18:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	LCD_I2C_SetCursor, .-LCD_I2C_SetCursor
	.section	.text.LCD_I2C_Clear,"ax",@progbits
.global	LCD_I2C_Clear
	.type	LCD_I2C_Clear, @function
LCD_I2C_Clear:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	call LCD_I2C_SendCommand
	ldi r30,lo8(9999)
	ldi r31,hi8(9999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
/* epilogue start */
	ret
	.size	LCD_I2C_Clear, .-LCD_I2C_Clear
	.section	.text.LCD_I2C_SendNumber,"ax",@progbits
.global	LCD_I2C_SendNumber
	.type	LCD_I2C_SendNumber, @function
LCD_I2C_SendNumber:
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
	movw r18,r24
	or r24,r25
	brne .L31
	ldi r24,lo8(48)
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
	jmp LCD_I2C_SendData
.L31:
	ldi r20,0
	ldi r30,lo8(10)
	ldi r31,0
	movw r14,r28
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
.L28:
	movw r24,r18
	movw r22,r30
	call __udivmodhi4
	movw r26,r14
	add r26,r20
	adc r27,__zero_reg__
	subi r24,lo8(-(48))
	st X,r24
	movw r24,r18
	movw r18,r22
	subi r20,lo8(-(1))
	sbiw r24,10
	brsh .L28
	movw r16,r14
	add r16,r20
	adc r17,__zero_reg__
.L29:
	cp r14,r16
	cpc r15,r17
	brne .L30
	ldi r24,0
	ldi r25,0
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
.L30:
	movw r30,r16
	ld r24,-Z
	movw r16,r30
	call LCD_I2C_SendChar
	rjmp .L29
	.size	LCD_I2C_SendNumber, .-LCD_I2C_SendNumber
	.ident	"GCC: (GNU) 15.2.0"
