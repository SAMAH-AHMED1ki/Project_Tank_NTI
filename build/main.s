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
	ldi r24,lo8(1)
	call SPI_InitMaster
	call SHIFTREG_Init
	call TIMER0_Init
	call FLOWMETER_Init
	ldi r24,lo8(-1)
	call SHIFTREG_SendByte
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayS
	ldi r24,0
	call SHIFTREG_SendByte
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayS
.L8:
	ldi r29,0
.L10:
	ldi r28,0
.L2:
	ldi r24,lo8(1)
	ldi r25,0
	call TIMER0_DelayS
	call FLOWMETER_Update1Hz
	cpi r29,lo8(1)
	brlo .L3
	breq .L4
	call FLOWMETER_GetTotalMilliliters
	mov r24,r22
	rjmp .L11
.L3:
	call FLOWMETER_GetPulsesPerSec
.L11:
	call SHIFTREG_SendByte
	subi r28,lo8(-(1))
	ldi r24,lo8(1)
	add r24,r29
	cpi r28,lo8(3)
	brne .L2
	cpi r24,lo8(3)
	brsh .L8
	mov r29,r24
	rjmp .L10
.L4:
	call FLOWMETER_GetFlowLpmX10
	rjmp .L11
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
