	.file	"Pump.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.Pump_Init,"ax",@progbits
.global	Pump_Init
	.type	Pump_Init, @function
Pump_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinDirection
	sbiw r24,0
	brne .L1
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	sbiw r24,0
	brne .L1
	sts Pump_u8State,__zero_reg__
	sts Pump_u32RunSeconds,__zero_reg__
	sts Pump_u32RunSeconds+1,__zero_reg__
	sts Pump_u32RunSeconds+2,__zero_reg__
	sts Pump_u32RunSeconds+3,__zero_reg__
	sts Pump_u32Cycles,__zero_reg__
	sts Pump_u32Cycles+1,__zero_reg__
	sts Pump_u32Cycles+2,__zero_reg__
	sts Pump_u32Cycles+3,__zero_reg__
.L1:
/* epilogue start */
	ret
	.size	Pump_Init, .-Pump_Init
	.section	.text.Pump_Set,"ax",@progbits
.global	Pump_Set
	.type	Pump_Set, @function
Pump_Set:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,lo8(1)
	ldi r25,0
	cpi r28,lo8(2)
	brsh .L5
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(1)
	call GPIO_SetPinValue
	sbiw r24,0
	brne .L5
	lds r18,Pump_u8State
	cpse r18,__zero_reg__
	rjmp .L7
	cpi r28,lo8(1)
	brne .L7
	lds r20,Pump_u32Cycles
	lds r21,Pump_u32Cycles+1
	lds r22,Pump_u32Cycles+2
	lds r23,Pump_u32Cycles+3
	subi r20,-1
	sbci r21,-1
	sbci r22,-1
	sbci r23,-1
	sts Pump_u32Cycles,r20
	sts Pump_u32Cycles+1,r21
	sts Pump_u32Cycles+2,r22
	sts Pump_u32Cycles+3,r23
.L7:
	sts Pump_u8State,r28
.L5:
/* epilogue start */
	pop r28
	ret
	.size	Pump_Set, .-Pump_Set
	.section	.text.Pump_GetState,"ax",@progbits
.global	Pump_GetState
	.type	Pump_GetState, @function
Pump_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L11
	lds r18,Pump_u8State
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
	ret
.L11:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Pump_GetState, .-Pump_GetState
	.section	.text.Pump_GetRunSeconds,"ax",@progbits
.global	Pump_GetRunSeconds
	.type	Pump_GetRunSeconds, @function
Pump_GetRunSeconds:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L14
	lds r20,Pump_u32RunSeconds
	lds r21,Pump_u32RunSeconds+1
	lds r22,Pump_u32RunSeconds+2
	lds r23,Pump_u32RunSeconds+3
	movw r30,r24
	st Z,r20
	std Z+1,r21
	std Z+2,r22
	std Z+3,r23
	ldi r24,0
	ldi r25,0
	ret
.L14:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Pump_GetRunSeconds, .-Pump_GetRunSeconds
	.section	.text.Pump_GetCycles,"ax",@progbits
.global	Pump_GetCycles
	.type	Pump_GetCycles, @function
Pump_GetCycles:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L17
	lds r20,Pump_u32Cycles
	lds r21,Pump_u32Cycles+1
	lds r22,Pump_u32Cycles+2
	lds r23,Pump_u32Cycles+3
	movw r30,r24
	st Z,r20
	std Z+1,r21
	std Z+2,r22
	std Z+3,r23
	ldi r24,0
	ldi r25,0
	ret
.L17:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	Pump_GetCycles, .-Pump_GetCycles
	.section	.text.Pump_Update1s,"ax",@progbits
.global	Pump_Update1s
	.type	Pump_Update1s, @function
Pump_Update1s:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Pump_u8State
	cpi r24,lo8(1)
	brne .L19
	lds r24,Pump_u32RunSeconds
	lds r25,Pump_u32RunSeconds+1
	lds r26,Pump_u32RunSeconds+2
	lds r27,Pump_u32RunSeconds+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts Pump_u32RunSeconds,r24
	sts Pump_u32RunSeconds+1,r25
	sts Pump_u32RunSeconds+2,r26
	sts Pump_u32RunSeconds+3,r27
.L19:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	Pump_Update1s, .-Pump_Update1s
	.section	.bss.Pump_u32Cycles,"aw",@nobits
	.type	Pump_u32Cycles, @object
	.size	Pump_u32Cycles, 4
Pump_u32Cycles:
	.zero	4
	.section	.bss.Pump_u32RunSeconds,"aw",@nobits
	.type	Pump_u32RunSeconds, @object
	.size	Pump_u32RunSeconds, 4
Pump_u32RunSeconds:
	.zero	4
	.section	.bss.Pump_u8State,"aw",@nobits
	.type	Pump_u8State, @object
	.size	Pump_u8State, 1
Pump_u8State:
	.zero	1
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
