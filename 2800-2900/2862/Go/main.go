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

	for i := 0; i < n; i++ {
		power, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		if power <= 8000 {
			fmt.Println("Inseto!")
		} else {
			fmt.Println("Mais de 8000!")
		}
	}
}
