package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func ReadLine(reader *bufio.Reader) (string, error) {
	line, err := reader.ReadString('\n')
	if err != nil {
		return "", err
	}
	return strings.TrimSpace(line), nil
}

func ReadNLines(reader *bufio.Reader, n int) ([]string, error) {
	result := make([]string, n)
	for i := 0; i < n; i++ {
		line, err := ReadLine(reader)
		if err != nil {
			return result, err
		}
		result[i] = line
	}
	return result, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	lines, err := ReadNLines(reader, 10)
	if err != nil {
		panic(err)
	}

	fmt.Println(lines[2])
	fmt.Println(lines[6])
	fmt.Println(lines[8])
}
