times = int(input())

while times > 0:
    [player1, play1, player2, play2] = input().split()
    [number1, number2] = [int(it) for it in input().split()]
    winner_play = "PAR" if (number1 + number2) % 2 == 0 else "IMPAR"
    print(player1 if winner_play == play1 else player2)
    times -= 1
