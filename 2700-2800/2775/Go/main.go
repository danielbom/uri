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

type Packet struct {
	Number int
	Time   int
}

func NextPackets(scanner *bufio.Scanner, n int) ([]Packet, error) {
	result := make([]Packet, n)
	for i := 0; i < n; i++ {
		value, err := NextInt(scanner)
		if err != nil {
			return nil, err
		}
		result[i].Number = value
	}
	for i := 0; i < n; i++ {
		value, err := NextInt(scanner)
		if err != nil {
			return nil, err
		}
		result[i].Time = value
	}
	return result, nil
}

func SortPackets(packets []Packet) int {
	totalTime := 0
	for i := 0; i < len(packets); i++ {
		for j := 1; j < len(packets)-i; j++ {
			if packets[j-1].Number > packets[j].Number {
				temp := packets[j-1]
				packets[j-1] = packets[j]
				packets[j] = temp
				totalTime += packets[j-1].Time
				totalTime += packets[j].Time
			}
		}
	}
	return totalTime
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		packetsCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		packets, err := NextPackets(scanner, packetsCount)
		if err != nil {
			panic(err)
		}

		totalTime := SortPackets(packets)
		fmt.Println(totalTime)
	}
}
