.data
    # Strings para simular a interface da Apollo (DSKY)
    prompt_alt: .asciiz "Digite a Altitude atual (metros): "
    prompt_vel: .asciiz "Digite a Velocidade atual (m/s): "
    
    msg_alarme: .asciiz "\n[!] ALARME 1202: SOBRECARGA - ABORTAR POUSO! [!]\n"
    msg_burn:   .asciiz "\n[*] BURN_BABY_BURN: Foguetes de frenagem acionados! [*]\n"
    msg_pouso:  .asciiz "\n[+] VELOCIDADE IDEAL: Pouso seguro em andamento. [+]\n"

.text
.globl main
main:
    # ---------------------------------------------------------
    # PASSO 1: LEITURA DE DADOS
    # (Dica: Syscall 4 imprime string, Syscall 5 l� inteiro)
    # ---------------------------------------------------------
    
    # [ESCREVA AQUI: Imprimir prompt_alt e ler Altitude para $t0]
   
    
    # [ESCREVA AQUI: Imprimir prompt_vel e ler Velocidade para $t1]
    

    # ---------------------------------------------------------
    # PASSO 2: L�GICA DO ALARME 1202 (if Altitude < 5000 AND Velocidade > 1000)
    # ---------------------------------------------------------
    
    # [ESCREVA AQUI: L�gica de desvio. Se a condi��o for verdadeira, pule para a label 'Abortar']
    

    # ---------------------------------------------------------
    # PASSO 3: L�GICA BURN_BABY_BURN (if Velocidade > 100)
    # ---------------------------------------------------------
    
    # [ESCREVA AQUI: Se velocidade > 100 pular para 'Frenagem', sen�o pular para 'Pouso_Seguro']
    

# =========================================================
# LABELS DE EXECU��O (Caminhos do programa)
# =========================================================

Abortar:
    # [ESCREVA AQUI: Imprima msg_alarme e pule para Fim]

Frenagem:
    # [ESCREVA AQUI: Imprima msg_burn e pule para Fim]

Pouso_Seguro:
    # [ESCREVA AQUI: Imprima msg_pouso e deixe o programa continuar para Fim]

Fim:
    # Encerra o simulador
    li $v0, 10
    syscall
