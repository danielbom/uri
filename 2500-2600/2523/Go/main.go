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
		alphabet, err := reader.ReadString('\n')
		if err != nil {
			break
		}
		line, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("chars count not found")
			os.Exit(1)
		}

		n, err := strconv.Atoi(strings.TrimSpace(line))
		if err != nil {
			fmt.Println("chars count not found")
			os.Exit(1)
		}

		line, err = reader.ReadString('\n')
		if err != nil {
			fmt.Println("char indexes not found")
			os.Exit(1)
		}

		sb := strings.Builder{}
		words := strings.Fields(line)
		for i := 0; i < n; i++ {
			ix, err := strconv.Atoi(words[i])
			if err != nil {
				fmt.Println("invalid char index")
				os.Exit(1)
			}
			sb.WriteByte(alphabet[ix-1])
		}
		fmt.Println(sb.String())
	}
}
