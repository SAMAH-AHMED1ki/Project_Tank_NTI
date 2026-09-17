	.file	"console.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.CON_CompareNoCase,"ax",@progbits
	.type	CON_CompareNoCase, @function
CON_CompareNoCase:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r20,r24
	ldi r18,0
	or r24,r25
	brne .L3
.L8:
	ldi r24,0
	ret
.L5:
	ldi r24,lo8(-97)
	add r24,r25
	cpi r24,lo8(26)
	brsh .L4
	subi r25,lo8(-(-32))
.L4:
	cpse r19,r25
	rjmp .L8
	subi r18,lo8(-(1))
.L3:
	movw r30,r22
	add r30,r18
	adc r31,__zero_reg__
	ld r19,Z
	movw r30,r20
	add r30,r18
	adc r31,__zero_reg__
	ld r25,Z
	cpse r19,__zero_reg__
	rjmp .L5
	mov r24,r25
	andi r24,lo8(-33)
	breq .L10
	ldi r24,lo8(-9)
	add r24,r25
	cpi r24,lo8(2)
	brlo .L10
	ldi r24,lo8(1)
	cpi r25,lo8(13)
	brne .L8
.L1:
/* epilogue start */
	ret
.L10:
	ldi r24,lo8(1)
	ret
	.size	CON_CompareNoCase, .-CON_CompareNoCase
	.section	.text.CON_WriteByte,"ax",@progbits
	.type	CON_WriteByte, @function
CON_WriteByte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp UART_SendByte
	.size	CON_WriteByte, .-CON_WriteByte
	.section	.text.CON_Init,"ax",@progbits
.global	CON_Init
	.type	CON_Init, @function
CON_Init:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Init
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Init
	sts g_conLineLen,__zero_reg__
	ldi r22,lo8(-128)
	ldi r23,lo8(37)
	ldi r24,0
	ldi r25,0
	call UART_Init
	movw r28,r24
	or r24,r25
	brne .L17
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call UART_SetRxBuffer
	ldi r24,lo8(1)
	call UART_SetRxInterrupt
.L15:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L17:
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L15
	.size	CON_Init, .-CON_Init
	.section	.rodata.CON_SendStatus.str1.1,"aMS",@progbits,1
.LC0:
	.string	"UNKNOWN"
.LC1:
	.string	"LEVEL=%u%% R=%u%% I=%umA\r\n"
.LC2:
	.string	"FLOW=%u.%uL/min VOL=%luL\r\n"
.LC3:
	.string	"PUMP=%u VALVE=%u HIGH=%u LOW=%u\r\n"
.LC4:
	.string	"STATE=%s TRIP=%u RUN=%u UP=%lu\r\n"
	.section	.text.CON_SendStatus,"ax",@progbits
.global	CON_SendStatus
	.type	CON_SendStatus, @function
CON_SendStatus:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	subi r28,96
	sbc r29,__zero_reg__
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 96 */
/* stack size = 102 */
.L__stack_usage = 102
	call FSM_GetState
	cpi r24,8
	cpc r25,__zero_reg__
	brlo .+2
	rjmp .L20
	lsl r24
	rol r25
	movw r30,r24
	subi r30,lo8(-(CSWTCH.41))
	sbci r31,hi8(-(CSWTCH.41))
	ld r14,Z
	ldd r15,Z+1
.L19:
	lds r24,Global_stTankData+9
	push r24
	lds r24,Global_stTankData+8
	push r24
	lds r24,Global_stTankData+7
	push __zero_reg__
	push r24
	lds r24,Global_stTankData+6
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r24,r16
	call UART_SendString
	lds r18,Global_stTankData+12
	lds r19,Global_stTankData+13
	lds r20,Global_stTankData+14
	lds r30,Global_stTankData+15
	lds r24,Global_stTankData+10
	lds r25,Global_stTankData+11
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	push r30
	push r20
	push r19
	push r18
	push r25
	push r24
	push r23
	push r22
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	push r25
	push r24
	push r17
	push r16
	call sprintf
	movw r24,r16
	call UART_SendString
	lds r24,Global_stTankData+17
	bst r24,3
	clr r24
	bld r24,0
	push __zero_reg__
	push r24
	lds r24,Global_stTankData+17
	bst r24,2
	clr r24
	bld r24,0
	push __zero_reg__
	push r24
	lds r24,Global_stTankData+17
	lsr r24
	andi r24,1
	push __zero_reg__
	push r24
	lds r24,Global_stTankData+17
	andi r24,1
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	push r25
	push r24
	push r17
	push r16
	call sprintf
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	movw r24,r16
	call UART_SendString
	lds r24,Global_stTankData+31
	push r24
	lds r24,Global_stTankData+30
	push r24
	lds r24,Global_stTankData+29
	push r24
	lds r24,Global_stTankData+28
	push r24
	lds r24,Global_stTankData+21
	push r24
	lds r24,Global_stTankData+20
	push r24
	lds r24,Global_stTankData+19
	push __zero_reg__
	push r24
	push r15
	push r14
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	push r25
	push r24
	push r17
	push r16
	call sprintf
	movw r24,r16
	call UART_SendString
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* epilogue start */
	subi r28,-96
	sbci r29,-1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L20:
	ldi r24,lo8(.LC0)
	mov r14,r24
	ldi r24,hi8(.LC0)
	mov r15,r24
	rjmp .L19
	.size	CON_SendStatus, .-CON_SendStatus
	.section	.rodata.CON_SendHelp.str1.1,"aMS",@progbits,1
