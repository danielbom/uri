# -*- coding: utf-8 -*-

def sum_of(n):
    return (n * (n + 1)) // 2


x, y = map(int, input().split(' '))
print(sum_of(y) - sum_of(x - 1))
