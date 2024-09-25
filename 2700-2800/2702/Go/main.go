package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return 0, err
	}
	text := scanner.Text()
	if text == "" {
		return 0, fmt.Errorf("empty scanner")
	}
	return strconv.Atoi(text)
}

func NextTiple(scanner *bufio.Scanner) (int, int, int, error) {
	a, err := NextInt(scanner)
	if err != nil {
		return 0, 0, 0, err
	}
	b, err := NextInt(scanner)
	if err != nil {
		return 0, 0, 0, err
	}
	c, err := NextInt(scanner)
	if err != nil {
		return 0, 0, 0, err
	}
	return a, b, c, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	chichenAvailable, beefAvailable, pastaAvailable, err := NextTiple(scanner)
	if err != nil {
		panic(err)
	}
	chichenRequested, beefRequested, pastaRequested, err := NextTiple(scanner)
	if err != nil {
		panic(err)
	}

	missingCount := 0
	if chichenAvailable < chichenRequested {
		missingCount += chichenRequested - chichenAvailable
	}
	if beefAvailable < beefRequested {
		missingCount += beefRequested - beefAvailable
	}
	if pastaAvailable < pastaRequested {
		missingCount += pastaRequested - pastaAvailable
	}

	fmt.Println(missingCount)
}
