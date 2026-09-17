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
.L10:
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
	rjmp .L10
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
	cpi r25,lo8(13)
	breq .L12
	brsh .L6
	cp r25, __zero_reg__
	breq .L12
	subi r25,lo8(-(-9))
	ldi r24,lo8(1)
	cpi r25,lo8(2)
	brsh .L10
.L1:
/* epilogue start */
	ret
.L6:
	ldi r24,lo8(1)
	cpi r25,lo8(32)
	brne .L10
	ret
.L12:
	ldi r24,lo8(1)
	ret
	.size	CON_CompareNoCase, .-CON_CompareNoCase
	.section	.text.CON_SkipSpaces,"ax",@progbits
	.type	CON_SkipSpaces, @function
CON_SkipSpaces:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r26,r24
.L18:
	ld r30,X+
	ld r31,X+
	sbiw r26,2
	sbiw r30,0
	breq .L17
	ld r25,Z
	cpi r25,lo8(32)
	breq .L20
	ldi r24,lo8(-9)
	add r24,r25
	cpi r24,lo8(2)
	brlo .L20
	cpi r25,lo8(13)
	breq .L20
.L17:
/* epilogue start */
	ret
.L20:
	adiw r30,1
	st X+,r30
	st X+,r31
	sbiw r26,2
	rjmp .L18
	.size	CON_SkipSpaces, .-CON_SkipSpaces
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
	brne .L31
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call UART_SetRxBuffer
	ldi r24,lo8(1)
	call UART_SetRxInterrupt
.L29:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L31:
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L29
	.size	CON_Init, .-CON_Init
	.section	.rodata.CON_SendStatus.str1.1,"aMS",@progbits,1
.LC0:
	.string	"$WT,L=0,R=0,I=0,Q=0,V=0,P=0,V2=0,ST=INIT,TR=0,RUN=0,UP=0*3A\r\n"
	.section	.text.CON_SendStatus,"ax",@progbits
.global	CON_SendStatus
	.type	CON_SendStatus, @function
CON_SendStatus:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	jmp UART_SendString
	.size	CON_SendStatus, .-CON_SendStatus
	.section	.rodata.CON_SendHelp.str1.1,"aMS",@progbits,1
.LC1:
	.string	"HELP\r\n"
.LC2:
	.string	"STATUS\r\n"
.LC3:
	.string	"LEVEL?\r\n"
.LC4:
	.string	"FLOW?\r\n"
.LC5:
	.string	"VOLUME?\r\n"
.LC6:
	.string	"CURRENT?\r\n"
.LC7:
	.string	"CFG?\r\n"
.LC8:
	.string	"ACK\r\n"
.LC9:
	.string	"FAULTS?\r\n"
.LC10:
	.string	"CLRFAULTS\r\n"
	.section	.text.CON_SendHelp,"ax",@progbits
.global	CON_SendHelp
	.type	CON_SendHelp, @function
CON_SendHelp:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call UART_SendString
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call UART_SendString
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call UART_SendString
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call UART_SendString
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
	jmp UART_SendString
	.size	CON_SendHelp, .-CON_SendHelp
	.section	.rodata.CON_SendFaults.str1.1,"aMS",@progbits,1
.LC11:
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
	rjmp .L35
	ldi r24,lo8(.LC11)
	ldi r25,hi8(.LC11)
	call UART_SendString
.L36:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
.L35:
	ldi r22,lo8(gs(CON_WriteByte))
	ldi r23,hi8(gs(CON_WriteByte))
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Dump
	rjmp .L36
	.size	CON_SendFaults, .-CON_SendFaults
	.section	.rodata.CON_ProcessCommand.str1.1,"aMS",@progbits,1
.LC12:
	.string	"ERR CMD\r\n"
.LC13:
	.string	"ERR LONG\r\n"
.LC14:
	.string	"STATUS"
.LC15:
	.string	"STATUS?"
.LC16:
	.string	"HELP"
.LC17:
	.string	"ACK"
.LC18:
	.string	"OK\r\n"
.LC19:
	.string	"FAULTS?"
.LC20:
	.string	"CLRFAULTS"
.LC21:
	.string	"LEVEL?"
.LC22:
	.string	"LEVEL=%u\r\n"
.LC23:
	.string	"FLOW?"
.LC24:
	.string	"FLOW=%.1f\r\n"
.LC25:
	.string	"VOLUME?"
.LC26:
	.string	"VOLUME=%lu\r\n"
.LC27:
	.string	"CURRENT?"
.LC28:
	.string	"CURRENT=%u\r\n"
