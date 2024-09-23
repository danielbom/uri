package main

import "fmt"

func main() {
	var n int
	fmt.Scanf("%d", &n)
	fmt.Print("Feliz nat")
	for i := 0; i < n; i++ {
		fmt.Print("a")
	}
	fmt.Println("l!")
}
