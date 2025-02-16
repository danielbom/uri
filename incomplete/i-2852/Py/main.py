def putc(c):
    print(c, end='')


keyword = input()
message_count = int(input())
n = len(keyword)
a, z = ord('a'), ord('z')
for _ in range(message_count):
    message = input().strip()
    m = len(message)
    i = 0
    j = 0
    while i < m:
        if message[i] == ' ':
            putc(' ')
            while i < m and message[i] == ' ':
                i += 1
        elif message[i] in "aeiou":
            while i < m and message[i] != ' ':
                putc(message[i])
                i += 1
        else:
            while i < m and message[i] != ' ':
                ix = (ord(message[i])+ord(keyword[j]) - 2*a) % (z-a+1)+a
                putc(chr(ix))
                j = (j + 1) % n
                i += 1
    print()