.LC5:
	.string	"=== WATER TANK CONSOLE ===\r\n"
.LC6:
	.string	"STATUS      - System status\r\n"
.LC7:
	.string	"LEVEL?      - Roof tank level\r\n"
.LC8:
	.string	"FLOW?       - Current flow\r\n"
.LC9:
	.string	"VOLUME?     - Total volume\r\n"
.LC10:
	.string	"CURRENT?    - Pump current\r\n"
.LC11:
	.string	"CFG?        - Configuration\r\n"
.LC12:
	.string	"TRIP?       - Active trip\r\n"
.LC13:
	.string	"FAULTS?     - Fault history\r\n"
.LC14:
	.string	"CLRFAULTS   - Clear fault history\r\n"
.LC15:
	.string	"ACK         - Acknowledge trip\r\n"
.LC16:
	.string	"MODE AUTO/MANUAL - Mode command\r\n"
.LC17:
	.string	"===========================\r\n"
	.section	.text.CON_SendHelp,"ax",@progbits
.global	CON_SendHelp
	.type	CON_SendHelp, @function
CON_SendHelp:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call UART_SendString
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	call UART_SendString
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call UART_SendString
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	call UART_SendString
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call UART_SendString
	ldi r24,lo8(.LC10)
	ldi r25,hi8(.LC10)
	call UART_SendString
	ldi r24,lo8(.LC11)
	ldi r25,hi8(.LC11)
	call UART_SendString
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
	call UART_SendString
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	call UART_SendString
	ldi r24,lo8(.LC14)
	ldi r25,hi8(.LC14)
	call UART_SendString
	ldi r24,lo8(.LC15)
	ldi r25,hi8(.LC15)
	call UART_SendString
	ldi r24,lo8(.LC16)
	ldi r25,hi8(.LC16)
	call UART_SendString
	ldi r24,lo8(.LC17)
	ldi r25,hi8(.LC17)
	jmp UART_SendString
	.size	CON_SendHelp, .-CON_SendHelp
	.section	.rodata.CON_SendFaults.str1.1,"aMS",@progbits,1
.LC18:
	.string	"NO FAULTS\r\n"
	.section	.text.CON_SendFaults,"ax",@progbits
.global	CON_SendFaults
	.type	CON_SendFaults, @function
CON_SendFaults:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_GetCount
	cpse r24,__zero_reg__
	rjmp .L23
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call UART_SendString
.L24:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L23:
	ldi r22,lo8(gs(CON_WriteByte))
	ldi r23,hi8(gs(CON_WriteByte))
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Dump
	rjmp .L24
	.size	CON_SendFaults, .-CON_SendFaults
	.section	.rodata.CON_ProcessCommand.str1.1,"aMS",@progbits,1
.LC19:
	.string	"ERR CMD\r\n"
.LC20:
	.string	"HELP"
.LC21:
	.string	"STATUS"
.LC22:
	.string	"STATUS?"
.LC23:
	.string	"LEVEL?"
.LC24:
	.string	"LEVEL=%u%%\r\n"
.LC25:
	.string	"FLOW?"
.LC26:
	.string	"FLOW=%u.%u L/min\r\n"
.LC27:
	.string	"VOLUME?"
.LC28:
	.string	"VOLUME=%lu L\r\n"
.LC29:
	.string	"CURRENT?"
.LC30:
	.string	"CURRENT=%u mA\r\n"
.LC31:
	.string	"CFG?"
.LC32:
	.string	"CFG=30,90,60,8,0.5,1,10,15,120\r\n"
.LC33:
	.string	"ACK"
.LC34:
	.string	"OK\r\n"
.LC35:
	.string	"ERR ACTIVE\r\n"
.LC36:
	.string	"FAULTS?"
.LC37:
	.string	"CLRFAULTS"
.LC38:
	.string	"TRIP?"
.LC39:
	.string	"TRIP=%u\r\n"
