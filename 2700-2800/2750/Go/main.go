package main

import (
	"fmt"
)

func main() {
	fmt.Println("---------------------------------------")
	fmt.Println("|  decimal  |  octal  |  Hexadecimal  |")
	fmt.Println("---------------------------------------")
	for i := 0; i < 16; i++ {
		fmt.Printf("|     %2d    |   %2o    |      %2X       |\n", i, i, i)
	}
	fmt.Println("---------------------------------------")
}
