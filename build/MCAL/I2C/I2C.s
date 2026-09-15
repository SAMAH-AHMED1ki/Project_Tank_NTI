	.file	"I2C.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.I2C_InitMaster,"ax",@progbits
.global	I2C_InitMaster
	.type	I2C_InitMaster, @function
I2C_InitMaster:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r18,r22
	movw r20,r24
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	cpc r20,__zero_reg__
	cpc r21,__zero_reg__
	breq .L3
	ldi r22,0
	ldi r23,lo8(18)
	ldi r24,lo8(122)
	ldi r25,0
	call __udivmodsi4
	subi r18,16
	sbc r19,__zero_reg__
	sbc r20,__zero_reg__
	sbc r21,__zero_reg__
	lsr r21
	ror r20
	ror r19
	ror r18
	out 0,r18
	in r24,0x1
	andi r24,lo8(-4)
	out 0x1,r24
	ldi r24,lo8(4)
	out 0x36,r24
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	I2C_InitMaster, .-I2C_InitMaster
	.section	.text.I2C_SendStart,"ax",@progbits
.global	I2C_SendStart
	.type	I2C_SendStart, @function
I2C_SendStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
.L5:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L5
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(8)
	brne .L6
	ldi r18,0
.L6:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendStart, .-I2C_SendStart
	.section	.text.I2C_SendRepeatedStart,"ax",@progbits
.global	I2C_SendRepeatedStart
	.type	I2C_SendRepeatedStart, @function
I2C_SendRepeatedStart:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-92)
	out 0x36,r24
.L9:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L9
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(16)
	brne .L10
	ldi r18,0
.L10:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendRepeatedStart, .-I2C_SendRepeatedStart
	.section	.text.I2C_SendStop,"ax",@progbits
.global	I2C_SendStop
	.type	I2C_SendStop, @function
I2C_SendStop:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-108)
	out 0x36,r24
/* epilogue start */
	ret
	.size	I2C_SendStop, .-I2C_SendStop
	.section	.text.I2C_SendSlaveAddressWithWrite,"ax",@progbits
.global	I2C_SendSlaveAddressWithWrite
	.type	I2C_SendSlaveAddressWithWrite, @function
I2C_SendSlaveAddressWithWrite:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lsl r24
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L14:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L14
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(24)
	brne .L15
	ldi r18,0
.L15:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendSlaveAddressWithWrite, .-I2C_SendSlaveAddressWithWrite
	.section	.text.I2C_SendSlaveAddressWithRead,"ax",@progbits
.global	I2C_SendSlaveAddressWithRead
	.type	I2C_SendSlaveAddressWithRead, @function
I2C_SendSlaveAddressWithRead:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lsl r24
	ori r24,lo8(1)
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L18:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L18
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(64)
	brne .L19
	ldi r18,0
.L19:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendSlaveAddressWithRead, .-I2C_SendSlaveAddressWithRead
	.section	.text.I2C_SendByte,"ax",@progbits
.global	I2C_SendByte
	.type	I2C_SendByte, @function
I2C_SendByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x3,r24
	ldi r24,lo8(-124)
	out 0x36,r24
.L22:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L22
	in r25,0x1
	andi r25,lo8(-8)
	ldi r18,lo8(1)
	ldi r19,0
	cpi r25,lo8(40)
	brne .L23
	ldi r18,0
.L23:
	movw r24,r18
/* epilogue start */
	ret
	.size	I2C_SendByte, .-I2C_SendByte
	.section	.text.I2C_ReceiveByte,"ax",@progbits
.global	I2C_ReceiveByte
	.type	I2C_ReceiveByte, @function
I2C_ReceiveByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	or r24,r25
	brne .L26
.L30:
	ldi r24,lo8(1)
	ldi r25,0
	ret
.L26:
	cpi r22,lo8(1)
	brne .L28
	ldi r24,lo8(-60)
	out 0x36,r24
.L29:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L29
	in r25,0x1
	andi r25,lo8(-8)
	cpi r25,lo8(80)
.L35:
	brne .L30
	in r24,0x3
	st Z,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L28:
	brsh .L30
	ldi r24,lo8(-124)
	out 0x36,r24
.L31:
	in __tmp_reg__,0x36
	sbrs __tmp_reg__,7
	rjmp .L31
	in r25,0x1
	andi r25,lo8(-8)
	cpi r25,lo8(88)
	rjmp .L35
	.size	I2C_ReceiveByte, .-I2C_ReceiveByte
	.ident	"GCC: (GNU) 15.2.0"