.LC40:
	.string	"MODE AUTO"
.LC41:
	.string	"ERR MODE - USE MODE BUTTON\r\n"
.LC42:
	.string	"MODE MANUAL"
.LC43:
	.string	"PUMP ON"
.LC44:
	.string	"ERR MODE - USE FSM CONTROL\r\n"
.LC45:
	.string	"PUMP OFF"
.LC46:
	.string	"VALVE ON"
.LC47:
	.string	"VALVE OFF"
.LC48:
	.string	"SERVICE ON"
.LC49:
	.string	"ERR MODE - USE SERVICE CONTROL\r\n"
.LC50:
	.string	"SERVICE OFF"
	.section	.text.CON_ProcessCommand,"ax",@progbits
.global	CON_ProcessCommand
	.type	CON_ProcessCommand, @function
CON_ProcessCommand:
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,32
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 32 */
/* stack size = 36 */
.L__stack_usage = 36
	movw r30,r24
	or r24,r25
	brne .L53
.L26:
	ldi r24,lo8(.LC19)
	ldi r25,hi8(.LC19)
	call UART_SendString
	ldi r24,lo8(1)
	ldi r25,0
.L25:
/* epilogue start */
	adiw r28,32
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
.L53:
	movw r16,r30
	ld r24,Z+
	cpi r24,lo8(32)
	breq .L53
	ldi r25,lo8(-9)
	add r25,r24
	cpi r25,lo8(2)
	brlo .L53
	cpi r24,lo8(13)
	breq .L53
	ldi r22,lo8(.LC20)
	ldi r23,hi8(.LC20)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L29
	call CON_SendHelp
.L30:
	ldi r24,0
	ldi r25,0
	rjmp .L25
.L29:
	ldi r22,lo8(.LC21)
	ldi r23,hi8(.LC21)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L31
	ldi r22,lo8(.LC22)
	ldi r23,hi8(.LC22)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L32
.L31:
	call CON_SendStatus
	rjmp .L30
.L32:
	ldi r22,lo8(.LC23)
	ldi r23,hi8(.LC23)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L33
	lds r24,Global_stTankData+6
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC24)
	ldi r25,hi8(.LC24)
.L58:
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r24,r16
	call UART_SendString
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	rjmp .L30
.L33:
	ldi r22,lo8(.LC25)
	ldi r23,hi8(.LC25)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L34
	lds r24,Global_stTankData+10
	lds r25,Global_stTankData+11
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	push r25
	push r24
	push r23
	push r22
	ldi r24,lo8(.LC26)
	ldi r25,hi8(.LC26)
.L59:
	push r25
	push r24
	movw r16,r28
	subi r16,-1
	sbci r17,-1
	push r17
	push r16
	call sprintf
	movw r24,r16
	call UART_SendString
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	rjmp .L30
.L34:
	ldi r22,lo8(.LC27)
	ldi r23,hi8(.LC27)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L35
	lds r24,Global_stTankData+15
	push r24
	lds r24,Global_stTankData+14
	push r24
	lds r24,Global_stTankData+13
	push r24
	lds r24,Global_stTankData+12
	push r24
	ldi r24,lo8(.LC28)
	ldi r25,hi8(.LC28)
	rjmp .L59
.L35:
	ldi r22,lo8(.LC29)
	ldi r23,hi8(.LC29)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L36
	lds r24,Global_stTankData+9
	push r24
	lds r24,Global_stTankData+8
	push r24
	ldi r24,lo8(.LC30)
	ldi r25,hi8(.LC30)
	rjmp .L58
.L36:
	ldi r22,lo8(.LC31)
	ldi r23,hi8(.LC31)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L37
	ldi r24,lo8(.LC32)
	ldi r25,hi8(.LC32)
.L57:
	call UART_SendString
	rjmp .L30
.L37:
	ldi r22,lo8(.LC33)
	ldi r23,hi8(.LC33)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L38
	call FSM_Ack
	or r24,r25
	brne .L39
.L60:
	ldi r24,lo8(.LC34)
	ldi r25,hi8(.LC34)
	rjmp .L57
.L39:
	ldi r24,lo8(.LC35)
	ldi r25,hi8(.LC35)
	rjmp .L57
.L38:
	ldi r22,lo8(.LC36)
	ldi r23,hi8(.LC36)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L40
/* epilogue start */
	adiw r28,32
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	jmp CON_SendFaults
.L40:
	ldi r22,lo8(.LC37)
	ldi r23,hi8(.LC37)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L41
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Clear
	rjmp .L60
.L41:
	ldi r22,lo8(.LC38)
	ldi r23,hi8(.LC38)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L42
	lds r24,Global_stTankData+19
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC39)
	ldi r25,hi8(.LC39)
	rjmp .L58
