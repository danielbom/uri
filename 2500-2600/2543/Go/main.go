package main

import (
	"bufio"
	"fmt"
	"os"
)

func ReadLineAsPair(reader *bufio.Reader) (int, int, error) {
	var x, y int
	line, err := reader.ReadString('\n')
	if err != nil {
		return x, y, err
	}
	k, err := fmt.Sscanf(line, "%d %d", &x, &y)
	if err != nil {
		return x, y, err
	}
	if k != 2 {
		return x, y, fmt.Errorf("invalid pair format")
	}
	return x, y, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		gameplaysCount, myUniversityID, err := ReadLineAsPair(reader)
		if err != nil {
			break
		}

		counterStrikeGameplaysCount := 0
		for i := 0; i < gameplaysCount; i++ {
			authorUniversityID, gameID, err := ReadLineAsPair(reader)
			if err != nil {
				fmt.Println(err)
				os.Exit(1)
			}

			if authorUniversityID == myUniversityID && gameID == 0 {
				counterStrikeGameplaysCount += 1
			}
		}

		fmt.Println(counterStrikeGameplaysCount)
	}
}
