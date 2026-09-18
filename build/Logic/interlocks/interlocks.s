	.file	"interlocks.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.ResetTimers,"ax",@progbits
	.type	ResetTimers, @function
ResetTimers:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_u16OverflowTicks,__zero_reg__
	sts Global_u16OverflowTicks+1,__zero_reg__
	sts Global_u16OverCurrentTicks,__zero_reg__
	sts Global_u16OverCurrentTicks+1,__zero_reg__
	sts Global_u16NoCurrentTicks,__zero_reg__
	sts Global_u16NoCurrentTicks+1,__zero_reg__
	sts Global_u16DryRunTicks,__zero_reg__
	sts Global_u16DryRunTicks+1,__zero_reg__
	sts Global_u16LevelSensorTicks,__zero_reg__
	sts Global_u16LevelSensorTicks+1,__zero_reg__
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	sts Global_u16NoRiseTicks,__zero_reg__
	sts Global_u16NoRiseTicks+1,__zero_reg__
	sts Global_u8LeakStartLevel,__zero_reg__
	sts Global_u8NoRiseStartLevel,__zero_reg__
/* epilogue start */
	ret
	.size	ResetTimers, .-ResetTimers
	.section	.text.INT_Init,"ax",@progbits
.global	INT_Init
	.type	INT_Init, @function
INT_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_eTrip,__zero_reg__
	sts Global_eTrip+1,__zero_reg__
	sts Global_u8Ack,__zero_reg__
	call ResetTimers
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INT_Init, .-INT_Init
	.section	.text.ILK_Reset,"ax",@progbits
.global	ILK_Reset
	.type	ILK_Reset, @function
ILK_Reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_eTrip
	lds r25,Global_eTrip+1
	or r24,r25
	breq .L4
	ldi r24,lo8(1)
	sts Global_u8Ack,r24
.L4:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	ILK_Reset, .-ILK_Reset
	.section	.text.ILK_Evaluate,"ax",@progbits
.global	ILK_Evaluate
	.type	ILK_Evaluate, @function
ILK_Evaluate:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r26,r24
	lds r28,Global_eTrip
	lds r29,Global_eTrip+1
	or r24,r25
	breq .L8
	sbiw r28,0
	brne .+2
	rjmp .L10
	lds r24,Global_u8Ack
	cp r24, __zero_reg__
	breq .L8
	movw r30,r28
	sbiw r30,1
	cpi r30,9
	cpc r31,__zero_reg__
	brsh .L12
	subi r30,lo8(-(gs(.L14)))
	sbci r31,hi8(-(gs(.L14)))
	jmp __tablejump2__
	.section	.jumptables.gcc.ILK_Evaluate,"a",@progbits
	.p2align	1
	.type	.L14, @object
.L14:
	.word gs(.L19)
	.word gs(.L18)
	.word gs(.L17)
	.word gs(.L16)
	.word gs(.L13)
	.word gs(.L13)
	.word gs(.L15)
	.word gs(.L13)
	.word gs(.L13)
	.section	.text.ILK_Evaluate
.L19:
	adiw r26,6
	ld r24,X
	sbiw r26,6
	cpi r24,lo8(96)
	brsh .L8
	adiw r26,17
	ld r24,X
	sbrs r24,2
	rjmp .L12
.L8:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L18:
	adiw r26,8
	ld r24,X+
	ld r25,X+
	sbiw r26,10
	cpi r24,-24
	sbci r25,3
	brsh .L8
.L13:
	adiw r26,17
	ld r24,X
	sbrc r24,0
	rjmp .L8
	rjmp .L12
.L17:
	adiw r26,7
	ld r24,X
	sbiw r26,7
	cpi r24,lo8(25)
	brlo .L8
	adiw r26,17
	ld r24,X
	sbrc r24,3
	rjmp .L8
.L12:
	sts Global_eTrip,__zero_reg__
	sts Global_eTrip+1,__zero_reg__
	sts Global_u8Ack,__zero_reg__
	call ResetTimers
	ldi r28,0
	ldi r29,0
	rjmp .L8
.L16:
	adiw r26,7
	ld r24,X
	cpi r24,lo8(25)
	brlo .L8
	rjmp .L12
.L15:
	ld r24,X+
	ld r25,X+
	sbiw r24,1
	cpi r24,-2
	sbci r25,3
	brsh .L8
	rjmp .L12
.L10:
	adiw r26,17
	ld r25,X
	sbiw r26,17
	sbrc r25,2
	rjmp .L20
	adiw r26,6
	ld r24,X
	sbiw r26,6
	cpi r24,lo8(99)
	brlo .L21
	lds r18,Global_u16OverflowTicks
	lds r19,Global_u16OverflowTicks+1
	cpi r18,-56
	cpc r19,__zero_reg__
	brsh .L20
	subi r18,-1
	sbci r19,-1
	sts Global_u16OverflowTicks,r18
	sts Global_u16OverflowTicks+1,r19
	cpi r18,-56
	cpc r19,__zero_reg__
	brne .L22
