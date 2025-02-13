package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
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
		bottlesCount, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}
		bottlesSet, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		completeSets := bottlesCount / bottlesSet
		partialSets := bottlesCount % bottlesSet
		fmt.Println(completeSets + partialSets)
	}
}
