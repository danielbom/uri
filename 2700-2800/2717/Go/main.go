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

func NextPair(scanner *bufio.Scanner) (int, int, error) {
	fst, err := NextInt(scanner)
	if err != nil {
		return 0, 0, err
	}
	snd, err := NextInt(scanner)
	if err != nil {
		return 0, 0, err
	}
	return fst, snd, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	minutesToGoAway, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	minutesFactoryGift1, minutesFactoryGift2, err := NextPair(scanner)
	if err != nil {
		panic(err)
	}

	if minutesFactoryGift1+minutesFactoryGift2 <= minutesToGoAway {
		fmt.Println("Farei hoje!")
	} else {
		fmt.Println("Deixa para amanha!")
	}
}
