def tz_diff(xs, i, j):
    d = abs(xs[i] - xs[j])
    return min(d, 24 - d)

n = int(input())
xs = sorted([int(x) for x in input().split(' ')])

s1 = s2 = 0
for i in range(0, n, 2):
    s1 += tz_diff(xs, i, i+1)
    s2 += tz_diff(xs, i, (i-1+n)%n)

print(min(s1, s2))

