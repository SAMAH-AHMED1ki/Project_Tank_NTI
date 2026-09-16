	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
<<<<<<< HEAD
	.section	.text.UART_SendChar,"ax",@progbits
	.type	UART_SendChar, @function
UART_SendChar:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L2:
	sbis 0xb,5
	rjmp .L2
	out 0xc,r24
/* epilogue start */
	ret
	.size	UART_SendChar, .-UART_SendChar
	.section	.text.UART_SendString,"ax",@progbits
	.type	UART_SendString, @function
UART_SendString:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
.L6:
	ld r24,Y
	cpse r24,__zero_reg__
	rjmp .L7
/* epilogue start */
	pop r29
	pop r28
	ret
.L7:
	adiw r28,1
	call UART_SendChar
	rjmp .L6
	.size	UART_SendString, .-UART_SendString
	.section	.rodata.UART_SendNewLine.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\r\n"
	.section	.text.UART_SendNewLine,"ax",@progbits
	.type	UART_SendNewLine, @function
UART_SendNewLine:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	jmp UART_SendString
	.size	UART_SendNewLine, .-UART_SendNewLine
	.section	.rodata.TestTask.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Scheduler Task Running"
	.section	.text.TestTask,"ax",@progbits
	.type	TestTask, @function
TestTask:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call UART_SendString
	jmp UART_SendNewLine
	.size	TestTask, .-TestTask
	.section	.text.UART_SendNumber,"ax",@progbits
	.type	UART_SendNumber, @function
UART_SendNumber:
	push r12
	push r13
	push r14
	push r15
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,11
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 11 */
/* stack size = 18 */
.L__stack_usage = 18
	movw r12,r22
	movw r14,r24
	ldi r17,0
	cp r12,__zero_reg__
	cpc r13,__zero_reg__
	cpc r14,__zero_reg__
	cpc r15,__zero_reg__
	brne .L11
	ldi r24,lo8(48)
/* epilogue start */
	adiw r28,11
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	pop r13
	pop r12
	jmp UART_SendChar
.L11:
	movw r22,r12
	movw r24,r14
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	movw r30,r28
	adiw r30,1
	add r30,r17
	adc r31,__zero_reg__
	subi r22,lo8(-(48))
	st Z,r22
	movw r24,r12
	movw r26,r14
	movw r12,r18
	movw r14,r20
	subi r17,lo8(-(1))
	sbiw r24,10
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brsh .L11
.L12:
	cpse r17,__zero_reg__
	rjmp .L13
/* epilogue start */
	adiw r28,11
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	pop r13
	pop r12
	ret
.L13:
	subi r17,lo8(-(-1))
	movw r30,r28
	adiw r30,1
	add r30,r17
	adc r31,__zero_reg__
	ld r24,Z
	call UART_SendChar
	rjmp .L12
	.size	UART_SendNumber, .-UART_SendNumber
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC2:
	.string	"================================"
.LC3:
	.string	"ATmega32 DRIVER TEST PROGRAM"
.LC4:
	.string	"SPI + 74HC595 TEST START"
.LC5:
	.string	"SPI + 74HC595 TEST FINISHED"
.LC6:
	.string	"TIMER0 DELAY TEST START"
.LC7:
	.string	"TIMER0 DELAY TEST FINISHED"
.LC8:
	.string	"TIMER0 PWM TEST START"
.LC9:
	.string	"Timer0 PWM = 50 percent on PB3"
.LC10:
	.string	"TIMER0 PWM TEST FINISHED"
.LC11:
	.string	"TIMER1 PWM TEST START"
.LC12:
	.string	"Timer1 PWM = 50 Hz, 50 percent on PD5"
.LC13:
	.string	"TIMER1 PWM TEST FINISHED"
.LC14:
	.string	"FLOWMETER TEST START"
.LC15:
	.string	"Generate pulses on PB1 / T1"
.LC16:
	.string	"Pulses per second = "
.LC17:
	.string	"Flow L/min x10 = "
.LC18:
	.string	"Total milliliters = "
.LC19:
	.string	"FLOWMETER TEST FINISHED"
.LC20:
	.string	"SCHEDULER TEST START"
.LC21:
	.string	"SCHEDULER TEST FINISHED"
.LC22:
	.string	"ALL TESTS FINISHED"
=======
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Hello"
.LC1:
	.string	"LCD Test"
.LC2:
	.string	"Working!"
