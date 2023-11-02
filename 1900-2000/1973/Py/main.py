def star_trek(stars):
    stars_result = list(stars)

    i = 0
    while True:
        if not 0 <= i < len(stars_result):
            break
        x = stars_result[i]
        if x == 0:
            break
        stars_result[i] = x - 1
        if x % 2 == 0: # even
            i -= 1
        else:
            i += 1

    return stars_result


_ = input()
stars = [int(it) for it in input().split(' ')]
stars_result = star_trek(stars)
stars_attacked = sum(1 if x != y else 0 for x, y in zip(stars, stars_result))
non_stolen_sheeps = sum(stars_result)
print("{} {}".format(stars_attacked, non_stolen_sheeps))
