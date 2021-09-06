package main

import (
	"fmt"
)

func main() {
	var a, b, c, d, result int
	fmt.Scan(&a)
	fmt.Scan(&b)
	fmt.Scan(&c)
	fmt.Scan(&d)
	result = (a * b) - (c * d)
	fmt.Printf("DIFERENCA = %d\n", result)
}
