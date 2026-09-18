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
	.string	"\r\nLEVEL="
.LC1:
	.string	"%"
.LC2:
	.string	" R="
.LC3:
	.string	" I="
.LC4:
	.string	"mA\r\n"
.LC5:
	.string	"PUMP="
.LC6:
	.string	" VALVE="
.LC7:
	.string	" HIGH="
.LC8:
	.string	" LOW="
.LC9:
	.string	"\r\n"
.LC10:
	.string	"TRIP="
.LC11:
	.string	" STATE="
.LC12:
	.string	"INIT"
.LC13:
	.string	"IDLE"
.LC14:
	.string	"FILLING"
.LC15:
	.string	"TRIPPED"
.LC16:
	.string	"MANUAL"
.LC17:
	.string	"SERVICE"
.LC18:
	.string	"UNKNOWN"
	.section	.text.CON_SendStatus,"ax",@progbits
.global	CON_SendStatus
	.type	CON_SendStatus, @function
CON_SendStatus:
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
	call FSM_GetActiveTrip
	std Y+1,r24
	call FSM_GetState
	mov r16,r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call UART_SendString
	lds r24,Global_stTankData+6
	ldi r22,lo8(10)
	call __udivmodqi4
	call __udivmodqi4
	ldi r24,lo8(48)
	add r24,r25
	call UART_SendByte
	lds r24,Global_stTankData+6
	ldi r22,lo8(10)
	call __udivmodqi4
	ldi r24,lo8(48)
	add r24,r25
	call UART_SendByte
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call UART_SendString
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call UART_SendString
	lds r24,Global_stTankData+7
	ldi r22,lo8(10)
	call __udivmodqi4
	call __udivmodqi4
	ldi r24,lo8(48)
	add r24,r25
	call UART_SendByte
	lds r24,Global_stTankData+7
	ldi r22,lo8(10)
	call __udivmodqi4
	ldi r24,lo8(48)
	add r24,r25
	call UART_SendByte
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call UART_SendString
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call UART_SendString
	lds r24,Global_stTankData+8
	lds r25,Global_stTankData+9
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	call __udivmodhi4
	movw r24,r22
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	subi r24,lo8(-(48))
	call UART_SendByte
	lds r24,Global_stTankData+8
	lds r25,Global_stTankData+9
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	movw r24,r22
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	subi r24,lo8(-(48))
	call UART_SendByte
	lds r24,Global_stTankData+8
	lds r25,Global_stTankData+9
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	movw r24,r22
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	subi r24,lo8(-(48))
	call UART_SendByte
	lds r24,Global_stTankData+8
	lds r25,Global_stTankData+9
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	subi r24,lo8(-(48))
	call UART_SendByte
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call UART_SendString
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call UART_SendString
	lds r24,Global_stTankData+17
	andi r24,lo8(1)
	subi r24,lo8(-(48))
	call UART_SendByte
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	call UART_SendString
	lds r24,Global_stTankData+17
	sbrs r24,1
	rjmp .L31
	ldi r24,lo8(49)
.L19:
	call UART_SendByte
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call UART_SendString
	lds r24,Global_stTankData+17
	sbrs r24,2
	rjmp .L32
	ldi r24,lo8(49)
.L20:
	call UART_SendByte
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	call UART_SendString
	lds r24,Global_stTankData+17
	sbrs r24,3
	rjmp .L33
	ldi r24,lo8(49)
.L21:
	call UART_SendByte
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call UART_SendString
	ldi r24,lo8(.LC10)
	ldi r25,hi8(.LC10)
	call UART_SendString
	ldd r24,Y+1
	ldi r22,lo8(10)
	call __udivmodqi4
	std Y+1,r25
	call __udivmodqi4
	ldi r24,lo8(48)
	add r24,r25
	call UART_SendByte
	ldd r24,Y+1
	subi r24,lo8(-(48))
	call UART_SendByte
	ldi r24,lo8(.LC11)
	ldi r25,hi8(.LC11)
	call UART_SendString
	mov r24,r16
	ldi r25,0
	cpi r16,lo8(5)
	breq .L22
	cpi r24,6
	cpc r25,__zero_reg__
	brsh .L23
	cpi r24,1
	cpc r25,__zero_reg__
	breq .L24
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L25
	or r24,r25
	breq .L26
