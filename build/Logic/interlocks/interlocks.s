	.file	"interlocks.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.INT_Init,"ax",@progbits
.global	INT_Init
	.type	INT_Init, @function
INT_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts Global_u8TripStatus,__zero_reg__
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INT_Init, .-INT_Init
	.section	.text.INT_Update,"ax",@progbits
.global	INT_Update
	.type	INT_Update, @function
INT_Update:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(64)
	ldi r25,lo8(31)
	call CUR_IsOverLimit
	ldi r25,lo8(1)
	cpi r24,lo8(1)
	breq .L3
	ldi r25,0
.L3:
	sts Global_u8TripStatus,r25
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	INT_Update, .-INT_Update
	.section	.text.INT_IsSystemTripped,"ax",@progbits
.global	INT_IsSystemTripped
	.type	INT_IsSystemTripped, @function
INT_IsSystemTripped:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Global_u8TripStatus
/* epilogue start */
	ret
	.size	INT_IsSystemTripped, .-INT_IsSystemTripped
	.section	.bss.Global_u8TripStatus,"aw",@nobits
	.type	Global_u8TripStatus, @object
	.size	Global_u8TripStatus, 1
Global_u8TripStatus:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
