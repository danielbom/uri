# -*- coding: utf-8 -*-

def sum_of(n):
    return (n * (n + 1)) // 2


x, *ys = map(int, input().split(' '))
y = next(y for y in ys if y > 0)
print(sum_of(y + x - 1) - sum_of(x - 1))
