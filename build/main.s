	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.startup.main,"ax",@progbits
.global	main
	.type	main, @function
main:
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
/* stack size = 4 */
.L__stack_usage = 4
	ldi r24,lo8(3)
	call BTN_Init
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,lo8(1)
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinDirection
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	ldi r20,0
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_SetPinValue
	movw r16,r28
	subi r16,-1
	sbci r17,-1
.L5:
	ldi r24,lo8(3)
	call BTN_Update10ms
	movw r22,r16
	ldi r24,0
	ldi r25,0
	call BTN_GetEvent
	ldd r24,Y+1
	ldd r25,Y+2
	std Y+3,r16
	std Y+4,r17
	sbiw r24,1
	brne .L2
	ldi r22,0
	ldi r24,lo8(2)
	call GPIO_TogglePinValue
.L2:
	ldd r22,Y+3
	ldd r23,Y+4
	ldi r24,lo8(1)
	ldi r25,0
	call BTN_GetEvent
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,1
	brne .L3
	ldi r22,lo8(1)
	ldi r24,lo8(2)
	call GPIO_TogglePinValue
.L3:
	ldd r22,Y+3
	ldd r23,Y+4
	ldi r24,lo8(2)
	ldi r25,0
	call BTN_GetEvent
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,4
	brne .L4
	ldi r22,lo8(2)
	ldi r24,lo8(2)
	call GPIO_TogglePinValue
.L4:
	ldi r24,lo8(19999)
	ldi r25,hi8(19999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L5
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
