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

type Dim struct {
	Width  int
	Height int
}

func NextDim(scanner *bufio.Scanner) (dim Dim, err error) {
	dim.Width, err = NextInt(scanner)
	if err != nil {
		return dim, err
	}
	dim.Height, err = NextInt(scanner)
	if err != nil {
		return dim, err
	}
	return dim, nil
}

func CheckCompatibility(company, client Dim) string {
	isCompatible := (client.Width <= company.Width && client.Height <= company.Height) ||
		(client.Width <= company.Height && client.Height <= company.Width)
	if isCompatible {
		return "Sim"
	} else {
		return "Nao"
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		companyDim, err := NextDim(scanner)
		if err != nil {
			break
		}

		requestsCount, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		for i := 0; i < requestsCount; i++ {
			clientDim, err := NextDim(scanner)
			if err != nil {
				panic(err)
			}

			fmt.Println(CheckCompatibility(companyDim, clientDim))
		}
	}
}
