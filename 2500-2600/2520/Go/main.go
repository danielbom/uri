package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strings"
)

type Coord struct {
	X int
	Y int
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		line, err := reader.ReadString('\n')
		if err != nil {
			break
		}

		var rows, cols int
		k, err := fmt.Sscanf(line, "%d %d", &rows, &cols)
		if err != nil {
			break
		}
		if k != 2 {
			break
		}

		ash := Coord{X: -1, Y: -1}
		pikachu := Coord{X: -1, Y: -1}

		for i := 0; i < rows; i++ {
			line, err := reader.ReadString('\n')
			if err != nil {
				fmt.Println("row not found")
				os.Exit(1)
			}
			words := strings.Fields(line)
			for j := 0; j < cols; j++ {
				if words[j] == "1" {
					ash.X = i
					ash.Y = j
				} else if words[j] == "2" {
					pikachu.X = i
					pikachu.Y = j
				}
			}
		}

		if ash.X == -1 || ash.Y == -1 {
			fmt.Println("ash not found")
			os.Exit(1)
		}
		if pikachu.X == -1 || pikachu.Y == -1 {
			fmt.Println("pikachu not found")
			os.Exit(1)
		}

		dx := math.Abs(float64(ash.X - pikachu.X))
		dy := math.Abs(float64(ash.Y - pikachu.Y))
		dist := int(dx + dy)

		fmt.Println(dist)
	}
}
