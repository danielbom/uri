package main

import (
	"bufio"
	"fmt"
	"os"
)

func NextLine(scanner *bufio.Scanner) (string, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return "", err
	}
	text := scanner.Text()
	return text, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	line1, err := NextLine(scanner)
	if err != nil {
		panic(err)
	}
	line2, err := NextLine(scanner)
	if err != nil {
		panic(err)
	}
	line3, err := NextLine(scanner)
	if err != nil {
		panic(err)
	}

	fmt.Printf("%s%s%s\n", line1, line2, line3)
	fmt.Printf("%s%s%s\n", line2, line3, line1)
	fmt.Printf("%s%s%s\n", line3, line1, line2)
	fmt.Printf("%.10s%.10s%.10s\n", line1, line2, line3)
}
