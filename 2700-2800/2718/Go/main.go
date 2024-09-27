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

func LargestSequenceOf1s(x int) int {
	max := 0
	count := 0
	for i := 1; i <= x; i <<= 1 {
		if x&i > 0 {
			count++
		} else {
			count = 0
		}
		if count > max {
			max = count
		}
	}
	return max
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	groupsCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < groupsCount; i++ {
		groupNumber, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		fmt.Println(LargestSequenceOf1s(groupNumber))
	}
}
