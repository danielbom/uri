def tz_diff(xs, i, j):
    d = abs(xs[i] - xs[j])
    return min(d, 24 - d)


def solve_greedy(xs, n):
    xs = sorted(xs)
    s1 = s2 = 0
    for i in range(0, n, 2):
        s1 += tz_diff(xs, i, i+1)
        s2 += tz_diff(xs, i, (i-1+n)%n)
    return min(s1, s2)


def solve_heap(xs, n):
    import heapq
    heap = [(0, [])]
    minimum = 99
    while heap:
        ss, pairs = heapq.heappop(heap)
        for i in range(n):
            if i in pairs:
                continue
            for j in range(i+1, n):
                if j in pairs:
                    continue
                new_ss = tz_diff(xs, i, j) + ss
                if len(pairs) + 2 == n:
                    return new_ss
                else:
                    heapq.heappush(heap, (new_ss, pairs + [i,j]))


def solve_recursive(xs, n):
    def go(xs, n, pairs, ss, minimum):
        if len(pairs) == n:
            return min(ss, minimum)
        for i in range(n):
            if i in pairs:
                continue
            for j in range(i+1, n):
                if j in pairs:
                    continue
                new_ss = tz_diff(xs, i, j) + ss
                if new_ss < minimum:
                    minimum = go(xs, n, pairs + [i, j], new_ss, minimum)
        return minimum
    return go(xs, n, [], 0, 99)


n = int(input())
xs = [int(x) for x in input().split(' ')]

#print(solve_greedy(xs, n))
print(solve_heap(xs, n))
#print(solve_recursive(xs, n))
