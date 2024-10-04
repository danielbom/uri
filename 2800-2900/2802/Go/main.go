package main

import (
	"fmt"
)

func main() {
	var points uint
	fmt.Scanf("%d\n", &points)

	inter := ((points * (points - 1) * (points - 2) * (points - 3)) / (1 * 2 * 3 * 4))
	seg := (points * (points - 1)) / 2
	sec := inter + seg + 1
	fmt.Println(sec)
}