.L27:
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	rjmp .L34
.L31:
	ldi r24,lo8(48)
	rjmp .L19
.L32:
	ldi r24,lo8(48)
	rjmp .L20
.L33:
	ldi r24,lo8(48)
	rjmp .L21
.L23:
	breq .L28
	sbiw r24,7
	brne .L27
	ldi r24,lo8(.LC17)
	ldi r25,hi8(.LC17)
	rjmp .L34
.L26:
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
.L34:
	call UART_SendString
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	jmp UART_SendString
.L24:
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	rjmp .L34
.L25:
	ldi r24,lo8(.LC14)
	ldi r25,hi8(.LC14)
	rjmp .L34
.L22:
	ldi r24,lo8(.LC15)
	ldi r25,hi8(.LC15)
	rjmp .L34
.L28:
	ldi r24,lo8(.LC16)
	ldi r25,hi8(.LC16)
	rjmp .L34
	.size	CON_SendStatus, .-CON_SendStatus
	.section	.rodata.CON_SendHelp.str1.1,"aMS",@progbits,1
.LC19:
	.string	"=== WATER TANK CONSOLE ===\r\n"
.LC20:
	.string	"STATUS      - System status\r\n"
.LC21:
	.string	"LEVEL?      - Roof tank level\r\n"
.LC22:
	.string	"FLOW?       - Current flow\r\n"
.LC23:
	.string	"VOLUME?     - Total volume\r\n"
.LC24:
	.string	"CURRENT?    - Pump current\r\n"
.LC25:
	.string	"CFG?        - Configuration\r\n"
.LC26:
	.string	"TRIP?       - Active trip\r\n"
.LC27:
	.string	"FAULTS?     - Fault history\r\n"
.LC28:
	.string	"CLRFAULTS   - Clear fault history\r\n"
.LC29:
	.string	"ACK         - Acknowledge trip\r\n"
.LC30:
	.string	"MODE AUTO/MANUAL - Mode command\r\n"
.LC31:
	.string	"===========================\r\n"
	.section	.text.CON_SendHelp,"ax",@progbits
.global	CON_SendHelp
	.type	CON_SendHelp, @function
CON_SendHelp:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC19)
	ldi r25,hi8(.LC19)
	call UART_SendString
	ldi r24,lo8(.LC20)
	ldi r25,hi8(.LC20)
	call UART_SendString
	ldi r24,lo8(.LC21)
	ldi r25,hi8(.LC21)
	call UART_SendString
	ldi r24,lo8(.LC22)
	ldi r25,hi8(.LC22)
	call UART_SendString
	ldi r24,lo8(.LC23)
	ldi r25,hi8(.LC23)
	call UART_SendString
	ldi r24,lo8(.LC24)
	ldi r25,hi8(.LC24)
	call UART_SendString
	ldi r24,lo8(.LC25)
	ldi r25,hi8(.LC25)
	call UART_SendString
	ldi r24,lo8(.LC26)
	ldi r25,hi8(.LC26)
	call UART_SendString
	ldi r24,lo8(.LC27)
	ldi r25,hi8(.LC27)
	call UART_SendString
	ldi r24,lo8(.LC28)
	ldi r25,hi8(.LC28)
	call UART_SendString
	ldi r24,lo8(.LC29)
	ldi r25,hi8(.LC29)
	call UART_SendString
	ldi r24,lo8(.LC30)
	ldi r25,hi8(.LC30)
	call UART_SendString
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	jmp UART_SendString
	.size	CON_SendHelp, .-CON_SendHelp
	.section	.rodata.CON_SendFaults.str1.1,"aMS",@progbits,1
.LC32:
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
	rjmp .L37
	ldi r24,lo8(.LC32)
	ldi r25,hi8(.LC32)
	call UART_SendString
.L38:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L37:
	ldi r22,lo8(gs(CON_WriteByte))
	ldi r23,hi8(gs(CON_WriteByte))
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Dump
	rjmp .L38
	.size	CON_SendFaults, .-CON_SendFaults
	.section	.rodata.CON_ProcessCommand.str1.1,"aMS",@progbits,1
.LC33:
	.string	"ERR CMD\r\n"
.LC34:
	.string	"HELP"
.LC35:
	.string	"STATUS"
