# -*- coding: utf-8 -*-
# https://www.urionlinejudge.com.br/judge/en/problems/view/1020

total_days = int(input())

years = total_days // 365
rest = total_days % 365
months = rest // 30
days = rest % 30

print(f"{years} ano(s)")
print(f"{months} mes(es)")
print(f"{days} dia(s)")