.LC29:
	.string	"CFG?"
.LC30:
	.string	"CFG=0,0,0,0,0,0,0,0,0,0\r\n"
.LC31:
	.string	"MODE AUTO"
.LC32:
	.string	"MODE MANUAL"
.LC33:
	.string	"PUMP ON"
.LC34:
	.string	"PUMP OFF"
.LC35:
	.string	"VALVE ON"
.LC36:
	.string	"VALVE OFF"
.LC37:
	.string	"SERVICE ON"
.LC38:
	.string	"SERVICE OFF"
.LC39:
	.string	"TRIP?"
.LC40:
	.string	"TRIP=0,NONE\r\n"
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
	sbiw r28,36
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 36 */
/* stack size = 40 */
.L__stack_usage = 40
	sbiw r24,0
	brne .L38
.L60:
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
.L81:
	call UART_SendString
	ldi r24,lo8(1)
	ldi r25,0
.L37:
/* epilogue start */
	adiw r28,36
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
.L38:
	std Y+35,r24
	std Y+36,r25
	movw r24,r28
	adiw r24,35
	call CON_SkipSpaces
	ldd r16,Y+35
	ldd r17,Y+36
	movw r30,r16
	movw r18,r16
	subi r18,-33
	sbci r19,-1
.L40:
	ld r24,Z
	cp r24, __zero_reg__
	breq .L41
	cpi r24,lo8(13)
	breq .L41
	brsh .L42
	subi r24,lo8(-(-9))
	cpi r24,lo8(2)
	brsh .L43
.L41:
	ldi r22,lo8(.LC14)
	ldi r23,hi8(.LC14)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L44
	ldi r22,lo8(.LC15)
	ldi r23,hi8(.LC15)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L45
.L44:
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
.L78:
	call UART_SendString
.L48:
	ldi r24,0
	ldi r25,0
	rjmp .L37
.L42:
	cpi r24,lo8(32)
	breq .L41
.L43:
	adiw r30,1
	cp r30,r18
	cpc r31,r19
	brne .L40
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	rjmp .L81
.L45:
	ldi r22,lo8(.LC16)
	ldi r23,hi8(.LC16)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L47
	call CON_SendHelp
	rjmp .L48
.L47:
	ldi r22,lo8(.LC17)
	ldi r23,hi8(.LC17)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L49
	call FSM_Ack
.L82:
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	rjmp .L78
.L49:
	ldi r22,lo8(.LC19)
	ldi r23,hi8(.LC19)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L50
/* epilogue start */
	adiw r28,36
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
.L50:
	ldi r22,lo8(.LC20)
	ldi r23,hi8(.LC20)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L51
	ldi r24,lo8(g_conFaultLog)
	ldi r25,hi8(g_conFaultLog)
	call FLG_Clear
	rjmp .L82
.L51:
	ldi r22,lo8(.LC21)
	ldi r23,hi8(.LC21)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L52
	lds r24,Global_stTankData+6
	push __zero_reg__
	push r24
	ldi r24,lo8(.LC22)
	ldi r25,hi8(.LC22)
.L80:
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
	rjmp .L48
.L52:
	ldi r22,lo8(.LC23)
	ldi r23,hi8(.LC23)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L53
	lds r22,Global_stTankData+10
	lds r23,Global_stTankData+11
	ldi r24,0
	ldi r25,0
	call __floatunsisf
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(32)
	ldi r21,lo8(65)
	call __divsf3
	push r25
	push r24
	push r23
	push r22
	ldi r24,lo8(.LC24)
	ldi r25,hi8(.LC24)
.L79:
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
	rjmp .L48
.L53:
	ldi r22,lo8(.LC25)
	ldi r23,hi8(.LC25)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L54
	lds r24,Global_stTankData+15
	push r24
	lds r24,Global_stTankData+14
	push r24
	lds r24,Global_stTankData+13
	push r24
	lds r24,Global_stTankData+12
	push r24
	ldi r24,lo8(.LC26)
	ldi r25,hi8(.LC26)
	rjmp .L79
.L54:
	ldi r22,lo8(.LC27)
	ldi r23,hi8(.LC27)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L55
	lds r24,Global_stTankData+9
	push r24
	lds r24,Global_stTankData+8
	push r24
	ldi r24,lo8(.LC28)
	ldi r25,hi8(.LC28)
	rjmp .L80
.L55:
	ldi r22,lo8(.LC29)
	ldi r23,hi8(.LC29)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L56
	ldi r24,lo8(.LC30)
	ldi r25,hi8(.LC30)
	rjmp .L78
