package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func ReadLine(reader *bufio.Reader) (string, error) {
	return reader.ReadString('\n')
}

func ReadLineAsInt(reader *bufio.Reader) (int, error) {
	line, err := ReadLine(reader)
	if err != nil {
		return -1, err
	}
	return strconv.Atoi(strings.TrimSpace(line))
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	for {
		votesCount, err := ReadLineAsInt(reader)
		if err != nil {
			break
		}

		votes, err := ReadLine(reader)
		if err != nil {
			fmt.Println("invalid format")
			os.Exit(1)
		}

		approvesCount := 0
		for _, ch := range votes {
			if ch == '1' {
				approvesCount += 1
			}
		}

		if float64(approvesCount) >= 2.0*float64(votesCount)/3.0 {
			fmt.Println("impeachment")
		} else {
			fmt.Println("acusacao arquivada")
		}
	}
}
