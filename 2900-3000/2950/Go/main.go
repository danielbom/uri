package main

import (
	"fmt"
)

func main() {
	var n, x, y int
	fmt.Scanf("%d %d %d", &n, &x, &y)

	distance := float64(n)
	diameterSauron := float64(x)
	diameterSaruman := float64(y)

	// Magnetic Communication Interference
	imc := distance / (diameterSaruman + diameterSauron)
	fmt.Printf("%.2f\n", imc)
}
