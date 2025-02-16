package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing integer")
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

	max := 0
	for i := 0; i < n; i++ {
		x, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}
		if max < x {
			max = x
		}
	}
	fmt.Println(max + 1)
}
