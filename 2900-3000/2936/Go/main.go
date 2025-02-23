package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing element")
	}
	return strconv.Atoi(scanner.Text())
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	portionsSize := []PortionSize{
		NewPortionSize(300, "Curupira eats"),
		NewPortionSize(1500, "Boitatá eats"),
		NewPortionSize(600, "Boto eats"),
		NewPortionSize(1000, "Mapinguari eats"),
		NewPortionSize(150, "Iara eats"),
	}
	initialPortionSize := NewPortionSize(225, "Dona Chica")

	result := initialPortionSize.Size
	for i, p := range portionsSize {
		portions, err := NextInt(scanner)
		if err != nil { panic(fmt.Errorf("fail in %d - %s: %v", i, p.Who, err)) }

		result += p.Size * portions
	}

	fmt.Println(result)
}

type PortionSize struct {
	Size int
	Who string
}

func NewPortionSize(size int, who string) PortionSize {
	return PortionSize{Size: size, Who: who}
}