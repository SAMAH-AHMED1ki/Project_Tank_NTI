	.file	"Pump.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.PMP_Init,"ax",@progbits
.global	PMP_Init
	.type	PMP_Init, @function
PMP_Init:
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
	sts Pump_u32TotalSeconds,__zero_reg__
	sts Pump_u32TotalSeconds+1,__zero_reg__
	sts Pump_u32TotalSeconds+2,__zero_reg__
	sts Pump_u32TotalSeconds+3,__zero_reg__
	sts Pump_u32Cycles,__zero_reg__
	sts Pump_u32Cycles+1,__zero_reg__
	sts Pump_u32Cycles+2,__zero_reg__
	sts Pump_u32Cycles+3,__zero_reg__
.L1:
/* epilogue start */
	ret
	.size	PMP_Init, .-PMP_Init
	.section	.text.PMP_Set,"ax",@progbits
.global	PMP_Set
	.type	PMP_Set, @function
PMP_Set:
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
	cpi r18,lo8(1)
	brsh .L7
	cpi r28,lo8(1)
	brne .L8
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
.L8:
	sts Pump_u8State,r28
.L5:
/* epilogue start */
	pop r28
	ret
.L7:
	brne .L8
	cpse r28,__zero_reg__
	rjmp .L8
	sts Pump_u32RunSeconds,__zero_reg__
	sts Pump_u32RunSeconds+1,__zero_reg__
	sts Pump_u32RunSeconds+2,__zero_reg__
	sts Pump_u32RunSeconds+3,__zero_reg__
	rjmp .L8
	.size	PMP_Set, .-PMP_Set
	.section	.text.PMP_GetState,"ax",@progbits
.global	PMP_GetState
	.type	PMP_GetState, @function
PMP_GetState:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L12
	lds r18,Pump_u8State
	movw r30,r24
	st Z,r18
	ldi r24,0
	ldi r25,0
	ret
.L12:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	PMP_GetState, .-PMP_GetState
	.section	.text.PMP_RunSeconds,"ax",@progbits
.global	PMP_RunSeconds
	.type	PMP_RunSeconds, @function
PMP_RunSeconds:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L15
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
.L15:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	PMP_RunSeconds, .-PMP_RunSeconds
	.section	.text.PMP_TotalSeconds,"ax",@progbits
.global	PMP_TotalSeconds
	.type	PMP_TotalSeconds, @function
PMP_TotalSeconds:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L18
	lds r20,Pump_u32TotalSeconds
	lds r21,Pump_u32TotalSeconds+1
	lds r22,Pump_u32TotalSeconds+2
	lds r23,Pump_u32TotalSeconds+3
	movw r30,r24
	st Z,r20
	std Z+1,r21
	std Z+2,r22
	std Z+3,r23
	ldi r24,0
	ldi r25,0
	ret
.L18:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	PMP_TotalSeconds, .-PMP_TotalSeconds
	.section	.text.PMP_Cycles,"ax",@progbits
.global	PMP_Cycles
	.type	PMP_Cycles, @function
PMP_Cycles:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,0
	breq .L21
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
.L21:
	ldi r24,lo8(1)
	ldi r25,0
/* epilogue start */
	ret
	.size	PMP_Cycles, .-PMP_Cycles
	.section	.text.PMP_Update1s,"ax",@progbits
.global	PMP_Update1s
	.type	PMP_Update1s, @function
PMP_Update1s:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Pump_u8State
	cpi r24,lo8(1)
	brne .L23
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
	lds r24,Pump_u32TotalSeconds
	lds r25,Pump_u32TotalSeconds+1
	lds r26,Pump_u32TotalSeconds+2
	lds r27,Pump_u32TotalSeconds+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts Pump_u32TotalSeconds,r24
	sts Pump_u32TotalSeconds+1,r25
	sts Pump_u32TotalSeconds+2,r26
	sts Pump_u32TotalSeconds+3,r27
.L23:
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	PMP_Update1s, .-PMP_Update1s
	.section	.bss.Pump_u32Cycles,"aw",@nobits
	.type	Pump_u32Cycles, @object
	.size	Pump_u32Cycles, 4
Pump_u32Cycles:
	.zero	4
	.section	.bss.Pump_u32TotalSeconds,"aw",@nobits
	.type	Pump_u32TotalSeconds, @object
	.size	Pump_u32TotalSeconds, 4
Pump_u32TotalSeconds:
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
