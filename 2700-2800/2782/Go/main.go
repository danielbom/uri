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
		return "", fmt.Errorf("empty scanner")
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

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	numbersCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	stepChangesCount := 1
	prevNumber := 0
	prevStep := 0
	for i := 0; i < numbersCount; i++ {
		number, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		step := number - prevNumber
		if i > 1 && step != prevStep {
			stepChangesCount++
		}

		prevStep = step
		prevNumber = number
	}

	fmt.Println(stepChangesCount)
}
