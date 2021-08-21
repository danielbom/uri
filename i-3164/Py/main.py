import math

def read_values(txt):
    return [int(x) for x in txt.split(' ') if x]

if __name__ == "__main__":
    n, q = read_values(input())
    xs = read_values(input())
    xs.sort()

    ks = [j * (n + 1) // 4 for j in range(1, 4)]
    