.L56:
	ldi r22,lo8(.LC31)
	ldi r23,hi8(.LC31)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC32)
	ldi r23,hi8(.LC32)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC33)
	ldi r23,hi8(.LC33)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC34)
	ldi r23,hi8(.LC34)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC35)
	ldi r23,hi8(.LC35)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC36)
	ldi r23,hi8(.LC36)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC37)
	ldi r23,hi8(.LC37)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC38)
	ldi r23,hi8(.LC38)
	movw r24,r16
	call CON_CompareNoCase
	cpse r24,__zero_reg__
	rjmp .L82
	ldi r22,lo8(.LC39)
	ldi r23,hi8(.LC39)
	movw r24,r16
	call CON_CompareNoCase
	cp r24, __zero_reg__
	breq .L59
	ldi r24,lo8(.LC40)
	ldi r25,hi8(.LC40)
	rjmp .L78
.L59:
	movw r30,r16
	ld r24,Z
	andi r24,lo8(-33)
	cpi r24,lo8(83)
	breq .+2
	rjmp .L60
	ldd r24,Z+1
	andi r24,lo8(-33)
	cpi r24,lo8(69)
	breq .+2
	rjmp .L60
	ldd r24,Z+2
	andi r24,lo8(-33)
	cpi r24,lo8(84)
	breq .+2
	rjmp .L60
	ldd r24,Z+3
	cpi r24,lo8(32)
	breq .L61
	cpi r24,lo8(9)
	breq .+2
	rjmp .L60
.L61:
	movw r30,r16
	ldd r24,Z+4
	andi r24,lo8(-33)
	cpi r24,lo8(83)
	breq .+2
	rjmp .L60
	ldd r24,Z+5
	andi r24,lo8(-33)
	cpi r24,lo8(84)
	breq .+2
	rjmp .L60
	subi r16,-7
	sbci r17,-1
	std Y+33,r16
	std Y+34,r17
	movw r24,r28
	adiw r24,33
	call CON_SkipSpaces
	ldd r24,Y+33
	ldd r25,Y+34
	std Y+1,r24
	std Y+2,r25
	or r24,r25
	brne .+2
	rjmp .L60
	movw r24,r28
	adiw r24,1
	call CON_SkipSpaces
	ldd r30,Y+1
	ldd r31,Y+2
	ld r24,Z
	subi r24,lo8(-(-48))
	cpi r24,lo8(10)
	brlo .+2
	rjmp .L60
.L66:
	ld r24,Z+
	subi r24,lo8(-(-48))
	cpi r24,lo8(10)
	brlo .L66
	rjmp .L82
	.size	CON_ProcessCommand, .-CON_ProcessCommand
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
.L84:
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_IsEmpty
	cp r24, __zero_reg__
	breq .L94
.L83:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L94:
	movw r22,r16
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Get
	std Y+2,r16
	std Y+3,r17
	or r24,r25
	brne .L83
	ldd r24,Y+1
	lds r30,g_conLineLen
	cpi r24,lo8(13)
	breq .L86
	cpi r24,lo8(10)
	brne .L87
.L86:
	cp r30, __zero_reg__
	breq .L84
	ldi r31,0
	subi r30,lo8(-(g_conLine))
	sbci r31,hi8(-(g_conLine))
	st Z,__zero_reg__
	ldi r24,lo8(g_conLine)
	ldi r25,hi8(g_conLine)
	call CON_ProcessCommand
.L92:
	sts g_conLineLen,__zero_reg__
	rjmp .L84
.L87:
	cpi r30,lo8(40)
	brsh .L89
	mov r26,r30
	ldi r27,0
	subi r26,lo8(-(g_conLine))
	sbci r27,hi8(-(g_conLine))
	st X,r24
	subi r30,lo8(-(1))
	sts g_conLineLen,r30
	rjmp .L84
.L89:
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	call UART_SendString
.L90:
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_IsEmpty
	cpse r24,__zero_reg__
	rjmp .L92
	ldd r22,Y+2
	ldd r23,Y+3
	ldi r24,lo8(g_conRxBuffer)
	ldi r25,hi8(g_conRxBuffer)
	call RB_Get
	or r24,r25
	brne .L92
	ldd r24,Y+1
	cpi r24,lo8(13)
	breq .L92
	cpi r24,lo8(10)
	brne .L90
	rjmp .L92
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
.global	__divsf3
.global	__floatunsisf
	.ident	"GCC: (GNU) 15.2.0"
.global __do_copy_data
.global __do_clear_bss
