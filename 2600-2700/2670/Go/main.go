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

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	a1, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	a2, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	a3, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	t1 := a1*0 + a2*2 + a3*4
	t2 := a1*2 + a2*0 + a3*2
	t3 := a1*4 + a2*2 + a3*0
	if t1 <= t2 && t1 <= t3 {
		fmt.Println(t1)
		return
	}
	if t2 <= t1 && t2 <= t3 {
		fmt.Println(t2)
		return
	}
	if t3 <= t2 && t3 <= t2 {
		fmt.Println(t3)
		return
	}
}