>>>>>>> eaa1cf8 (Update LCD I2C integration)
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
<<<<<<< HEAD
	out 0x20,__zero_reg__
	ldi r24,lo8(51)
	out 0x9,r24
	ldi r24,lo8(24)
	out 0xa,r24
	ldi r24,lo8(-122)
	out 0x20,r24
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(1)
	call SPI_InitMaster
	call SHIFTREG_Init
	ldi r24,lo8(1)
	call SHIFTREG_SendByte
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	call TIMER0_DelayMS
	ldi r24,lo8(3)
	call SHIFTREG_SendByte
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	call TIMER0_DelayMS
	ldi r24,lo8(7)
	call SHIFTREG_SendByte
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	call TIMER0_DelayMS
	ldi r24,lo8(15)
	call SHIFTREG_SendByte
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	call TIMER0_DelayMS
	ldi r24,lo8(-1)
	call SHIFTREG_SendByte
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	call TIMER0_DelayMS
	ldi r24,0
	call SHIFTREG_SendByte
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	call TIMER0_DelayMS
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	call UART_SendString
	call UART_SendNewLine
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	call TIMER0_Init
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call TIMER0_DelayMS
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(50)
	call TIMER0_PWM
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(-72)
	ldi r25,lo8(11)
	call TIMER0_DelayMS
	call TIMER0_Stop
	sbi 0x17,3
	cbi 0x18,3
	ldi r24,lo8(.LC10)
	ldi r25,hi8(.LC10)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC11)
	ldi r25,hi8(.LC11)
	call UART_SendString
	call UART_SendNewLine
	ldi r22,lo8(50)
	ldi r24,lo8(50)
	ldi r25,0
	call TIMER1_PWM
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(-72)
	ldi r25,lo8(11)
	call TIMER0_DelayMS
	call TIMER1_Stop
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC14)
	ldi r25,hi8(.LC14)
	call UART_SendString
	call UART_SendNewLine
	call FLOWMETER_Init
	ldi r24,lo8(.LC15)
	ldi r25,hi8(.LC15)
	call UART_SendString
	call UART_SendNewLine
	ldi r28,lo8(10)
.L17:
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call TIMER0_DelayMS
	call FLOWMETER_Update1Hz
	ldi r24,lo8(.LC16)
	ldi r25,hi8(.LC16)
	call UART_SendString
	call FLOWMETER_GetPulsesPerSec
	movw r22,r24
	ldi r24,0
	ldi r25,0
	call UART_SendNumber
	call UART_SendNewLine
	ldi r24,lo8(.LC17)
	ldi r25,hi8(.LC17)
	call UART_SendString
	call FLOWMETER_GetFlowLpmX10
	movw r22,r24
	ldi r24,0
	ldi r25,0
	call UART_SendNumber
	call UART_SendNewLine
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call UART_SendString
	call FLOWMETER_GetTotalMilliliters
	call UART_SendNumber
	call UART_SendNewLine
	call UART_SendNewLine
	subi r28,lo8(1)
	brne .L17
	ldi r24,lo8(.LC19)
	ldi r25,hi8(.LC19)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC20)
	ldi r25,hi8(.LC20)
	call UART_SendString
	call UART_SendNewLine
	call SCHEDULER_Init
	ldi r20,lo8(100)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(gs(TestTask))
	ldi r25,hi8(gs(TestTask))
	call SCHEDULER_AddTask
	ldi r28,lo8(100)
.L18:
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	call SCHEDULER_Tick
	call SCHEDULER_Run
	subi r28,lo8(1)
	brne .L18
	ldi r24,lo8(.LC21)
	ldi r25,hi8(.LC21)
	call UART_SendString
	call UART_SendNewLine
	ldi r24,lo8(.LC22)
	ldi r25,hi8(.LC22)
	call UART_SendString
	call UART_SendNewLine
.L19:
	rjmp .L19
=======
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	call LCD_I2C_Init
	call LCD_I2C_Clear
	ldi r22,0
	ldi r24,0
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call LCD_I2C_SendString
	ldi r18,lo8(3199999)
	ldi r24,hi8(3199999)
	ldi r25,hlo8(3199999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	call LCD_I2C_Clear
	ldi r22,0
	ldi r24,0
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call LCD_I2C_SendString
	ldi r22,0
	ldi r24,lo8(1)
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call LCD_I2C_SendString
.L2:
	rjmp .L2
>>>>>>> eaa1cf8 (Update LCD I2C integration)
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
