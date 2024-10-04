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

func NextIntOrFail(scanner *bufio.Scanner) int {
	value, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	return value
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	roomWidth := NextIntOrFail(scanner)
	roomLength := NextIntOrFail(scanner)

	tiles1Count := roomWidth*roomLength + (roomWidth-1)*(roomLength-1)
	fmt.Println(tiles1Count)

	tiles2Count := 2 * (roomWidth - 1 + roomLength - 1)
	fmt.Println(tiles2Count)
}
