# -*- coding: utf-8 -*-


class Contamination:
    DIRS = [(-1, 0), (0, -1), (1, 0), (0, 1)]

    def __init__(self, terrain, n, m):
        self.terrain = terrain
        self.verified = [[False] * m for _ in range(n)]
        self.n = n
        self.m = m

    def contamine(self, x, y):
        if x >= 0 and y >= 0 and x < self.n and y < self.m:
            if not self.verified[x][y]:
                self.verified[x][y] = True

                if self.terrain[x][y] == "A":
                    self.terrain[x][y] = "T"
                if self.terrain[x][y] != "X":
                    for i, j in self.DIRS:
                        self.contamine(x + i, y + j)

    def contamination(self):
        for row in range(self.n):
            for col in range(self.m):
                if self.terrain[row][col] == "T":
                    self.contamine(row, col)


while True:
    n, m = tuple(map(int, input().split(" ")))

    if n == 0 and m == 0:
        break

    terrain = [list(input()) for _ in range(n)]
    c = Contamination(terrain, n, m)
    c.contamination()

    for row in c.terrain:
        print(*row, sep="")
    print()
