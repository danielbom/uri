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

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	carlosVotes, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	elected := true
	for i := 1; i < n; i++ {
		votes, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		if votes > carlosVotes {
			elected = false
		}
	}

	if elected {
		fmt.Println("S")
	} else {
		fmt.Println("N")
	}
}
