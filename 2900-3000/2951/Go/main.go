package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
	if !scanner.Scan() {
		return "", fmt.Errorf("missing element")
	}
	return scanner.Text(), nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing element")
	}
	return strconv.Atoi(scanner.Text())
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	runesCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	friendshipToDefeatGollum, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	friendship := make(map[string]int)

	for i := 0; i < runesCount; i++ {
		runeName, err := NextWord(scanner)
		if err != nil {
			panic(err)
		}
		runeFriendship, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		friendship[runeName] = runeFriendship
	}

	runesRecitedCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	totalFriendship := 0
	for i := 0; i < runesRecitedCount; i++ {
		runeName, err := NextWord(scanner)
		if err != nil {
			panic(err)
		}

		if value, found := friendship[runeName]; found {
			totalFriendship += value
		}
	}

	fmt.Println(totalFriendship)
	if totalFriendship >= friendshipToDefeatGollum {
		fmt.Println("You shall pass!")
	} else {
		fmt.Println("My precioooous")
	}
}
