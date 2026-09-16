	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.rodata.APP_Task500ms.str1.1,"aMS",@progbits,1
.LC0:
	.string	"L:"
.LC1:
	.string	"% R:"
.LC2:
	.string	"% "
.LC3:
	.string	"F:"
.LC4:
	.string	"."
.LC5:
	.string	"L/m "
.LC6:
	.string	"RUN"
.LC7:
	.string	"OFF"
	.section	.text.APP_Task500ms,"ax",@progbits
	.type	APP_Task500ms, @function
APP_Task500ms:
	push r28
	push r29
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 6 */
.L__stack_usage = 6
	lds r24,Global_stTankData+10
	lds r25,Global_stTankData+11
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	std Y+1,r22
	std Y+2,r23
	std Y+3,r24
	std Y+4,r25
	ldi r22,0
	ldi r24,0
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call LCD_I2C_SendString
	lds r24,Global_stTankData+6
	ldi r25,0
	call LCD_I2C_SendNumber
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call LCD_I2C_SendString
	lds r24,Global_stTankData+7
	ldi r25,0
	call LCD_I2C_SendNumber
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call LCD_I2C_SendString
	ldi r22,0
	ldi r24,lo8(1)
	call LCD_I2C_SetCursor
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call LCD_I2C_SendString
	ldd r24,Y+1
	ldd r25,Y+2
	call LCD_I2C_SendNumber
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call LCD_I2C_SendString
	ldd r24,Y+3
	ldd r25,Y+4
	call LCD_I2C_SendNumber
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call LCD_I2C_SendString
	lds r24,Global_stTankData+17
	sbrs r24,0
	rjmp .L2
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
.L3:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	jmp LCD_I2C_SendString
.L2:
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	rjmp .L3
	.size	APP_Task500ms, .-APP_Task500ms
	.section	.text.APP_HighFloatISR,"ax",@progbits
	.type	APP_HighFloatISR, @function
APP_HighFloatISR:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,0
	call PMP_Set
	ldi r24,0
	jmp Valve_Set
	.size	APP_HighFloatISR, .-APP_HighFloatISR
	.section	.text.APP_UpdateData,"ax",@progbits
	.type	APP_UpdateData, @function
APP_UpdateData:
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 9 */
/* stack size = 13 */
.L__stack_usage = 13
	movw r16,r28
	subi r16,-5
	sbci r17,-1
	movw r22,r16
	ldi r24,0
	call ADC_ReadChannel
	movw r22,r16
	or r24,r25
	brne .L6
	ldd r24,Y+5
	ldd r25,Y+6
	sts Global_stTankData,r24
	sts Global_stTankData+1,r25
.L6:
	ldi r24,lo8(1)
	call ADC_ReadChannel
	or r24,r25
	brne .L7
	ldd r24,Y+5
	ldd r25,Y+6
	sts Global_stTankData+2,r24
	sts Global_stTankData+3,r25
.L7:
	movw r16,r28
	subi r16,-9
	sbci r17,-1
	movw r22,r16
	ldi r24,0
	call LEVEL_ReadPercentage
	movw r22,r16
	or r24,r25
	brne .L8
	ldd r24,Y+9
	sts Global_stTankData+6,r24
.L8:
	ldi r24,lo8(1)
	call LEVEL_ReadPercentage
	or r24,r25
	brne .L9
	ldd r24,Y+9
	sts Global_stTankData+7,r24
.L9:
	ldi r24,lo8(Global_stTankData+8)
	ldi r25,hi8(Global_stTankData+8)
	call CUR_GetmA
	or r24,r25
	breq .L10
	sts Global_stTankData+8,__zero_reg__
	sts Global_stTankData+9,__zero_reg__
.L10:
	call FLOWMETER_GetFlowLpmX10
	sts Global_stTankData+10,r24
	sts Global_stTankData+11,r25
	call FLOWMETER_GetTotalMilliliters
	ldi r18,lo8(-24)
	ldi r19,lo8(3)
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	sts Global_stTankData+12,r18
	sts Global_stTankData+13,r19
	sts Global_stTankData+14,r20
	sts Global_stTankData+15,r21
	call FLT_IsHighActive
	lds r25,Global_stTankData+17
	bst r24,0
	bld r25,2
	sts Global_stTankData+17,r25
	call FLT_IsLowActive
	lds r25,Global_stTankData+17
	bst r24,0
	bld r25,3
	sts Global_stTankData+17,r25
	movw r24,r28
	adiw r24,8
	call PMP_GetState
	or r24,r25
	breq .+2
	rjmp .L16
	ldd r24,Y+8
	andi r24,lo8(1)
