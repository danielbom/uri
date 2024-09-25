package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return "", err
	}
	text := scanner.Text()
	if text == "" {
		return text, fmt.Errorf("empty scanner")
	}
	return text, nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
	text, err := NextWord(scanner)
	if err != nil {
		return 0, err
	}
	return strconv.Atoi(text)
}

func NextInts(scanner *bufio.Scanner, n int) ([]int, error) {
	xs := make([]int, n)
	for i := 0; i < n; i++ {
		x, err := NextInt(scanner)
		if err != nil {
			return nil, err
		}
		xs[i] = x
	}
	return xs, nil
}

func IsPrime(x int) bool {
	if x < 2 {
		return false
	}
	if x < 4 {
		return true
	}
	if x%2 == 0 {
		return false
	}

	for f := 3; f*f <= x; f += 2 {
		if x%f == 0 {
			return false
		}
	}
	return true
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		coinsCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		coins, err := NextInts(scanner, coinsCount)
		if err != nil {
			panic(err)
		}

		jump, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		sum := 0
		for i := coinsCount - 1; i >= 0; i -= jump {
			sum += coins[i]
		}

		if IsPrime(sum) {
			fmt.Println("You’re a coastal aircraft, Robbie, a large silver aircraft.")
		} else {
			fmt.Println("Bad boy! I’ll hit you.")
		}
	}
}
