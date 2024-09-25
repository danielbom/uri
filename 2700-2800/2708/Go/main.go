package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
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

type Jeep struct {
	Moviment string
	Tourists int
}

func NextJeep(scanner *bufio.Scanner) (bool, Jeep, error) {
	moviment, err := NextWord(scanner)
	if err != nil {
		return false, Jeep{}, err
	}
	if moviment == "ABEND" {
		return true, Jeep{}, nil
	}
	tourists, err := NextInt(scanner)
	if err != nil {
		return false, Jeep{}, err
	}
	return false, Jeep{Moviment: moviment, Tourists: tourists}, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	visitsCount := 0
	touristsCount := 0
	for {
		end, jeep, err := NextJeep(scanner)
		if err != nil {
			panic(err)
		}
		if end {
			break
		}

		if jeep.Moviment == "SALIDA" {
			touristsCount += jeep.Tourists
			visitsCount += 1
		} else if jeep.Moviment == "VUELTA" {
			touristsCount -= jeep.Tourists
			visitsCount -= 1
		} else {
			panic(fmt.Errorf("invalid jeep moviment"))
		}
	}

	fmt.Println(touristsCount)
	fmt.Println(visitsCount)
}
