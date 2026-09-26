	# Integrantes da equipe:
# Alberto Marques dos Santos (ams18)
# Miguel Pereira de Lemos (mpl4)
# Gustavo Nascimento de Oliveira (gno)

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
    # ---------------------------------------------------------
    
    # Imprimir prompt_alt
    li $v0, 4               # Syscall 4: Imprimir string
    la $a0, prompt_alt      # Carrega o endereço da string
    syscall
    
    # Ler Altitude para $t0
    li $v0, 5               # Syscall 5: Ler inteiro
    syscall
    move $t0, $v0           # Salva o valor lido em $t0

    # Imprimir prompt_vel
    li $v0, 4               # Syscall 4: Imprimir string
    la $a0, prompt_vel      # Carrega o endereço da string
    syscall
    
    # Ler Velocidade para $t1
    li $v0, 5               # Syscall 5: Ler inteiro
    syscall
    move $t1, $v0           # Salva o valor lido em $t1

    # ---------------------------------------------------------
    # PASSO 2: LÓGICA DO ALARME 1202 (if Altitude < 5000 AND Velocidade > 1000)
    # ---------------------------------------------------------
    
    # Para simular o AND em Assembly, usamos a "Lógica Invertida". 
    # Se qualquer uma das condições falhar, pulamos para o próximo passo.
    bge $t0, 5000, Check_Burn   # Se Altitude >= 5000, tá seguro dessa falha, vai pro Passo 3
    ble $t1, 1000, Check_Burn   # Se Velocidade <= 1000, tá seguro dessa falha, vai pro Passo 3
    
    # Se não pulou nas linhas acima, é porque Alt < 5000 E Vel > 1000.
    j Abortar                   # Então, pula para o Alarme 1202

Check_Burn:
    # ---------------------------------------------------------
    # PASSO 3: LÓGICA BURN_BABY_BURN (if Velocidade > 100)
    # ---------------------------------------------------------
    
    bgt $t1, 100, Frenagem      # Se Velocidade > 100 pular para 'Frenagem'
    j Pouso_Seguro              # Senão (menor ou igual a 100), pula para 'Pouso_Seguro'

# =========================================================
# LABELS DE EXECUÇÃO (Caminhos do programa)
# =========================================================

Abortar:
    # Imprima msg_alarme e pule para Fim
    li $v0, 4
    la $a0, msg_alarme
    syscall
    j Fim                   # Tranca o fluxo para não rodar os códigos de baixo

Frenagem:
    # Imprima msg_burn e pule para Fim
    li $v0, 4
    la $a0, msg_burn
    syscall
    j Fim                   # Tranca o fluxo para não rodar os códigos de baixo

Pouso_Seguro:
    # Imprima msg_pouso e deixe o programa continuar para Fim
    li $v0, 4
    la $a0, msg_pouso
    syscall
    # Aqui não precisa do "j Fim" pois a próxima linha lida já é naturalmente a label 'Fim'

Fim:
    # Encerra o simulador
    li $v0, 10
    syscall
