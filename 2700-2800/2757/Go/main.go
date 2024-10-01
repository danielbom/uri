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

	n1, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	n2, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	n3, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	fmt.Printf("A = %d, B = %d, C = %d\n", n1, n2, n3)
	fmt.Printf("A = % 10d, B = % 10d, C = % 10d\n", n1, n2, n3)
	fmt.Printf("A = %010d, B = %010d, C = %010d\n", n1, n2, n3)
	fmt.Printf("A = %-10d, B = %-10d, C = %-10d\n", n1, n2, n3)
}
