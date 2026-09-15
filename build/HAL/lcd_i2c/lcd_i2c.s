	.file	"lcd_i2c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.LCD_I2C_WriteNibble,"ax",@progbits
	.type	LCD_I2C_WriteNibble, @function
LCD_I2C_WriteNibble:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	mov r17,r24
	or r17,r22
	call I2C_SendStart
	movw r28,r24
	ldi r24,lo8(39)
	call I2C_SendSlaveAddressWithWrite
	or r28,r24
	or r29,r25
	mov r24,r17
	ori r24,lo8(12)
	call I2C_SendByte
	or r28,r24
	or r29,r25
	ldi r24,lo8(2)
1:	dec r24
	brne 1b
	rjmp .
	mov r24,r17
	ori r24,lo8(8)
	call I2C_SendByte
	or r28,r24
	or r29,r25
	ldi r24,lo8(-123)
1:	dec r24
	brne 1b
	nop
	call I2C_SendStop
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
	.size	LCD_I2C_WriteNibble, .-LCD_I2C_WriteNibble
	.section	.text.LCD_I2C_SendCommand,"ax",@progbits
.global	LCD_I2C_SendCommand
	.type	LCD_I2C_SendCommand, @function
LCD_I2C_SendCommand:
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+3,r24
	ldi r22,0
	andi r24,lo8(-16)
	call LCD_I2C_WriteNibble
	std Y+1,r24
	std Y+2,r25
	ldi r22,0
	ldd r24,Y+3
	swap r24
	andi r24,lo8(-16)
	call LCD_I2C_WriteNibble
	ldd r18,Y+1
	ldd r19,Y+2
	or r24,r18
	or r25,r19
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	LCD_I2C_SendCommand, .-LCD_I2C_SendCommand
	.section	.text.LCD_I2C_SendChar,"ax",@progbits
.global	LCD_I2C_SendChar
	.type	LCD_I2C_SendChar, @function
LCD_I2C_SendChar:
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+3,r24
	ldi r22,lo8(1)
	andi r24,lo8(-16)
	call LCD_I2C_WriteNibble
	std Y+1,r24
	std Y+2,r25
	ldi r22,lo8(1)
	ldd r24,Y+3
	swap r24
	andi r24,lo8(-16)
	call LCD_I2C_WriteNibble
	ldd r18,Y+1
	ldd r19,Y+2
	or r24,r18
	or r25,r19
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
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
	brne .L7
.L8:
	ldi r24,lo8(1)
	ldi r25,0
.L4:
/* epilogue start */
	pop r29
	pop r28
	ret
.L9:
	adiw r28,1
	call LCD_I2C_SendChar
	or r24,r25
	brne .L8
.L7:
	ld r24,Y
	cpse r24,__zero_reg__
	rjmp .L9
	ldi r24,0
	ldi r25,0
	rjmp .L4
	.size	LCD_I2C_SendString, .-LCD_I2C_SendString
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
	ldi r30,lo8(3999)
	ldi r31,hi8(3999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
/* epilogue start */
	ret
	.size	LCD_I2C_Clear, .-LCD_I2C_Clear
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
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	movw r28,r24
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r22,0
	ldi r24,lo8(48)
	call LCD_I2C_WriteNibble
	or r28,r24
	or r29,r25
	ldi r24,lo8(9999)
	ldi r25,hi8(9999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r22,0
	ldi r24,lo8(48)
	call LCD_I2C_WriteNibble
	or r28,r24
	or r29,r25
	ldi r24,lo8(299)
	ldi r25,hi8(299)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r22,0
	ldi r24,lo8(48)
	call LCD_I2C_WriteNibble
	or r28,r24
	or r29,r25
	ldi r22,0
	ldi r24,lo8(32)
	call LCD_I2C_WriteNibble
	or r28,r24
	or r29,r25
	ldi r24,lo8(40)
	call LCD_I2C_SendCommand
	or r28,r24
	or r29,r25
	ldi r24,lo8(12)
	call LCD_I2C_SendCommand
	or r28,r24
	or r29,r25
	call LCD_I2C_Clear
	or r28,r24
	or r29,r25
	ldi r24,lo8(6)
	call LCD_I2C_SendCommand
	or r24,r28
	or r25,r29
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	LCD_I2C_Init, .-LCD_I2C_Init
	.section	.text.LCD_I2C_SetCursor,"ax",@progbits
.global	LCD_I2C_SetCursor
	.type	LCD_I2C_SetCursor, @function
LCD_I2C_SetCursor:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	brsh .L12
	cpi r22,lo8(16)
	brsh .L12
	cpse r24,__zero_reg__
	rjmp .L14
	ldi r24,lo8(-128)
.L18:
	add r24,r22
	jmp LCD_I2C_SendCommand
.L14:
	ldi r24,lo8(-64)
	rjmp .L18
.L12:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	LCD_I2C_SetCursor, .-LCD_I2C_SetCursor
	.section	.text.LCD_I2C_SendNumber,"ax",@progbits
.global	LCD_I2C_SendNumber
	.type	LCD_I2C_SendNumber, @function
LCD_I2C_SendNumber:
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
/* stack size = 9 */
.L__stack_usage = 9
	movw r18,r24
	ldi r20,0
	ldi r30,lo8(10)
	ldi r31,0
	or r24,r25
	brne .L20
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
	jmp LCD_I2C_SendChar
.L20:
	movw r24,r18
	movw r22,r30
	call __udivmodhi4
	mov r17,r20
	subi r20,lo8(-(1))
	movw r26,r28
	adiw r26,1
	add r26,r17
	adc r27,__zero_reg__
	sbrc r17,7
	dec r27
	subi r24,lo8(-(48))
	st X,r24
	movw r24,r18
	movw r18,r22
	sbiw r24,10
	brsh .L20
.L21:
	sbrs r17,7
	rjmp .L23
	ldi r24,0
	ldi r25,0
.L19:
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
	ret
.L23:
	movw r30,r28
	adiw r30,1
	add r30,r17
	adc r31,__zero_reg__
	ld r24,Z
	call LCD_I2C_SendChar
	subi r17,lo8(-(-1))
	or r24,r25
	breq .L21
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L19
	.size	LCD_I2C_SendNumber, .-LCD_I2C_SendNumber
	.ident	"GCC: (GNU) 15.2.0"
