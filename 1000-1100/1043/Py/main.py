# -*- coding: utf-8 -*-

def _valid(x, y, z):
    return abs(x - y) < z < x + y


def is_valid_triangle(x, y, z):
    return _valid(x, y, z) and _valid(y, z, x) and (z, x, y)


def triangle_perimeter(x, y, z):
    return x + y + z


def trapezium_area(x, y, z):
    return ((x + y) * z) / 2


x, y, z = map(float, input().split(' '))

if is_valid_triangle(x, y, z):
    print("Perimetro = %.1f" % triangle_perimeter(x, y ,z))
else:
    print("Area = %.1f" % trapezium_area(x, y ,z))
