package main

import (
	"fmt"
)

func main() {
	var rowsCount, colsCount int
	fmt.Scanf("%d\n%d", &rowsCount, &colsCount)

	fmt.Println((rowsCount + colsCount + 1) % 2)
}
