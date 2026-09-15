	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call TIMER0_Init
	ldi r24,lo8(1)
	call SPI_InitMaster
	call SHIFTREG_Init
	call TIMER1_ExternalCounterInit
.L2:
	call TIMER1_ResetCounter
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayS
	call TIMER1_GetCounter
	call SHIFTREG_SendByte
	rjmp .L2
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
