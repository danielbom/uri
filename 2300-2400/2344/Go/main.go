package main

import (
	"fmt"
)

func main() {
	var score int
	fmt.Scanf("%d", &score)

	if score > 100 {
		fmt.Println("Invalid score")
	} else if score > 85 {
		fmt.Println("A")
	} else if score > 60 {
		fmt.Println("B")
	} else if score > 35 {
		fmt.Println("C")
	} else if score > 0 {
		fmt.Println("D")
	} else if score == 0 {
		fmt.Println("E")
	} else {
		fmt.Println("Invalid score")
	}
}
