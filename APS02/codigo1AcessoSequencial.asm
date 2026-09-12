
# Programa 1: Acesso sequencial � mem�ria
.data
array:  .space 400         # 100 palavras (400 bytes)

.text
.globl main

main:
    li $t0, 0              # �ndice = 0
    la $t1, array          # endere�o base do array
    li $t2, 100            # n�mero de elementos

loop_seq:
    lw $t3, 0($t1)         # leitura do array[i]
    addi $t1, $t1, 4       # avan�a para o pr�ximo elemento
    addi $t0, $t0, 1
    blt $t0, $t2, loop_seq

    li $v0, 10
    syscall
