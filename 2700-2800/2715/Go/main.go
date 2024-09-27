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

func FindBestMiddleCutDifference(elements []int) int {
	elementsCount := len(elements)
	left := 0
	for i := 0; i < elementsCount; i++ {
		left += elements[i]
	}
	min := left
	right := 0
	for i := elementsCount - 1; i >= 0; i-- {
		diff := 0
		if left > right {
			diff = left - right
		} else {
			diff = right - left
		}
		if diff < min {
			min = diff
		}
		right += elements[i]
		left -= elements[i]
	}
	return min
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		elementsCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		elements, err := NextInts(scanner, elementsCount)
		if err != nil {
			panic(err)
		}

		fmt.Println(FindBestMiddleCutDifference(elements))
	}
}
