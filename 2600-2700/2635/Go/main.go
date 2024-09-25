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
		return "", fmt.Errorf("empty scanner")
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

func AnalyzeSearches(previousSearches []string, search string) (int, int) {
	maxLength := 0
	count := 0
	for _, s := range previousSearches {
		if strings.HasPrefix(s, search) {
			count++
			slen := len(s)
			if slen > maxLength {
				maxLength = slen
			}
		}
	}
	return count, maxLength
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for {
		searchesCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		searches := make([]string, searchesCount)

		for i := 0; i < searchesCount; i++ {
			search, err := NextWord(scanner)
			if err != nil {
				panic(err)
			}
			searches[i] = search
		}

		queriesCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		for i := 0; i < queriesCount; i++ {
			query, err := NextWord(scanner)
			if err != nil {
				panic(err)
			}

			count, maxLength := AnalyzeSearches(searches, query)
			if count == 0 {
				fmt.Println(-1)
			} else {
				fmt.Println(count, maxLength)
			}
		}
	}
}
