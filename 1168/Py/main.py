# -*- coding: utf-8 -*-

n = int(input())

digits_led = {
    "0": 6,
    "1": 2,
    "2": 5,
    "3": 5,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 3,
    "8": 7,
    "9": 6,
}

def count_leds(digits):
    return sum(digits_led[d] for d in digits)

for _ in range(n):
    digits = input()
    leds = count_leds(digits)
    print(f"{leds} leds")