.L20:
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L52
.L21:
	sts Global_u16OverflowTicks,__zero_reg__
	sts Global_u16OverflowTicks+1,__zero_reg__
.L22:
	adiw r26,8
	ld r20,X+
	ld r21,X+
	sbiw r26,10
	cpi r20,65
	ldi r22,31
	cpc r21,r22
	brsh .+2
	rjmp .L23
	lds r18,Global_u16OverCurrentTicks
	lds r19,Global_u16OverCurrentTicks+1
	cpi r18,50
	cpc r19,__zero_reg__
	brlo .L24
.L26:
	ldi r28,lo8(2)
	ldi r29,0
.L52:
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	sts Global_u16NoRiseTicks,__zero_reg__
	sts Global_u16NoRiseTicks+1,__zero_reg__
.L59:
	sts Global_eTrip,r28
	sts Global_eTrip+1,__zero_reg__
	sts Global_u8Ack,__zero_reg__
	call ResetTimers
	rjmp .L8
.L24:
	subi r18,-1
	sbci r19,-1
	sts Global_u16OverCurrentTicks,r18
	sts Global_u16OverCurrentTicks+1,r19
	cpi r18,50
	cpc r19,__zero_reg__
	breq .L26
.L27:
	sbrc r25,3
	rjmp .L61
	adiw r26,7
	ld r18,X
	sbiw r26,7
	cpi r18,lo8(10)
	brsh .+2
	rjmp .L61
	sbrs r25,0
	rjmp .L28
	adiw r26,10
	ld r18,X+
	ld r19,X+
	sbiw r26,12
	cpi r18,10
	cpc r19,__zero_reg__
	brsh .L29
	lds r18,Global_u16DryRunTicks
	lds r19,Global_u16DryRunTicks+1
	cpi r18,-24
	ldi r22,3
	cpc r19,r22
	brlo .L30
.L31:
	ldi r28,lo8(4)
	ldi r29,0
	rjmp .L52
.L23:
	sts Global_u16OverCurrentTicks,__zero_reg__
	sts Global_u16OverCurrentTicks+1,__zero_reg__
	rjmp .L27
.L30:
	subi r18,-1
	sbci r19,-1
	sts Global_u16DryRunTicks,r18
	sts Global_u16DryRunTicks+1,r19
	cpi r18,-24
	sbci r19,3
	breq .L31
.L32:
	cpi r20,-12
	sbci r21,1
	brsh .L33
	lds r18,Global_u16NoCurrentTicks
	lds r19,Global_u16NoCurrentTicks+1
	cpi r18,44
	ldi r20,1
	cpc r19,r20
	brlo .L34
.L35:
	ldi r28,lo8(5)
	ldi r29,0
	rjmp .L52
.L29:
	sts Global_u16DryRunTicks,__zero_reg__
	sts Global_u16DryRunTicks+1,__zero_reg__
	rjmp .L32
.L28:
	sts Global_u16DryRunTicks,__zero_reg__
	sts Global_u16DryRunTicks+1,__zero_reg__
.L33:
	sts Global_u16NoCurrentTicks,__zero_reg__
	sts Global_u16NoCurrentTicks+1,__zero_reg__
	rjmp .L36
.L34:
	subi r18,-1
	sbci r19,-1
	sts Global_u16NoCurrentTicks,r18
	sts Global_u16NoCurrentTicks+1,r19
	cpi r18,44
	sbci r19,1
	breq .L35
.L36:
	adiw r26,20
	ld r18,X+
	ld r19,X+
	sbiw r26,22
	cpi r18,-123
	sbci r19,3
	brlo .+2
	rjmp .L62
	ld r18,X+
	ld r19,X+
	sbiw r26,2
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L37
	cpi r18,-1
	sbci r19,3
	brne .L38
.L37:
	lds r18,Global_u16LevelSensorTicks
	lds r19,Global_u16LevelSensorTicks+1
	cpi r18,-12
	ldi r20,1
	cpc r19,r20
	brlo .L39
.L40:
	ldi r28,lo8(7)
	ldi r29,0
	rjmp .L52
.L39:
	subi r18,-1
	sbci r19,-1
	sts Global_u16LevelSensorTicks,r18
	sts Global_u16LevelSensorTicks+1,r19
	cpi r18,-12
	sbci r19,1
	breq .L40
.L41:
	adiw r26,18
	ld r18,X
	ldi r19,lo8(-6)
	add r19,r18
	cpi r19,lo8(2)
	brlo .L49
	cpi r18,lo8(3)
	brne .L43
.L49:
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	rjmp .L51
.L38:
	sts Global_u16LevelSensorTicks,__zero_reg__
	sts Global_u16LevelSensorTicks+1,__zero_reg__
	rjmp .L41
