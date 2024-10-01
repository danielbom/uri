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

func NextFloat32(scanner *bufio.Scanner) (float32, error) {
	text, err := NextWord(scanner)
	if err != nil {
		return 0, err
	}
	number, err := strconv.ParseFloat(text, 32)
	return float32(number), err
}

func NextFloat64(scanner *bufio.Scanner) (float64, error) {
	text, err := NextWord(scanner)
	if err != nil {
		return 0, err
	}
	return strconv.ParseFloat(text, 64)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	a, err := NextFloat32(scanner)
	if err != nil {
		panic(err)
	}
	b, err := NextFloat32(scanner)
	if err != nil {
		panic(err)
	}
	c, err := NextFloat64(scanner)
	if err != nil {
		panic(err)
	}
	d, err := NextFloat64(scanner)
	if err != nil {
		panic(err)
	}

	fmt.Printf("A = %f, B = %f\n", a, b)
	fmt.Printf("C = %f, D = %f\n", c, d)
	fmt.Printf("A = %.1f, B = %.1f\n", a, b)
	fmt.Printf("C = %.1f, D = %.1f\n", c, d)
	fmt.Printf("A = %.2f, B = %.2f\n", a, b)
	fmt.Printf("C = %.2f, D = %.2f\n", c, d)
	fmt.Printf("A = %.3f, B = %.3f\n", a, b)
	fmt.Printf("C = %.3f, D = %.3f\n", c, d)
	fmt.Printf("A = %.3E, B = %.3E\n", a, b)
	fmt.Printf("C = %.3E, D = %.3E\n", c, d)
	fmt.Printf("A = %.0f, B = %.0f\n", a, b)
	fmt.Printf("C = %.0f, D = %.0f\n", c, d)
}
