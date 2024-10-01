package main

import (
	"bufio"
	"fmt"
	"os"
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

func NextByte(scanner *bufio.Scanner) (byte, error) {
	word, err := NextWord(scanner)
	if err != nil {
		return ' ', err
	}
	if len(word) != 1 {
		return ' ', fmt.Errorf("invalid rune")
	}
	return word[0], nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	a, err := NextByte(scanner)
	if err != nil {
		panic(err)
	}
	b, err := NextByte(scanner)
	if err != nil {
		panic(err)
	}
	c, err := NextByte(scanner)
	if err != nil {
		panic(err)
	}

	fmt.Printf("A = %c, B = %c, C = %c\n", a, b, c)
	fmt.Printf("A = %c, B = %c, C = %c\n", b, c, a)
	fmt.Printf("A = %c, B = %c, C = %c\n", c, a, b)
}
