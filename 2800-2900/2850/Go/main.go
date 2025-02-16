package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		switch line {
		case "esquerda":
			fmt.Println("ingles")
		case "direita":
			fmt.Println("frances")
		case "nenhuma":
			fmt.Println("portugues")
		case "as duas":
			fmt.Println("caiu")
		default:
			panic(fmt.Errorf("unknown condition: %s", line))
		}
	}
}
