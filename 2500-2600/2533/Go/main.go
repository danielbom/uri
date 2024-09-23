package main

import (
	"bufio"
	"fmt"
	"os"
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
		return -1, -1, fmt.Errorf("invalid format")
	}

	return x, y, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		subjectsCount, err := ReadLineAsInt(reader)
		if err != nil {
			break
		}

		totalWorkload := 0
		totalWeightedGrade := 0
		for i := 0; i < subjectsCount; i++ {
			grade, workload, err := ReadLineAsPair(reader)
			if err != nil {
				fmt.Println(err)
				os.Exit(1)
			}
			weightedGrade := grade * workload
			totalWorkload += workload
			totalWeightedGrade += weightedGrade
		}
		result := float64(totalWeightedGrade) / (100.0 * float64(totalWorkload))
		fmt.Printf("%.4f\n", result)
	}
}
