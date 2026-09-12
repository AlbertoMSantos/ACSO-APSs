# Programa 2: Acesso com salto de 16 bytes
.data
array:  .space 400


.text
.globl main

main:
    li $t0, 0
    la $t1, array
    li $t2, 50              # 25 acessos (stride = 16 bytes)
loop_stride:
    lw $t3, 0($t1)
    addi $t1, $t1, 16       # avan�a 16 bytes por vez
    addi $t0, $t0, 1
    blt $t0, $t2, loop_stride

    li $v0, 10
    syscall
