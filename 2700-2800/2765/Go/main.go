package main

import (
	"bufio"
	"fmt"
	"os"
)

func StringDropLast(word string) string {
	if word == "" {
		return word
	}
	return word[:len(word)-1]
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	word1, err := reader.ReadString(',')
	if err != nil {
		panic(err)
	}
	word1 = StringDropLast(word1)

	word2, err := reader.ReadString('\n')
	if err != nil {
		panic(err)
	}
	word2 = StringDropLast(word2)

	fmt.Println(word1)
	fmt.Println(word2)
}
