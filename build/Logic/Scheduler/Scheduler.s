	.file	"Scheduler.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.section	.text.SCHEDULER_Init,"ax",@progbits
.global	SCHEDULER_Init
	.type	SCHEDULER_Init, @function
SCHEDULER_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(Scheduler_Tasks)
	ldi r31,hi8(Scheduler_Tasks)
.L2:
	st Z,__zero_reg__
	std Z+1,__zero_reg__
	std Z+2,__zero_reg__
	std Z+3,__zero_reg__
	std Z+4,__zero_reg__
	std Z+5,__zero_reg__
	std Z+6,__zero_reg__
	std Z+7,__zero_reg__
	std Z+8,__zero_reg__
	std Z+9,__zero_reg__
	std Z+10,__zero_reg__
	adiw r30,12
	ldi r24,hi8(Scheduler_Tasks+96)
	cpi r30,lo8(Scheduler_Tasks+96)
	cpc r31,r24
	brne .L2
	ldi r24,lo8(1)
	sts Scheduler_Initialized,r24
	ldi r24,0
	ldi r25,0
/* epilogue start */
	ret
	.size	SCHEDULER_Init, .-SCHEDULER_Init
	.section	.text.SCHEDULER_AddTask,"ax",@progbits
.global	SCHEDULER_AddTask
	.type	SCHEDULER_AddTask, @function
SCHEDULER_AddTask:
	push r12
	push r13
	push r14
	push r15
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r28,r24
	movw r12,r20
	movw r14,r22
	lds r24,Scheduler_Initialized
	cp r24, __zero_reg__
	breq .L11
	sbiw r28,0
	breq .L11
	ldi r24,10
	cp r12,r24
	cpc r13,__zero_reg__
	cpc r14,__zero_reg__
	cpc r15,__zero_reg__
	brlo .L11
	movw r22,r20
	movw r24,r14
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	call __udivmodsi4
	or r22,r23
	or r22,r24
	or r22,r25
	brne .L11
	ldi r30,lo8(Scheduler_Tasks)
	ldi r31,hi8(Scheduler_Tasks)
	ldi r24,0
	ldi r25,0
.L7:
	ldd r18,Z+10
	cpse r18,__zero_reg__
	rjmp .L6
	ldi r18,lo8(12)
	mul r18,r24
	movw r30,r0
	mul r18,r25
	add r31,r0
	clr __zero_reg__
	subi r30,lo8(-(Scheduler_Tasks))
	sbci r31,hi8(-(Scheduler_Tasks))
	st Z,r28
	std Z+1,r29
	std Z+2,r12
	std Z+3,r13
	std Z+4,r14
	std Z+5,r15
	std Z+6,r12
	std Z+7,r13
	std Z+8,r14
	std Z+9,r15
	std Z+11,__zero_reg__
	ldi r24,lo8(1)
	std Z+10,r24
	ldi r24,0
	ldi r25,0
.L4:
/* epilogue start */
	pop r29
	pop r28
	pop r15
	pop r14
	pop r13
	pop r12
	ret
.L6:
	adiw r24,1
	adiw r30,12
	cpi r24,8
	cpc r25,__zero_reg__
	brne .L7
.L11:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L4
	.size	SCHEDULER_AddTask, .-SCHEDULER_AddTask
	.section	.text.SCHEDULER_Tick,"ax",@progbits
.global	SCHEDULER_Tick
	.type	SCHEDULER_Tick, @function
SCHEDULER_Tick:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,Scheduler_Initialized
	cp r24, __zero_reg__
	breq .L13
	ldi r30,lo8(Scheduler_Tasks)
	ldi r31,hi8(Scheduler_Tasks)
	ldi r18,lo8(1)
.L19:
	ldd r24,Z+10
	cpi r24,lo8(1)
	brne .L16
	ldd r24,Z+6
	ldd r25,Z+7
	ldd r26,Z+8
	ldd r27,Z+9
	cpi r24,10
	cpc r25,__zero_reg__
	cpc r26,__zero_reg__
	cpc r27,__zero_reg__
	brlo .L17
	sbiw r24,10
	sbc r26,__zero_reg__
	sbc r27,__zero_reg__
	std Z+6,r24
	std Z+7,r25
	std Z+8,r26
	std Z+9,r27
.L17:
	or r24,r25
	or r24,r26
	or r24,r27
	brne .L16
	ldd r24,Z+2
	ldd r25,Z+3
	ldd r26,Z+4
	ldd r27,Z+5
	std Z+6,r24
	std Z+7,r25
	std Z+8,r26
	std Z+9,r27
	std Z+11,r18
.L16:
	adiw r30,12
	ldi r24,hi8(Scheduler_Tasks+96)
	cpi r30,lo8(Scheduler_Tasks+96)
	cpc r31,r24
	brne .L19
.L13:
/* epilogue start */
	ret
	.size	SCHEDULER_Tick, .-SCHEDULER_Tick
	.section	.text.SCHEDULER_Run,"ax",@progbits
.global	SCHEDULER_Run
	.type	SCHEDULER_Run, @function
SCHEDULER_Run:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r24,Scheduler_Initialized
	cp r24, __zero_reg__
	breq .L22
	ldi r28,lo8(Scheduler_Tasks)
	ldi r29,hi8(Scheduler_Tasks)
.L25:
	ldd r24,Y+10
	cpi r24,lo8(1)
	brne .L24
	ldd r24,Y+11
	cpi r24,lo8(1)
	brne .L24
	std Y+11,__zero_reg__
	ld r30,Y
	ldd r31,Y+1
	icall
.L24:
	adiw r28,12
	ldi r24,hi8(Scheduler_Tasks+96)
	cpi r28,lo8(Scheduler_Tasks+96)
	cpc r29,r24
	brne .L25
.L22:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	SCHEDULER_Run, .-SCHEDULER_Run
	.section	.bss.Scheduler_Initialized,"aw",@nobits
	.type	Scheduler_Initialized, @object
	.size	Scheduler_Initialized, 1
Scheduler_Initialized:
	.zero	1
	.section	.bss.Scheduler_Tasks,"aw",@nobits
	.type	Scheduler_Tasks, @object
	.size	Scheduler_Tasks, 96
Scheduler_Tasks:
	.zero	96
	.ident	"GCC: (GNU) 15.2.0"
.global __do_clear_bss
