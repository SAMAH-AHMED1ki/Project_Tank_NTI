	.file	"demand.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.DEM_Init,"ax",@progbits
.global	DEM_Init
	.type	DEM_Init, @function
DEM_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_u8PumpDemand,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	DEM_Init, .-DEM_Init
	.section	.text.DEM_Update,"ax",@progbits
.global	DEM_Update
	.type	DEM_Update, @function
DEM_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L6
	movw r30,r24
	ldd r24,Z+6
	cpi r24,lo8(30)
	brsh .L4
	ldi r24,lo8(1)
	sts Global_u8PumpDemand,r24
.L5:
	ldi r24,0
	ldi r25,0
	ret
.L4:
	cpi r24,lo8(91)
	brlo .L5
	sts Global_u8PumpDemand,__zero_reg__
	rjmp .L5
.L6:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	DEM_Update, .-DEM_Update
	.section	.text.DEM_GetPumpDemand,"ax",@progbits
.global	DEM_GetPumpDemand
	.type	DEM_GetPumpDemand, @function
DEM_GetPumpDemand:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_u8PumpDemand
/* epilogue start */
	ret
	.size	DEM_GetPumpDemand, .-DEM_GetPumpDemand
	.section	.bss.Global_u8PumpDemand,"aw",@nobits
	.type	Global_u8PumpDemand, @object
	.size	Global_u8PumpDemand, 1
Global_u8PumpDemand:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
