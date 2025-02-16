package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextStringFloat(scanner *bufio.Scanner) (string, float64, error) {
	if !scanner.Scan() {
		return "", 0.0, fmt.Errorf("missing float")
	}
	text := scanner.Text()
	result, err := strconv.ParseFloat(text, 64)
	return text, result, err
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for scanner.Scan() {
		n, err := strconv.Atoi(scanner.Text())
		if err != nil {
			panic(err)
		}

		minText := ""
		min := 0.0
		for i := 0; i < n; i++ {
			numberStr, number, err := NextStringFloat(scanner)
			if err != nil { panic(err) }
			if len(minText) == 0 || min > number {
				minText = numberStr
				min = number
			}
		}
		fmt.Println(minText)
	}
}