.L11:
	lds r25,Global_stTankData+17
	bst r24,0
	bld r25,0
	sts Global_stTankData+17,r25
	movw r24,r28
	adiw r24,7
	call Valve_GetState
	or r24,r25
	breq .+2
	rjmp .L17
	ldd r24,Y+7
	andi r24,lo8(1)
.L12:
	lds r25,Global_stTankData+17
	bst r24,0
	bld r25,1
	sts Global_stTankData+17,r25
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	movw r24,r16
	call PMP_RunSeconds
	or r24,r25
	brne .L18
	ldd r24,Y+1
	ldd r25,Y+2
.L13:
	sts Global_stTankData+20,r24
	sts Global_stTankData+21,r25
	ldi r24,lo8(Global_stTankData+22)
	ldi r25,hi8(Global_stTankData+22)
	call PMP_TotalSeconds
	or r24,r25
	breq .L14
	sts Global_stTankData+22,__zero_reg__
	sts Global_stTankData+23,__zero_reg__
	sts Global_stTankData+24,__zero_reg__
	sts Global_stTankData+25,__zero_reg__
.L14:
	movw r24,r16
	call PMP_Cycles
	or r24,r25
	brne .L19
	ldd r24,Y+1
	ldd r25,Y+2
.L15:
	sts Global_stTankData+26,r24
	sts Global_stTankData+27,r25
	call FSM_GetState
	sts Global_stTankData+18,r24
/* epilogue start */
	adiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L16:
	ldi r24,0
	rjmp .L11
.L17:
	ldi r24,0
	rjmp .L12
.L18:
	ldi r24,0
	ldi r25,0
	rjmp .L13
.L19:
	ldi r24,0
	ldi r25,0
	rjmp .L15
	.size	APP_UpdateData, .-APP_UpdateData
	.section	.text.APP_Task1s,"ax",@progbits
	.type	APP_Task1s, @function
APP_Task1s:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call PMP_Update1s
	call FLOWMETER_Update1Hz
	lds r24,Global_stTankData+28
	lds r25,Global_stTankData+29
	lds r26,Global_stTankData+30
	lds r27,Global_stTankData+31
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts Global_stTankData+28,r24
	sts Global_stTankData+29,r25
	sts Global_stTankData+30,r26
	sts Global_stTankData+31,r27
	jmp APP_UpdateData
	.size	APP_Task1s, .-APP_Task1s
	.section	.text.APP_Task10ms,"ax",@progbits
	.type	APP_Task10ms, @function
APP_Task10ms:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(3)
	call BTN_Update10ms
	call FLT_Update
	call CUR_Update
	call APP_UpdateData
	ldi r24,lo8(Global_stTankData)
	ldi r25,hi8(Global_stTankData)
	call DEM_Update
	ldi r24,lo8(Global_stTankData)
	ldi r25,hi8(Global_stTankData)
	call FSM_Run
	call FSM_GetState
	sts Global_stTankData+18,r24
