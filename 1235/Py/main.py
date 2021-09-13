# -*- coding: utf-8 -*-
n = int(input())

for _ in range(n):
    line = input()
    n = len(line)
    m = n // 2
    line = line[::-1]
    print(line[m:] + line[:m])
