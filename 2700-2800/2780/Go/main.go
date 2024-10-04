package main

import (
	"fmt"
)

func main() {
	var distance int
	fmt.Scanf("%d", &distance)

	if distance <= 800 {
		fmt.Println(1)
	} else if distance <= 1400 {
		fmt.Println(2)
	} else {
		fmt.Println(3)
	}
}
