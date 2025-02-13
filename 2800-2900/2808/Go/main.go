package main

import (
	"bufio"
	"fmt"
	"os"
)

func ReadLinePair(scanner *bufio.Scanner) (string, string, error) {
	if !scanner.Scan() {
		return "", "", fmt.Errorf("invalid pair format")
	}
	fst := scanner.Text()
	if !scanner.Scan() {
		return "", "", fmt.Errorf("invalid pair format")
	}
	snd := scanner.Text()
	return fst, snd, nil
}

type Pos struct {
	X int
	Y int
}

func PosFromStr(posStr string) (Pos, error) {
	var pos Pos
	if len(posStr) == 2 {
		x := posStr[0]
		y := posStr[1]
		if !('a' <= x && x <= 'h') {
			return pos, fmt.Errorf("invalid pos.x")
		}
		if !('1' <= y && y <= '8') {
			return pos, fmt.Errorf("invalid pos.y")
		}
		pos.X = int(x) - int('a')
		pos.Y = int(y) - int('1')
	}
	return pos, nil
}

func (pos Pos) ValidKnightMove(target Pos) bool {
	if pos.X + 1 == target.X || pos.X - 1 == target.X {
		return pos.Y + 2 == target.Y || pos.Y - 2 == target.Y
	}
	if pos.Y + 1 == target.Y || pos.Y - 1 == target.Y {
		return pos.X + 2 == target.X || pos.X - 2 == target.X
	}
	return false
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)
	initialPositionStr, targetPositionStr, err := ReadLinePair(scanner)
	if err != nil {
		panic(err)
	}
	initialPosition, err := PosFromStr(initialPositionStr)
	if err != nil {
		panic(err)
	}
	targetPosition, err := PosFromStr(targetPositionStr)
	if err != nil {
		panic(err)
	}

	if initialPosition.ValidKnightMove(targetPosition) {
		fmt.Println("VALIDO")
	} else {
		fmt.Println("INVALIDO")
	}
}