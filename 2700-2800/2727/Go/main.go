package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return "", err
	}
	text := scanner.Text()
	if text == "" {
		return text, fmt.Errorf("empty scanner")
	}
	return text, nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
	text, err := NextWord(scanner)
	if err != nil {
		return 0, err
	}
	return strconv.Atoi(text)
}

func DecipherLetter(letter string) string {
	spaceIx := strings.IndexByte(letter, ' ')
	if spaceIx == -1 {
		spaceIx = len(letter)
	}
	spacesCount := strings.Count(letter, " ")
	return string([]byte{byte(int('a') + spacesCount*3 + spaceIx - 1)})
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	for {
		codesCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		for i := 0; i < codesCount; i++ {
			code, err := NextWord(scanner)
			if err != nil {
				panic(err)
			}

			fmt.Println(DecipherLetter(code))
		}
	}
}
