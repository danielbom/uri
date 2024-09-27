package main

import (
	"fmt"
)

func main() {
	for i := 0; i < 26; i++ {
		ch := byte(int('a') + i)
		fmt.Printf("%d e %c\n", ch, ch)
	}
}
