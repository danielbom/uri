package main

import (
	"fmt"
)

func main() {
	message := "AMO FAZER EXERCICIO NO URI"
	fmt.Printf("<% s>\n", message)
	fmt.Printf("<% 30s>\n", message)
	fmt.Printf("<% .20s>\n", message)
	fmt.Printf("<% -20s>\n", message)
	fmt.Printf("<% -30s>\n", message)
	fmt.Printf("<% .30s>\n", message)
	fmt.Printf("<% 30.20s>\n", message)
	fmt.Printf("<% -30.20s>\n", message)
}