.LC36:
	.string	"STATUS?"
.LC37:
	.string	"LEVEL?"
.LC38:
	.string	"LEVEL=%u%%\r\n"
.LC39:
	.string	"FLOW?"
.LC40:
	.string	"FLOW=%u.%u L/min\r\n"
.LC41:
	.string	"VOLUME?"
.LC42:
	.string	"VOLUME=%lu L\r\n"
.LC43:
	.string	"CURRENT?"
.LC44:
	.string	"CURRENT=%u mA\r\n"
.LC45:
	.string	"CFG?"
.LC46:
	.string	"CFG=30,90,60,8,0.5,1,10,15,120\r\n"
.LC47:
	.string	"ACK"
.LC48:
	.string	"OK\r\n"
.LC49:
	.string	"ERR ACTIVE\r\n"
.LC50:
	.string	"FAULTS?"
.LC51:
	.string	"CLRFAULTS"
.LC52:
	.string	"TRIP?"
.LC53:
	.string	"TRIP=%u\r\n"
.LC54:
	.string	"MODE AUTO"
.LC55:
	.string	"ERR MODE - USE MODE BUTTON\r\n"
.LC56:
	.string	"MODE MANUAL"
.LC57:
	.string	"PUMP ON"
.LC58:
	.string	"ERR MODE - USE FSM CONTROL\r\n"
.LC59:
	.string	"PUMP OFF"
.LC60:
	.string	"VALVE ON"
.LC61:
	.string	"VALVE OFF"
.LC62:
	.string	"SERVICE ON"
.LC63:
	.string	"SERVICE MODE ON\r\n"
.LC64:
	.string	"SERVICE OFF"
.LC65:
	.string	"SERVICE MODE OFF\r\n"
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
	brne .L70
.L40:
	ldi r24,lo8(.LC33)
	ldi r25,hi8(.LC33)
	call UART_SendString
	ldi r24,lo8(1)
	ldi r25,0
.L39:
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
.L70:
	movw r16,r30
	ld r24,Z+
	cpi r24,lo8(32)
	breq .L70
	ldi r25,lo8(-9)
	add r25,r24
	cpi r25,lo8(2)
	brlo .L70
	cpi r24,lo8(13)
	breq .L70
	ldi r22,lo8(.LC34)
	ldi r23,hi8(.LC34)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L43
	call CON_SendHelp
.L46:
	ldi r24,0
	ldi r25,0
	rjmp .L39
.L43:
	ldi r22,lo8(.LC35)
	ldi r23,hi8(.LC35)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L44
	ldi r22,lo8(.LC36)
	ldi r23,hi8(.LC36)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L45
.L44:
	call CON_SendStatus
	rjmp .L46
.L45:
	ldi r22,lo8(.LC37)
	ldi r23,hi8(.LC37)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L47
	lds r24,Global_stTankData+6
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC38)
	ldi r25,hi8(.LC38)
.L76:
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
	rjmp .L46
.L47:
	ldi r22,lo8(.LC39)
	ldi r23,hi8(.LC39)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L48
	lds r24,Global_stTankData+10
	lds r25,Global_stTankData+11
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	push r25
	push r24
	push r23
	push r22
	ldi r24,lo8(.LC40)
	ldi r25,hi8(.LC40)
.L77:
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
	rjmp .L46
.L48:
	ldi r22,lo8(.LC41)
	ldi r23,hi8(.LC41)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L49
	lds r24,Global_stTankData+15
	push r24
	lds r24,Global_stTankData+14
	push r24
	lds r24,Global_stTankData+13
	push r24
	lds r24,Global_stTankData+12
	push r24
	ldi r24,lo8(.LC42)
	ldi r25,hi8(.LC42)
	rjmp .L77
.L49:
	ldi r22,lo8(.LC43)
	ldi r23,hi8(.LC43)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L50
	lds r24,Global_stTankData+9
	push r24
	lds r24,Global_stTankData+8
	push r24
	ldi r24,lo8(.LC44)
	ldi r25,hi8(.LC44)
	rjmp .L76
.L50:
	ldi r22,lo8(.LC45)
	ldi r23,hi8(.LC45)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L51
	ldi r24,lo8(.LC46)
	ldi r25,hi8(.LC46)
.L75:
	call UART_SendString
	rjmp .L46
