package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	for {
		n := ReadLineInt(reader)
		if n == 0 {
			break
		}

		for i := 0; i < n; i++ {
			value := ReadLineInt(reader)
			if value%2 == 0 {
				fmt.Println(value*2 - 2)
			} else {
				fmt.Println(value*2 - 1)
			}
		}
	}
}

func ReadLineInt(r *bufio.Reader) int {
	line, err := r.ReadString('\n')
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
	line = strings.TrimSpace(line)
	value, err := strconv.Atoi(line)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
	return value
}
