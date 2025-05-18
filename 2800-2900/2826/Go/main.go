package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	if !scanner.Scan() {
		panic("missing the first word")
	}
	word1 := scanner.Text()

	if !scanner.Scan() {
		panic("missing the second word")
	}
	word2 := scanner.Text()

	if word1 <= word2 {
		fmt.Println(word1)
		fmt.Println(word2)
	} else {
		fmt.Println(word2)
		fmt.Println(word1)
	}
}
