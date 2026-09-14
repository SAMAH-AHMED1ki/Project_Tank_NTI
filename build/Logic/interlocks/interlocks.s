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
	sts Global_u8LeakStartLevel,__zero_reg__
	sts Global_u8NoRiseStartLevel,__zero_reg__
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
	ldi r24,lo8(1)
	sts Global_u8Ack,r24
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
	movw r30,r24
	lds r28,Global_eTrip
	lds r29,Global_eTrip+1
	sbiw r28,0
	brne .+2
	rjmp .L5
	lds r24,Global_u8Ack
	cp r24, __zero_reg__
	breq .L4
	sts Global_u8Ack,__zero_reg__
	cpi r28,4
	cpc r29,__zero_reg__
	breq .L7
	brsh .L8
	cpi r28,2
	cpc r29,__zero_reg__
	breq .L9
	cpi r28,3
	cpc r29,__zero_reg__
	brne .L96
	ldd r24,Z+7
	cpi r24,lo8(25)
	brlo .L4
	ldd r24,Z+17
	sbrs r24,3
	rjmp .L14
.L4:
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	ret
.L8:
	cpi r28,6
	cpc r29,__zero_reg__
	breq .L12
	cpi r28,7
	cpc r29,__zero_reg__
	breq .L13
.L14:
	sts Global_eTrip,__zero_reg__
	sts Global_eTrip+1,__zero_reg__
	call ResetTimers
	ldi r28,0
	ldi r29,0
	rjmp .L4
.L96:
	ldd r24,Z+6
	cpi r24,lo8(96)
	brsh .L56
	ldd r24,Z+17
	sbrs r24,2
	rjmp .L14
.L56:
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L4
.L9:
	ldd r24,Z+8
	ldd r25,Z+9
	cpi r24,-24
	sbci r25,3
	brsh .L4
.L12:
	ldd r24,Z+17
	sbrc r24,0
	rjmp .L4
	rjmp .L14
.L7:
	ldd r24,Z+7
	cpi r24,lo8(25)
	brlo .L4
	rjmp .L14
.L13:
	ld r24,Z
	ldd r25,Z+1
	sbiw r24,1
	cpi r24,-2
	sbci r25,3
	brsh .L4
	rjmp .L14
.L5:
	ldd r25,Z+17
	sbrc r25,2
	rjmp .L16
	ldd r24,Z+6
	cpi r24,lo8(99)
	brlo .L17
	lds r18,Global_u16OverflowTicks
	lds r19,Global_u16OverflowTicks+1
	cpi r18,-56
	cpc r19,__zero_reg__
	brsh .L16
	subi r18,-1
	sbci r19,-1
	sts Global_u16OverflowTicks,r18
	sts Global_u16OverflowTicks+1,r19
	cpi r18,-56
	cpc r19,__zero_reg__
	brne .L18
.L16:
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L48
.L17:
	sts Global_u16OverflowTicks,__zero_reg__
	sts Global_u16OverflowTicks+1,__zero_reg__
.L18:
	ldd r20,Z+8
	ldd r21,Z+9
	cpi r20,65
	ldi r22,31
	cpc r21,r22
	brlo .L19
	lds r18,Global_u16OverCurrentTicks
	lds r19,Global_u16OverCurrentTicks+1
	cpi r18,50
	cpc r19,__zero_reg__
	brlo .L20
.L22:
	ldi r28,lo8(2)
	ldi r29,0
.L48:
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	sts Global_u16NoRiseTicks,__zero_reg__
	sts Global_u16NoRiseTicks+1,__zero_reg__
.L55:
	sts Global_eTrip,r28
	sts Global_eTrip+1,__zero_reg__
	call ResetTimers
	rjmp .L4
.L20:
	subi r18,-1
	sbci r19,-1
	sts Global_u16OverCurrentTicks,r18
	sts Global_u16OverCurrentTicks+1,r19
	cpi r18,50
	cpc r19,__zero_reg__
	breq .L22
.L23:
	sbrc r25,3
	rjmp .L58
	ldd r18,Z+7
	cpi r18,lo8(10)
	brsh .+2
	rjmp .L58
	sbrs r25,0
	rjmp .L24
	ldd r18,Z+10
	ldd r19,Z+11
	cpi r18,10
	cpc r19,__zero_reg__
	brsh .L25
	lds r18,Global_u16DryRunTicks
	lds r19,Global_u16DryRunTicks+1
	cpi r18,-24
	ldi r22,3
	cpc r19,r22
	brlo .L26
.L27:
	ldi r28,lo8(4)
	ldi r29,0
	rjmp .L48
.L19:
	sts Global_u16OverCurrentTicks,__zero_reg__
	sts Global_u16OverCurrentTicks+1,__zero_reg__
	rjmp .L23
