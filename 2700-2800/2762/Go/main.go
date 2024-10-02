package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func ReadPair(reader *bufio.Reader) (int, int, error) {
	word1, err := reader.ReadString('.')
	if err != nil {
		return 0, 0, err
	}
	fst, err := strconv.Atoi(word1[:len(word1)-1])
	if err != nil {
		return 0, 0, err
	}
	word2, err := reader.ReadString('\n')
	if err != nil {
		return 0, 0, err
	}
	snd, err := strconv.Atoi(word2[:len(word2)-1])
	return fst, snd, err
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	a, b, err := ReadPair(reader)
	if err != nil {
		panic(err)
	}

	fmt.Printf("%d.%d\n", b, a)
}
