package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func ReadWord(scanner *bufio.Scanner) (string, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return "", err
	}
	text := scanner.Text()
	if text == "" {
		return "", fmt.Errorf("scanner empty")
	}
	return text, nil
}

func ReadInt(scanner *bufio.Scanner) (int, error) {
	text, err := ReadWord(scanner)
	if err != nil {
		return 0, err
	}
	return strconv.Atoi(text)
}

func ReadLineAsPair(scanner *bufio.Scanner) (int, int, error) {
	x, err := ReadInt(scanner)
	if err != nil {
		return 0, 0, err
	}
	y, err := ReadInt(scanner)
	if err != nil {
		return 0, 0, err
	}
	return x, y, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		peopleCount, datesCount, err := ReadLineAsPair(scanner)
		if err != nil {
			break
		}

		result := ""
		for i := 0; i < datesCount; i++ {
			date, err := ReadWord(scanner)
			if err != nil {
				panic(err)
			}

			validDate := true
			for j := 0; j < peopleCount; j++ {
				presence, err := ReadInt(scanner)
				if err != nil {
					panic(err)
				}

				validDate = validDate && presence == 1
			}

			if result == "" && validDate {
				result = date
			}
		}

		if result == "" {
			fmt.Println("Pizza antes de FdI")
		} else {
			fmt.Println(result)
		}
	}
}
