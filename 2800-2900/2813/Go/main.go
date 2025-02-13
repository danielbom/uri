package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("invalid integer: missing element")
	}
	return strconv.Atoi(scanner.Text())
}

func NextPair(scanner *bufio.Scanner) (string, string, error) {
	if !scanner.Scan() {
		return "", "", fmt.Errorf("invalid pair: missing first element")
	}
	fst := scanner.Text()
	if !scanner.Scan() {
		return "", "", fmt.Errorf("invalid pair: missing second element")
	}
	snd := scanner.Text()
	return fst, snd, nil
}

func Max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	maxWork := 0
	maxHome := 0
	work := 0
	home := 0

	for i := 0; i < n; i++ {
		forecastHome, forecastWork, err := NextPair(scanner)
		if err != nil {
			panic(err)
		}

		if forecastHome == "chuva" {
			if work > 0 {
				work--
			} else {
				home++
				maxHome = Max(home, maxHome)
			}
		}
		if forecastWork == "chuva" {
			if home > 0 {
				home--
			} else {
				work++
				maxWork = Max(work, maxWork)
			}
		}
	}

	fmt.Printf("%d %d\n", maxHome, maxWork)
}