.L26:
	subi r18,-1
	sbci r19,-1
	sts Global_u16DryRunTicks,r18
	sts Global_u16DryRunTicks+1,r19
	cpi r18,-24
	sbci r19,3
	breq .L27
.L28:
	cpi r20,-12
	sbci r21,1
	brsh .L29
	lds r18,Global_u16NoCurrentTicks
	lds r19,Global_u16NoCurrentTicks+1
	cpi r18,44
	ldi r20,1
	cpc r19,r20
	brlo .L30
.L31:
	ldi r28,lo8(5)
	ldi r29,0
	rjmp .L48
.L25:
	sts Global_u16DryRunTicks,__zero_reg__
	sts Global_u16DryRunTicks+1,__zero_reg__
	rjmp .L28
.L24:
	sts Global_u16DryRunTicks,__zero_reg__
	sts Global_u16DryRunTicks+1,__zero_reg__
.L29:
	sts Global_u16NoCurrentTicks,__zero_reg__
	sts Global_u16NoCurrentTicks+1,__zero_reg__
	rjmp .L32
.L30:
	subi r18,-1
	sbci r19,-1
	sts Global_u16NoCurrentTicks,r18
	sts Global_u16NoCurrentTicks+1,r19
	cpi r18,44
	sbci r19,1
	breq .L31
.L32:
	ldd r18,Z+20
	ldd r19,Z+21
	cpi r18,-123
	sbci r19,3
	brlo .+2
	rjmp .L59
	ld r18,Z
	ldd r19,Z+1
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L33
	cpi r18,-1
	sbci r19,3
	brne .L34
.L33:
	lds r18,Global_u16LevelSensorTicks
	lds r19,Global_u16LevelSensorTicks+1
	cpi r18,-12
	ldi r20,1
	cpc r19,r20
	brlo .L35
.L36:
	ldi r28,lo8(7)
	ldi r29,0
	rjmp .L48
.L35:
	subi r18,-1
	sbci r19,-1
	sts Global_u16LevelSensorTicks,r18
	sts Global_u16LevelSensorTicks+1,r19
	cpi r18,-12
	sbci r19,1
	breq .L36
.L37:
	ldd r18,Z+18
	ldi r19,lo8(-6)
	add r19,r18
	cpi r19,lo8(2)
	brlo .L45
	cpi r18,lo8(3)
	brne .L39
.L45:
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	rjmp .L47
.L34:
	sts Global_u16LevelSensorTicks,__zero_reg__
	sts Global_u16LevelSensorTicks+1,__zero_reg__
	rjmp .L37
.L39:
	sbrc r25,0
	rjmp .L41
	lds r18,Global_u16LeakTicks
	lds r19,Global_u16LeakTicks+1
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	brne .L42
	sts Global_u8LeakStartLevel,r24
.L43:
	subi r18,-1
	sbci r19,-1
	sts Global_u16LeakTicks,r18
	sts Global_u16LeakTicks+1,r19
	cpi r18,112
	sbci r19,23
	breq .L46
.L47:
	sts Global_u16NoRiseTicks,__zero_reg__
	sts Global_u16NoRiseTicks+1,__zero_reg__
	rjmp .L4
.L42:
	cpi r18,112
	ldi r25,23
	cpc r19,r25
	brlo .L43
.L46:
	lds r25,Global_u8LeakStartLevel
	cp r24,r25
	brsh .L45
	mov r18,r25
	sub r18,r24
	sbc r19,r19
	cpi r18,6
	cpc r19,__zero_reg__
	brlo .L45
	ldi r28,lo8(8)
	ldi r29,0
	rjmp .L48
.L41:
	sts Global_u16LeakTicks,__zero_reg__
	sts Global_u16LeakTicks+1,__zero_reg__
	lds r18,Global_u16NoRiseTicks
	lds r19,Global_u16NoRiseTicks+1
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L49
	cpi r18,-32
	ldi r20,46
	cpc r19,r20
	brlo .L52
.L53:
	lds r25,Global_u8NoRiseStartLevel
	cp r25,r24
	brsh .L54
	cpi r18,-32
	sbci r19,46
	brsh .+2
	rjmp .L4
	sub r24,r25
	cpi r24,lo8(1)
	breq .+2
	rjmp .L4
.L62:
	ldi r28,lo8(9)
	ldi r29,0
	rjmp .L55
.L58:
	ldi r28,lo8(3)
	ldi r29,0
	rjmp .L48
.L59:
	ldi r28,lo8(6)
	ldi r29,0
	rjmp .L48
.L49:
	sts Global_u8NoRiseStartLevel,r24
.L52:
	subi r18,-1
	sbci r19,-1
	sts Global_u16NoRiseTicks,r18
	sts Global_u16NoRiseTicks+1,r19
	rjmp .L53
.L54:
	cpi r18,-32
	sbci r19,46
	brsh .+2
	rjmp .L4
	rjmp .L62
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