.L51:
	ldi r22,lo8(.LC47)
	ldi r23,hi8(.LC47)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L52
	call FSM_Ack
	or r24,r25
	brne .L53
.L78:
	ldi r24,lo8(.LC48)
	ldi r25,hi8(.LC48)
	rjmp .L75
.L53:
	ldi r24,lo8(.LC49)
	ldi r25,hi8(.LC49)
	rjmp .L75
.L52:
	ldi r22,lo8(.LC50)
	ldi r23,hi8(.LC50)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L54
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
.L54:
	ldi r22,lo8(.LC51)
	ldi r23,hi8(.LC51)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L55
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Clear
	rjmp .L78
.L55:
	ldi r22,lo8(.LC52)
	ldi r23,hi8(.LC52)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L56
	lds r24,Global_stTankData+19
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC53)
	ldi r25,hi8(.LC53)
	rjmp .L76
.L56:
	ldi r22,lo8(.LC54)
	ldi r23,hi8(.LC54)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L57
.L58:
	ldi r24,lo8(.LC55)
	ldi r25,hi8(.LC55)
	rjmp .L75
.L57:
	ldi r22,lo8(.LC56)
	ldi r23,hi8(.LC56)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L58
	ldi r22,lo8(.LC57)
	ldi r23,hi8(.LC57)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L59
.L60:
	ldi r24,lo8(.LC58)
	ldi r25,hi8(.LC58)
	rjmp .L75
.L59:
	ldi r22,lo8(.LC59)
	ldi r23,hi8(.LC59)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L60
	ldi r22,lo8(.LC60)
	ldi r23,hi8(.LC60)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L60
	ldi r22,lo8(.LC61)
	ldi r23,hi8(.LC61)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L60
	ldi r22,lo8(.LC62)
	ldi r23,hi8(.LC62)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L61
	ldi r24,lo8(1)
	call FSM_SetServiceMode
	or r24,r25
	breq .+2
	rjmp .L46
	ldi r24,lo8(.LC63)
	ldi r25,hi8(.LC63)
	rjmp .L75
.L61:
	ldi r22,lo8(.LC64)
	ldi r23,hi8(.LC64)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	brne .+2
	rjmp .L40
	ldi r24,0
	call FSM_SetServiceMode
	or r24,r25
	breq .+2
	rjmp .L46
	ldi r24,lo8(.LC65)
	ldi r25,hi8(.LC65)
	rjmp .L75
	.size	CON_ProcessCommand, .-CON_ProcessCommand
	.section	.rodata.CON_Run.str1.1,"aMS",@progbits,1
.LC66:
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
.L80:
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_IsEmpty
	cp r24, __zero_reg__
	breq .L90
.L79:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L90:
	movw r22,r16
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Get
	std Y+2,r16
	std Y+3,r17
	or r24,r25
	brne .L79
	ldd r24,Y+1
	lds r30,g_conLineLen
	cpi r24,lo8(13)
	breq .L82
	cpi r24,lo8(10)
	brne .L83
.L82:
	cp r30, __zero_reg__
	breq .L80
	ldi r31,0
	subi r30,lo8(-(g_conLine))
	sbci r31,hi8(-(g_conLine))
	st Z,__zero_reg__
	ldi r24,lo8(g_conLine)
	ldi r25,hi8(g_conLine)
	call CON_ProcessCommand
.L88:
	sts g_conLineLen,__zero_reg__
	rjmp .L80
.L83:
	cpi r30,lo8(40)
	brsh .L85
	mov r26,r30
	ldi r27,0
	subi r26,lo8(-(g_conLine))
	sbci r27,hi8(-(g_conLine))
	st X,r24
	subi r30,lo8(-(1))
	sts g_conLineLen,r30
	rjmp .L80
.L85:
	ldi r24,lo8(.LC66)
	ldi r25,hi8(.LC66)
	call UART_SendString
.L86:
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_IsEmpty
	cpse r24,__zero_reg__
	rjmp .L88
	ldd r22,Y+2
	ldd r23,Y+3
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Get
	or r24,r25
	brne .L88
	ldd r24,Y+1
	cpi r24,lo8(13)
	breq .L88
	cpi r24,lo8(10)
	brne .L86
	rjmp .L88
	.size	CON_Run, .-CON_Run
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
