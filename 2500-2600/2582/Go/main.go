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
		return text, fmt.Errorf("empty scanner")
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

func ReadPair(scanner *bufio.Scanner) (int, int, error) {
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

func SongName(id int) (string, error) {
	switch id {
	case 0:
		return "PROXYCITY", nil
	case 1:
		return "P.Y.N.G.", nil
	case 2:
		return "DNSUEY!", nil
	case 3:
		return "SERVERS", nil
	case 4:
		return "HOST!", nil
	case 5:
		return "CRIPTONIZE", nil
	case 6:
		return "OFFLINE DAY", nil
	case 7:
		return "SALT", nil
	case 8:
		return "ANSWER!", nil
	case 9:
		return "RAR?", nil
	case 10:
		return "WIFI ANTENNAS", nil
	default:
		return "", fmt.Errorf("invalid song id")
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	n, err := ReadInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < n; i++ {
		button1, button2, err := ReadPair(scanner)
		if err != nil {
			panic(err)
		}

		song, err := SongName(button1 + button2)
		if err != nil {
			panic(err)
		}

		fmt.Println(song)
	}
}
