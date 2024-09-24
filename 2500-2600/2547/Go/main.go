package main

import (
	"bufio"
	"fmt"
	"os"
)

func ReadLineAsInt(reader *bufio.Reader) (int, error) {
	var x int
	line, err := reader.ReadString('\n')
	if err != nil {
		return x, err
	}
	k, err := fmt.Sscanf(line, "%d", &x)
	if err != nil {
		return x, err
	}
	if k != 1 {
		return x, fmt.Errorf("invalid int format")
	}
	return x, nil
}

func ReadLineAsTriple(reader *bufio.Reader) (int, int, int, error) {
	var x, y, z int
	line, err := reader.ReadString('\n')
	if err != nil {
		return x, y, z, err
	}
	k, err := fmt.Sscanf(line, "%d %d %d", &x, &y, &z)
	if err != nil {
		return x, y, z, err
	}
	if k != 3 {
		return x, y, z, fmt.Errorf("invalid triple format")
	}
	return x, y, z, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		guestsCount, heightMin, heightMax, err := ReadLineAsTriple(reader)
		if err != nil {
			break
		}

		allowedCount := 0
		for i := 0; i < guestsCount; i++ {
			height, err := ReadLineAsInt(reader)
			if err != nil {
				fmt.Println(err)
				os.Exit(1)
			}

			if heightMin <= height && height <= heightMax {
				allowedCount += 1
			}
		}

		fmt.Println(allowedCount)
	}
}
