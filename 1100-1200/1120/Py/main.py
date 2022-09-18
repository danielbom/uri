while True:
    line = input()
    if line == "0 0":
        break

    d, number = line.split(" ")
    typed_number = "".join(ch for ch in number if ch != d)

    if typed_number == "":
        print(0)
    else:
        print(int(typed_number))