.L43:
	sbrc r25,0
	rjmp .L45
	lds r18,Global_u16LeakTicks
	lds r19,Global_u16LeakTicks+1
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	brne .L46
	sts Global_u8LeakStartLevel,r24
.L47:
	subi r18,-1
	sbci r19,-1
	sts Global_u16LeakTicks,r18
	sts Global_u16LeakTicks+1,r19
	cpi r18,112
	sbci r19,23
	breq .L50
.L51:
	sts Global_u16NoRiseTicks,__zero_reg__
	sts Global_u16NoRiseTicks+1,__zero_reg__
	rjmp .L8
.L46:
	cpi r18,112
	ldi r25,23
	cpc r19,r25
	brlo .L47
.L50:
	lds r25,Global_u8LeakStartLevel
	cp r24,r25
	brsh .L49
	mov r18,r25
	sub r18,r24
	sbc r19,r19
	cpi r18,6
	cpc r19,__zero_reg__
	brlo .L49
	ldi r28,lo8(8)
	ldi r29,0
	rjmp .L52
.L45:
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	lds r18,Global_u16NoRiseTicks
	lds r19,Global_u16NoRiseTicks+1
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L53
	cpi r18,-32
	ldi r20,46
	cpc r19,r20
	brlo .L56
.L57:
	lds r25,Global_u8NoRiseStartLevel
	cp r25,r24
	brsh .L58
	cpi r18,-32
	sbci r19,46
	brsh .+2
	rjmp .L8
	sub r24,r25
	cpi r24,lo8(1)
	breq .+2
	rjmp .L8
.L65:
	ldi r28,lo8(9)
	ldi r29,0
	rjmp .L59
.L61:
	ldi r28,lo8(3)
	ldi r29,0
	rjmp .L52
.L62:
	ldi r28,lo8(6)
	ldi r29,0
	rjmp .L52
.L53:
	sts Global_u8NoRiseStartLevel,r24
.L56:
	subi r18,-1
	sbci r19,-1
	sts Global_u16NoRiseTicks,r18
	sts Global_u16NoRiseTicks+1,r19
	rjmp .L57
.L58:
	cpi r18,-32
	sbci r19,46
	brsh .+2
	rjmp .L8
	rjmp .L65
	.size	ILK_Evaluate, .-ILK_Evaluate
	.section	.bss.Global_u8Ack,"aw",@nobits
	.type	Global_u8Ack, @object
	.size	Global_u8Ack, 1
Global_u8Ack:
	.zero	1
	.section	.bss.Global_u8NoRiseStartLevel,"aw",@nobits
	.type	Global_u8NoRiseStartLevel, @object
	.size	Global_u8NoRiseStartLevel, 1
Global_u8NoRiseStartLevel:
	.zero	1
	.section	.bss.Global_u8LeakStartLevel,"aw",@nobits
	.type	Global_u8LeakStartLevel, @object
	.size	Global_u8LeakStartLevel, 1
Global_u8LeakStartLevel:
	.zero	1
	.section	.bss.Global_u16NoRiseTicks,"aw",@nobits
	.type	Global_u16NoRiseTicks, @object
	.size	Global_u16NoRiseTicks, 2
Global_u16NoRiseTicks:
	.zero	2
	.section	.bss.Global_u16LeakTicks,"aw",@nobits
	.type	Global_u16LeakTicks, @object
	.size	Global_u16LeakTicks, 2
Global_u16LeakTicks:
	.zero	2
	.section	.bss.Global_u16LevelSensorTicks,"aw",@nobits
	.type	Global_u16LevelSensorTicks, @object
	.size	Global_u16LevelSensorTicks, 2
Global_u16LevelSensorTicks:
	.zero	2
	.section	.bss.Global_u16DryRunTicks,"aw",@nobits
	.type	Global_u16DryRunTicks, @object
	.size	Global_u16DryRunTicks, 2
Global_u16DryRunTicks:
	.zero	2
	.section	.bss.Global_u16NoCurrentTicks,"aw",@nobits
	.type	Global_u16NoCurrentTicks, @object
	.size	Global_u16NoCurrentTicks, 2
Global_u16NoCurrentTicks:
	.zero	2
	.section	.bss.Global_u16OverCurrentTicks,"aw",@nobits
	.type	Global_u16OverCurrentTicks, @object
	.size	Global_u16OverCurrentTicks, 2
Global_u16OverCurrentTicks:
	.zero	2
	.section	.bss.Global_u16OverflowTicks,"aw",@nobits
	.type	Global_u16OverflowTicks, @object
	.size	Global_u16OverflowTicks, 2
Global_u16OverflowTicks:
	.zero	2
	.section	.bss.Global_eTrip,"aw",@nobits
	.type	Global_eTrip, @object
	.size	Global_eTrip, 2
Global_eTrip:
	.zero	2
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
