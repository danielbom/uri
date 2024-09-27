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

func main() {
	reindeers := []string{"Dasher", "Dancer", "Prancer", "Vixen", "Comet", "Cupid", "Donner", "Blitzen", "Rudolph"}
	reindeersCount := len(reindeers)

	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	totalSnowballs := 0
	for i := 0; i < reindeersCount; i++ {
		snowballs, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		totalSnowballs += snowballs
	}

	fmt.Println(reindeers[(totalSnowballs-1)%reindeersCount])
}
