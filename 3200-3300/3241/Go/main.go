package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func NextLine(scanner *bufio.Scanner) (string, error) {
	if !scanner.Scan() {
		return "", fmt.Errorf("missing element")
	}
	return scanner.Text(), nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing element")
	}
	return strconv.Atoi(scanner.Text())
}

func Solve(problem string) (int, error) {
	a, b, found := strings.Cut(problem, "+")
	if !found {
		return 0, fmt.Errorf("missing operator '+'")
	}
	x, err := strconv.Atoi(a)
	if err != nil {
		return 0, fmt.Errorf("invalid left hand side: %v", err)
	}
	y, err := strconv.Atoi(b)
	if err != nil {
		return 0, fmt.Errorf("invalid right hand side: %v", err)
	}
	return x + y, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < n; i++ {
		problem, err := NextLine(scanner)
		if err != nil {
			panic(err)
		}

		if problem == "P=NP" {
			fmt.Println("skipped")
		} else {
			result, err := Solve(problem)
			if err != nil {
				panic(err)
			}
			fmt.Println(result)
		}
	}
}
