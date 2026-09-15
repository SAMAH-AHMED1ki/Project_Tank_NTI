	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.Task_Count,"ax",@progbits
	.type	Task_Count, @function
Task_Count:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,g_u8Count
	subi r24,lo8(-(1))
	sts g_u8Count,r24
/* epilogue start */
	ret
	.size	Task_Count, .-Task_Count
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
	call SCHEDULER_Init
	ldi r20,lo8(-56)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(gs(Task_Count))
	ldi r25,hi8(gs(Task_Count))
	call SCHEDULER_AddTask
	ldi r28,lo8(-112)
	ldi r29,lo8(1)
.L3:
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	call SCHEDULER_Tick
	call SCHEDULER_Run
	call SCHEDULER_Run
	call SCHEDULER_Run
	call SCHEDULER_Run
	sbiw r28,1
	brne .L3
	lds r24,g_u8Count
	call SHIFTREG_SendByte
.L4:
	rjmp .L4
	.size	main, .-main
	.section	.bss.g_u8Count,"aw",@nobits
	.type	g_u8Count, @object
	.size	g_u8Count, 1
g_u8Count:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
