from collections import deque
import math

def input_ints():
    return map(int, input().split(' '))

# Primeira linha
# n: [2..1e4]       Valor limitante
# m: [n-1..1e5]     Linhas de ruas
# t: [1..15]        Linhas de turistas

# Linha de ruas | 'a != 'b
# a: [1..n] Ponto 'a
# b: [1..n] Ponto 'b
# c: Comprimento entre 'a e 'b


n, m, t = map(int, input().split(' '))

# Contrução do grafo de comprimento de ruas
street_graph = {} # Matriz NxN
for _ in range(m):
    a, b, c = input_ints()
    
    # Normalizando valores de a' e b' para indexação na matriz
    a -= 1
    b -= 1

    if street_graph.get(a) is None:
        street_graph[a] = {}
    if street_graph.get(b) is None:
        street_graph[b] = {}

    # Atribuição bidirectional ao grafo
    street_graph[a][b] = c
    street_graph[b][a] = c


# Floyd wharshall

distances = []
for i in range(n):
    distances.append([])
    for j in range(n):
        c = street_graph.get(i, {}).get(j, 0)
        if c == 0 and i != j:
            distances[-1].append(math.inf)
        else:
            distances[-1].append(c)


for k in range(n):
    for i in range(n):
        for j in range(n):
            distance_sum = distances[i][k] + distances[k][j]
            if distances[i][j] > distance_sum:
                distances[i][j] = distance_sum

turists = {} 

for i in range(t):
    o, d = input_ints()

    # Normalizando valores de o' e d' para indexação na matriz
    o -= 1
    d -= 1

    if turists.get(o) is None:
        turists[o] = deque()
    
    turists[o].append(d)

current_position = 0
total_distance = 0

while turists:
    if current_position in turists:
        d = turists[current_position].pop()
        if not turists[current_position]:
            del turists[current_position]

        total_distance += distances[current_position][d]
        current_position = d
    else:
        min_turist = None
        min_distance = math.inf
        for o in turists:
            d = distances[current_position][o]
            if d < min_distance:
                min_distance = d
                min_turist = o

        total_distance += min_distance
        current_position = min_turist


total_distance += distances[current_position][0]


print(total_distance)

