import sys

n = int(sys.argv[1] if len(sys.argv) > 1 else input())

lines = []
for _ in range(n):
    lines.append(input().strip().split('\t'))

print()
for i, line in enumerate(lines):
    print('(', end='')
    print(', '.join(f"'{it}'" for it in line), end='')
    print(')', end='')
    print(';' if i == n - 1 else ',')
