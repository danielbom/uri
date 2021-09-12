# -*- coding: utf-8 -*-
import sys

def check_graph(n, graph):
    count = 0

    i = 0
    while graph.get(i) is not None:
        j = i
        i = graph[i]
        del graph[j]
        count += 1

    return count == n

n = int(input())
graph = {}
invalid = False
for line in sys.stdin:
    x, y = map(int, line.split(" "))
    x -= 1
    y -= 1
    if not invalid:
        invalid = bool(graph.get(x))
        graph[x] = y

print('S' if not invalid and check_graph(n, graph) else 'N')
