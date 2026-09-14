	.file	"SPI.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SPI_InitMaster,"ax",@progbits
.global	SPI_InitMaster
	.type	SPI_InitMaster, @function
SPI_InitMaster:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(4)
	brsh .L3
	sbi 0x17,4
	sbi 0x17,5
	cbi 0x17,6
	sbi 0x17,7
	sbi 0x18,4
	ori r24,lo8(80)
	out 0xd,r24
	cbi 0xe,0
	ldi r24,0
	ldi r25,0
	ret
.L3:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	SPI_InitMaster, .-SPI_InitMaster
	.section	.text.SPI_InitSlave,"ax",@progbits
.global	SPI_InitSlave
	.type	SPI_InitSlave, @function
SPI_InitSlave:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 0x17,4
	cbi 0x17,5
	sbi 0x17,6
	cbi 0x17,7
	ldi r24,lo8(64)
	out 0xd,r24
	cbi 0xe,0
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	SPI_InitSlave, .-SPI_InitSlave
	.section	.text.SPI_Transceive,"ax",@progbits
.global	SPI_Transceive
	.type	SPI_Transceive, @function
SPI_Transceive:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cp r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L8
	out 0xf,r24
.L7:
	sbis 0xe,7
	rjmp .L7
	in r24,0xf
	movw r30,r22
	st Z,r24
	ldi r24,0
	ldi r25,0
	ret
.L8:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	SPI_Transceive, .-SPI_Transceive
	.section	.text.SPI_SelectSlave,"ax",@progbits
.global	SPI_SelectSlave
	.type	SPI_SelectSlave, @function
SPI_SelectSlave:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	std Y+1,r24
	std Y+2,r22
	ldi r20,lo8(1)
	call GPIO_SetPinDirection
	or r24,r25
	brne .L13
	ldi r20,0
	ldd r22,Y+2
	ldd r24,Y+1
	call GPIO_SetPinValue
	movw r18,r24
	ldi r24,lo8(1)
	or r18,r19
	brne .L14
	ldi r24,0
.L14:
	ldi r25,0
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L13:
	ldi r24,lo8(1)
	rjmp .L14
	.size	SPI_SelectSlave, .-SPI_SelectSlave
	.section	.text.SPI_ReleaseSlave,"ax",@progbits
.global	SPI_ReleaseSlave
	.type	SPI_ReleaseSlave, @function
SPI_ReleaseSlave:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	call GPIO_SetPinValue
	movw r18,r24
	ldi r24,lo8(1)
	ldi r25,0
	or r18,r19
	brne .L16
	ldi r24,0
.L16:
/* epilogue start */
	ret
	.size	SPI_ReleaseSlave, .-SPI_ReleaseSlave
	.ident	"GCC: (GNU) 15.2.0"
