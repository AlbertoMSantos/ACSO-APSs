.data
# 5 vari�veis armazenadas em endere�os diferentes
# Observa��o: A e C s�o separadas por 16 bytes -> mesmo �ndice no cache direto
a: .word 10              # endere�o 0x10010000
b: .word 20,30,40        # endere�o 0x10010004
c: .word 50              # endere�o 0x10010010
d: .word 60              # endere�o 0x10010014
e: .word 70               # endere�o 0x10010018

.text
.globl main
main:

    li $t0, 0              # contador do loop (0 a 9)
    li $t1, 10             # n�mero de itera��es 
    la $s0, a
    la $s1, b
    la $s2, c
    la $s3, d    
loop:
    # --- 5 acessos de leitura � mem�ria ---
 
    lw $t2, 0($s0)           # acesso 1: A
    lw $t3, 0($s2)           # acesso 2: C (mesma linha que A -> conflito)
    lw $t4, 0($s0)           # acesso 3: A novamente
    lw $t5, 0($s2)           # acesso 4: C novamente
    lw $t6, 0($s1)           # acesso 5: outro bloco

    addi $t0, $t0, 1       # incrementa contador
    blt $t0, $t1, loop     # repete at� 10 vezes (10�5 = 50 acessos)

    # Finaliza programa
    li $v0, 10
    syscall