.L42:
	ldi r22,lo8(.LC40)
	ldi r23,hi8(.LC40)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L43
.L44:
	ldi r24,lo8(.LC41)
	ldi r25,hi8(.LC41)
	rjmp .L57
.L43:
	ldi r22,lo8(.LC42)
	ldi r23,hi8(.LC42)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L44
	ldi r22,lo8(.LC43)
	ldi r23,hi8(.LC43)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L45
.L46:
	ldi r24,lo8(.LC44)
	ldi r25,hi8(.LC44)
	rjmp .L57
.L45:
	ldi r22,lo8(.LC45)
	ldi r23,hi8(.LC45)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L46
	ldi r22,lo8(.LC46)
	ldi r23,hi8(.LC46)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L46
	ldi r22,lo8(.LC47)
	ldi r23,hi8(.LC47)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L46
	ldi r22,lo8(.LC48)
	ldi r23,hi8(.LC48)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L47
.L48:
	ldi r24,lo8(.LC49)
	ldi r25,hi8(.LC49)
	rjmp .L57
.L47:
	ldi r22,lo8(.LC50)
	ldi r23,hi8(.LC50)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L48
	rjmp .L26
	.size	CON_ProcessCommand, .-CON_ProcessCommand
	.section	.rodata.CON_Run.str1.1,"aMS",@progbits,1
.LC51:
	.string	"ERR LONG\r\n"
	.section	.text.CON_Run,"ax",@progbits
.global	CON_Run
	.type	CON_Run, @function
CON_Run:
	push r16
	push r17
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 7 */
.L__stack_usage = 7
	movw r16,r28
	subi r16,-1
	sbci r17,-1
.L62:
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_IsEmpty
	cp r24, __zero_reg__
	breq .L72
.L61:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L72:
	movw r22,r16
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Get
	std Y+2,r16
	std Y+3,r17
	or r24,r25
	brne .L61
	ldd r24,Y+1
	lds r30,g_conLineLen
	cpi r24,lo8(13)
	breq .L64
	cpi r24,lo8(10)
	brne .L65
.L64:
	cp r30, __zero_reg__
	breq .L62
	ldi r31,0
	subi r30,lo8(-(g_conLine))
	sbci r31,hi8(-(g_conLine))
	st Z,__zero_reg__
	ldi r24,lo8(g_conLine)
	ldi r25,hi8(g_conLine)
	call CON_ProcessCommand
.L70:
	sts g_conLineLen,__zero_reg__
	rjmp .L62
.L65:
	cpi r30,lo8(40)
	brsh .L67
	mov r26,r30
	ldi r27,0
	subi r26,lo8(-(g_conLine))
	sbci r27,hi8(-(g_conLine))
	st X,r24
	subi r30,lo8(-(1))
	sts g_conLineLen,r30
	rjmp .L62
.L67:
	ldi r24,lo8(.LC51)
	ldi r25,hi8(.LC51)
	call UART_SendString
.L68:
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_IsEmpty
	cpse r24,__zero_reg__
	rjmp .L70
	ldd r22,Y+2
	ldd r23,Y+3
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Get
	or r24,r25
	brne .L70
	ldd r24,Y+1
	cpi r24,lo8(13)
	breq .L70
	cpi r24,lo8(10)
	brne .L68
	rjmp .L70
	.size	CON_Run, .-CON_Run
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC52:
	.string	"INIT"
.LC53:
	.string	"IDLE"
.LC54:
	.string	"FILLING"
.LC55:
	.string	"SETTLING"
.LC56:
	.string	"RES_WAIT"
.LC57:
	.string	"TRIPPED"
.LC58:
	.string	"MANUAL"
.LC59:
	.string	"SERVICE"
	.section	.rodata.CSWTCH.41,"a"
	.type	CSWTCH.41, @object
	.size	CSWTCH.41, 16
CSWTCH.41:
	.word	.LC52
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.section	.bss.g_conLineLen,"aw",@nobits
	.type	g_conLineLen, @object
	.size	g_conLineLen, 1
g_conLineLen:
	.zero	1
	.section	.bss.g_conLine,"aw",@nobits
	.type	g_conLine, @object
	.size	g_conLine, 41
g_conLine:
	.zero	41
.global	g_conFaultLog
	.section	.bss.g_conFaultLog,"aw",@nobits
	.type	g_conFaultLog, @object
	.size	g_conFaultLog, 147
g_conFaultLog:
	.zero	147
	.section	.bss.g_conRxBuffer,"aw",@nobits
	.type	g_conRxBuffer, @object
	.size	g_conRxBuffer, 67
g_conRxBuffer:
	.zero	67
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
