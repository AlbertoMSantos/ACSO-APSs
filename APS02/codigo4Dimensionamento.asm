.data
array: .space 256
.text
.globl main
main:
    li $t0, 0
    la $t1, array
    li $t2, 50
loop_outer:
    li $t3, 0
    la $t4, array
loop_inner:
    lw $t5, 0($t4)
    addi $t4, $t4, 4
    addi $t3, $t3, 1
    blt $t3, 64, loop_inner
    addi $t0, $t0, 1
    blt $t0, $t2, loop_outer
    li $v0, 10
    syscall
