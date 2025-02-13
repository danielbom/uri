package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing element")
	}
	return strconv.Atoi(scanner.Text())
}

func NextPair(scanner *bufio.Scanner) (int, int, error) {
	if !scanner.Scan() {
		return 0, 0, fmt.Errorf("invalid pair: missing first element")
	}
	fst, err := strconv.Atoi(scanner.Text())
	if err != nil {
		return 0, 0, fmt.Errorf("invalid pair: invalid first element")
	}
	if !scanner.Scan() {
		return 0, 0, fmt.Errorf("invalid pair: missing second element")
	}
	snd, err := strconv.Atoi(scanner.Text())
	if err != nil {
		return 0, 0, fmt.Errorf("invalid pair: invalid second element")
	}
	return fst, snd, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	sum := 0.0
	for i := 0; i < n; i++ {
		a, b, err := NextPair(scanner)
		if err != nil {
			panic(err)
		}

		sum += float64(a) / float64(b)
	}

	if sum > 1.0 {
		fmt.Println("FAIL")
	} else {
		fmt.Println("OK")
	}
}
