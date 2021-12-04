import random
import sys


# python program_name.py <street_limit> <streets_count> <tourists_count>

street_limit, streets_count, tourists_count = map(lambda x: int(float(x)), sys.argv[1:])

assert 2 <= street_limit <= 1e4, "Invalid range value to 'street_limit'"
assert street_limit - 1 <= streets_count <= 1e5, "Invalid range value to 'streets_count'"
assert 1 <= tourists_count <= 15, "Invalid range value to 'tourists_count'"

print(street_limit, streets_count, tourists_count)

# Generate streets
streets = set()
count = 0
while count < streets_count:
    source = random.randint(1, street_limit)
    destiny = random.randint(1, street_limit)
    if source == destiny:
        continue

    street = (source, destiny)
    if street in streets:
        continue
    streets.add(street)

    distance = random.randint(1, 100)
    print(source, destiny, distance)
    count += 1

# Generate travels
count = 0
while count < tourists_count:
    source = random.randint(1, street_limit)
    destiny = random.randint(1, street_limit)
    if source == destiny:
        continue

    street = (source, destiny)
    if street not in streets:
        continue
    print(source, destiny)
    count += 1
