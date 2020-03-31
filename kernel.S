.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define A #9
#define B #2
#define C #2

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #5: "

.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line
    
     // calculate 
    mov r5, #1
    mov r1, A
    mov r2, B
    mov r3, C
    mov r4, #3

    lsl r5, r5, r3
    sub r1, r2
    mla r5, r1, r4, r5
        
    ldr r0, =final
    bl dbgput
    mov r0, r5
    bl dbgput_num
    
    end:
    b end
