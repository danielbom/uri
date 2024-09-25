package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
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

func ReadInts(scanner *bufio.Scanner, n int) ([]int, error) {
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

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	k, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	xs, err := ReadInts(scanner, n)
	if err != nil {
		panic(err)
	}

	sort.IntSlice(xs).Sort()

	for k < n && xs[n-k-1] == xs[n-k] {
		k++
	}

	fmt.Println(k)
}
