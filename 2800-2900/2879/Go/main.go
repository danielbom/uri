package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	scanner.Scan() // ignore count

	winCount := 0
	for scanner.Scan() {
		winnerDoor, err := strconv.Atoi(scanner.Text())
		if err != nil {
			panic(err)
		}

		if winnerDoor != 1 { winCount++ }
	}
	fmt.Println(winCount)
}
