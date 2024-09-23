package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func ReadLineAsInt(reader *bufio.Reader) (int, error) {
	line, err := reader.ReadString('\n')
	if err != nil {
		return -1, err
	}
	return strconv.Atoi(strings.TrimSpace(line))
}

func ReadLineAsPair(reader *bufio.Reader) (int, int, error) {
	line, err := reader.ReadString('\n')
	if err != nil {
		return -1, -1, err
	}

	var x, y int
	k, err := fmt.Sscanf(line, "%d %d", &x, &y)
	if err != nil {
		return -1, -1, err
	}
	if k != 2 {
		return -1, -1, fmt.Errorf("invalid pair format")
	}

	return x, y, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		citizensCount, queriesCount, err := ReadLineAsPair(reader)
		if err != nil {
			break
		}

		grades := make([]int, citizensCount)

		for i := 0; i < citizensCount; i++ {
			grade, err := ReadLineAsInt(reader)
			if err != nil {
				fmt.Println(err)
				os.Exit(1)
			}
			grades[i] = grade
		}

		sort.IntSlice(grades).Sort()

		for i := 0; i < queriesCount; i++ {
			ix, err := ReadLineAsInt(reader)
			if err != nil {
				fmt.Println(err)
				os.Exit(1)
			}
			fmt.Println(grades[citizensCount-ix])
		}
	}
}
