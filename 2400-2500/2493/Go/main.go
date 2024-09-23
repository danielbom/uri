package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func ReadLine(reader *bufio.Reader) string {
	line, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return strings.TrimSpace(line)
}

type Expr struct {
	X int
	Y int
	Z int
}

func ReadLineAsExpr(reader *bufio.Reader) Expr {
	var x, y, z int
	line := ReadLine(reader)
	n, err := fmt.Sscanf(line, "%d %d=%d", &x, &y, &z)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	if n != 3 {
		fmt.Println("invalid Expr format")
		os.Exit(1)
	}
	return Expr{X: x, Y: y, Z: z}
}

func (e *Expr) IsOp(op string) bool {
	if op == "+" {
		return e.X+e.Y == e.Z
	} else if op == "-" {
		return e.X-e.Y == e.Z
	} else if op == "*" {
		return e.X*e.Y == e.Z
	} else if op == "I" {
		return !e.IsOp("+") && !e.IsOp("-") && !e.IsOp("*")
	} else {
		return false
	}
}

type Answer struct {
	Player string
	Ix     int
	Op     string
}

func (a *Answer) IsCorrect(exprs []Expr) bool {
	return exprs[a.Ix].IsOp(a.Op)
}

func ReadLineAsAnswer(reader *bufio.Reader) Answer {
	var player, op string
	var index int
	line := ReadLine(reader)
	n, err := fmt.Sscanf(line, "%s %d %s", &player, &index, &op)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	if n != 3 {
		fmt.Println("invalid Operation format")
		os.Exit(1)
	}
	if op != "+" && op != "-" && op != "*" && op != "I" {
		fmt.Println("invalid Operation format")
		os.Exit(1)
	}
	return Answer{Player: player, Ix: index - 1, Op: op}
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	for {
		line, err := reader.ReadString('\n')
		if err != nil {
			break
		}
		n, err := strconv.Atoi(strings.TrimSpace(line))
		if err != nil {
			break
		}

		exprs := make([]Expr, n)
		wrongPlayers := make([]string, 0)

		for i := 0; i < n; i++ {
			exprs[i] = ReadLineAsExpr(reader)
		}

		for i := 0; i < n; i++ {
			answer := ReadLineAsAnswer(reader)
			if !answer.IsCorrect(exprs) {
				wrongPlayers = append(wrongPlayers, answer.Player)
			}
		}

		if len(wrongPlayers) == 0 {
			fmt.Println("You Shall All Pass!")
		} else if len(wrongPlayers) == n {
			fmt.Println("None Shall Pass!")
		} else {
			sort.StringSlice(wrongPlayers).Sort()
			for ix, p := range wrongPlayers {
				if ix != 0 {
					fmt.Print(" ")
				}
				fmt.Print(p)
			}
			fmt.Println()
		}
	}
}