/* epilogue start */
	ret
	.size	APP_Task10ms, .-APP_Task10ms
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_stTankData,__zero_reg__
	sts Global_stTankData+1,__zero_reg__
	sts Global_stTankData+2,__zero_reg__
	sts Global_stTankData+3,__zero_reg__
	sts Global_stTankData+6,__zero_reg__
	sts Global_stTankData+7,__zero_reg__
	sts Global_stTankData+8,__zero_reg__
	sts Global_stTankData+9,__zero_reg__
	sts Global_stTankData+10,__zero_reg__
	sts Global_stTankData+11,__zero_reg__
	sts Global_stTankData+12,__zero_reg__
	sts Global_stTankData+13,__zero_reg__
	sts Global_stTankData+14,__zero_reg__
	sts Global_stTankData+15,__zero_reg__
	sts Global_stTankData+20,__zero_reg__
	sts Global_stTankData+21,__zero_reg__
	sts Global_stTankData+22,__zero_reg__
	sts Global_stTankData+23,__zero_reg__
	sts Global_stTankData+24,__zero_reg__
	sts Global_stTankData+25,__zero_reg__
	sts Global_stTankData+26,__zero_reg__
	sts Global_stTankData+27,__zero_reg__
	sts Global_stTankData+28,__zero_reg__
	sts Global_stTankData+29,__zero_reg__
	sts Global_stTankData+30,__zero_reg__
	sts Global_stTankData+31,__zero_reg__
	lds r24,Global_stTankData+17
	andi r24,lo8(-16)
	sts Global_stTankData+17,r24
	sts Global_stTankData+18,__zero_reg__
	call TIMER0_Init
	ldi r24,0
	call LEVEL_Init
	ldi r24,lo8(1)
	call SPI_InitMaster
	call SHIFTREG_Init
	call PMP_Init
	call Valve_Init
	call FLT_Init
	call CUR_Init
	ldi r24,lo8(3)
	call BTN_Init
	call FLOWMETER_Init
	ldi r22,lo8(-96)
	ldi r23,lo8(-122)
	ldi r24,lo8(1)
	ldi r25,0
	call I2C_InitMaster
	call LCD_I2C_Init
	call DEM_Init
	call INT_Init
	call FSM_Init
	ldi r24,lo8(Global_stFaultLog)
	ldi r25,hi8(Global_stFaultLog)
	call FLG_Init
	call CON_Init
	ldi r22,lo8(gs(APP_HighFloatISR))
	ldi r23,hi8(gs(APP_HighFloatISR))
	ldi r24,0
	call EXTI_SetCallback
	ldi r22,lo8(2)
	ldi r24,0
	call EXTI_SetSense
	ldi r24,0
	call EXTI_ClearFlag
	ldi r24,0
	call EXTI_Enable
	call INTERRUPT_EnableGlobal
	call SCHEDULER_Init
	ldi r20,lo8(10)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(gs(APP_Task10ms))
	ldi r25,hi8(gs(APP_Task10ms))
	call SCHEDULER_AddTask
	ldi r20,lo8(-12)
	ldi r21,lo8(1)
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(gs(APP_Task500ms))
	ldi r25,hi8(gs(APP_Task500ms))
	call SCHEDULER_AddTask
	ldi r20,lo8(-24)
	ldi r21,lo8(3)
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(gs(APP_Task1s))
	ldi r25,hi8(gs(APP_Task1s))
	call SCHEDULER_AddTask
	call APP_UpdateData
	call FSM_GetState
	sts Global_stTankData+18,r24
.L35:
	ldi r24,lo8(10)
	ldi r25,0
	call TIMER0_DelayMS
	call SCHEDULER_Tick
	call SCHEDULER_Run
	call CON_Run
	call FSM_GetState
	movw r18,r24
	lds r25,Global_stTankData+17
	mov r24,r25
	andi r24,1<<0
	sbrc r25,1
	ori r24,lo8(2)
.L29:
	sbrc r25,2
	ori r24,lo8(4)
.L30:
	sbrc r25,3
	ori r24,lo8(8)
.L31:
	cpi r18,5
	cpc r19,__zero_reg__
	brne .L32
	ori r24,lo8(16)
.L33:
	call SHIFTREG_SendByte
	rjmp .L35
.L32:
	cpi r18,6
	cpc r19,__zero_reg__
	brne .L34
	ori r24,lo8(32)
	rjmp .L33
.L34:
	cpi r18,7
	cpc r19,__zero_reg__
	brne .L33
	ori r24,lo8(64)
	rjmp .L33
	.size	main, .-main
	.section	.bss.Global_stFaultLog,"aw",@nobits
	.type	Global_stFaultLog, @object
	.size	Global_stFaultLog, 147
Global_stFaultLog:
	.zero	147
	.section	.bss.Global_stTankData,"aw",@nobits
	.type	Global_stTankData, @object
	.size	Global_stTankData, 32
Global_stTankData:
	.zero	32
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
