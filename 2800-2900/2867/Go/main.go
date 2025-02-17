package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"math"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing element")
	}
	return strconv.Atoi(scanner.Text())
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < n; i++ {
		x, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}
		y, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		exponent := float64(y)
		base := float64(x)
		digits := int(math.Floor(exponent*math.Log10(base)) + 1)
		fmt.Println(digits)
	}
}
