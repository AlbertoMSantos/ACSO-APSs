import time
import random
import os
import statistics

# Tarefa 1: CPU (Cálculo de Fatoriais)
def tarefa_1_cpu(carga):
    inicio = time.perf_counter()
    resultado = 1
    for i in range(1, carga + 1):
        resultado *= i
    return time.perf_counter() - inicio

# Tarefa 2: Memória (Ordenação de Lista)
def tarefa_2_memoria(carga):
    inicio = time.perf_counter()
    lista = [random.random() for _ in range(carga)]
    lista.sort()
    return time.perf_counter() - inicio

# Tarefa 3: Disco I/O (Escrita e Leitura)
def tarefa_3_disco(carga):
    inicio = time.perf_counter()
    nome_arq = "teste_bench.txt"
    with open(nome_arq, 'w') as f:
        for _ in range(carga):
            f.write("Teste de disco.\n")
    with open(nome_arq, 'r') as f:
        f.readlines()
    if os.path.exists(nome_arq):
        os.remove(nome_arq)
    return time.perf_counter() - inicio

# Tarefa 4: Matemática/CPU (Busca de Números Primos)
def tarefa_4_primos(carga):
    inicio = time.perf_counter()
    primos_encontrados = 0
    # Busca primos de 2 até o valor da 'carga' (ajustado para ser um pouco menor para não demorar muito)
    carga_primos = carga // 10 if carga > 100 else carga 
    for num in range(2, carga_primos + 1):
        eh_primo = True
        for i in range(2, int(num ** 0.5) + 1):
            if num % i == 0:
                eh_primo = False
                break
        if eh_primo:
            primos_encontrados += 1
    return time.perf_counter() - inicio

# Tarefa 5: Recursividade (Fibonacci Recursivo)
def tarefa_5_recursao(carga):
    inicio = time.perf_counter()
    # A recursão de Fibonacci sem memoização cresce de forma exponencial,
    # então a "profundidade" (n) é derivada da carga, e não igual a ela,
    # para manter o tempo de execução em uma faixa razoável.
    n = 20 + (carga // 5000)

    def fibonacci(k):
        if k <= 1:
            return k
        return fibonacci(k - 1) + fibonacci(k - 2)

    fibonacci(n)
    return time.perf_counter() - inicio

def rodar_benchmark(carga):
    t1 = tarefa_1_cpu(carga)
    t2 = tarefa_2_memoria(carga)
    t3 = tarefa_3_disco(carga)
    t4 = tarefa_4_primos(carga)
    t5 = tarefa_5_recursao(carga)
    t_total = t1 + t2 + t3 + t4 + t5
    return t1, t2, t3, t4, t5, t_total

# --- CORPO DO CÓDIGO PRINCIPAL ---
if __name__ == "__main__":
    carga_de_trabalho = 50000 # pode-se aumentar ou diminuir essa carga
    num_execucoes = 10
    
    resultados = {"t1": [], "t2": [], "t3": [], "t4": [], "t5": [], "total": []}
    
    print(f"Iniciando benchmark = {num_execucoes} execuções de {carga_de_trabalho} cargas cada\n")
    
    for i in range(num_execucoes):
        t1, t2, t3, t4, t5, t_total = rodar_benchmark(carga_de_trabalho)
        resultados["t1"].append(t1)
        resultados["t2"].append(t2)
        resultados["t3"].append(t3)
        resultados["t4"].append(t4)
        resultados["t5"].append(t5)
        resultados["total"].append(t_total)
        print(f"Tempo de Execução {i+1:2d}: t1={t1:.4f} | t2={t2:.4f} | t3={t3:.4f} | t4={t4:.4f} | t5={t5:.4f} | total={t_total:.4f}")
        # print(f"Execução {i+1} concluída.")

    # Exibindo resultados finais com 4 casas decimais
    print("\n" + "="*40)
    print("RESULTADOS FINAIS (Média ± Desvio Padrão)")
    print("="*40)
    
    nomes_tarefas = ["1 (Fatorial)", "2 (Memória)", "3 (Disco I/O)", "4 (Primos)", "5 (Recursão - Fibonacci)"]
    chaves = ["t1", "t2", "t3", "t4", "t5"]
    
    for nome, chave in zip(nomes_tarefas, chaves):
        media = statistics.mean(resultados[chave])
        desvio = statistics.stdev(resultados[chave])
        print(f"Tarefa {nome}: {media:.4f} s ± {desvio:.4f} s")
        
    media_total = statistics.mean(resultados["total"])
    desvio_total = statistics.stdev(resultados["total"])
    print("-" * 40)
    print(f"TEMPO TOTAL: {media_total:.4f} s ± {desvio_total:.4f} s")
    print("="*40)