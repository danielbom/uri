package main

import (
	"fmt"
)

func main() {
	a, b := 234.345, 45.698
	fmt.Printf("%.6f - %.6f\n", a, b)
	fmt.Printf("%.0f - %.0f\n", a, b)
	fmt.Printf("%.1f - %.1f\n", a, b)
	fmt.Printf("%.2f - %.2f\n", a, b)
	fmt.Printf("%.3f - %.3f\n", a, b)
	fmt.Printf("%e - %e\n", a, b)
	fmt.Printf("%E - %E\n", a, b)
	fmt.Printf("%g - %g\n", a, b)
	fmt.Printf("%G - %G\n", a, b)
}
