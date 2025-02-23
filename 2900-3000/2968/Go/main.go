package main

import (
	"fmt"
)

func main() {
	var lapsCount, signsCount int
	fmt.Scanf("%d %d", &lapsCount, &signsCount)
	totalSigns := signsCount * lapsCount
	for mark := 1; mark <= 9; mark++ {
		if mark > 1 {
			fmt.Print(" ")
		}
		fmt.Print((totalSigns * mark + 9) / 10)
	}
	fmt.Println()
}
