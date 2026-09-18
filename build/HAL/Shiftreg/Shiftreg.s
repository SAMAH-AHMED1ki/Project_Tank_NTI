	.file	"Shiftreg.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SHIFTREG_Init,"ax",@progbits
.global	SHIFTREG_Init
	.type	SHIFTREG_Init, @function
SHIFTREG_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	sbiw r24,0
	brne .L1
	ldi r20,0
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	jmp GPIO_SetPinValue
.L1:
/* epilogue start */
	ret
	.size	SHIFTREG_Init, .-SHIFTREG_Init
	.section	.text.SHIFTREG_SendByte,"ax",@progbits
.global	SHIFTREG_SendByte
	.type	SHIFTREG_SendByte, @function
SHIFTREG_SendByte:
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+1,__zero_reg__
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	call SPI_Transceive
	movw r16,r24
	or r24,r25
	brne .L3
	ldi r20,lo8(1)
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(4)
	ldi r24,lo8(1)
	call GPIO_SetPinValue
.L3:
	movw r24,r16
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	SHIFTREG_SendByte, .-SHIFTREG_SendByte
	.ident	"GCC: (GNU) 15.2.0"
