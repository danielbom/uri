package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return "", err
	}
	text := scanner.Text()
	if text == "" {
		return text, fmt.Errorf("empty scanner")
	}
	return text, nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
	text, err := NextWord(scanner)
	if err != nil {
		return 0, err
	}
	return strconv.Atoi(text)
}

type Color [3]int

func (c *Color) Min() int {
	result := float64(c[0])
	result = math.Min(result, float64(c[1]))
	result = math.Min(result, float64(c[2]))
	return int(result)
}

func (c *Color) Max() int {
	result := float64(c[0])
	result = math.Max(result, float64(c[1]))
	result = math.Max(result, float64(c[2]))
	return int(result)
}

func (c *Color) Mean() int {
	result := float64(c[0])
	result = result + float64(c[1])
	result = result + float64(c[2])
	return int(result / 3.0)
}

func (c *Color) Eye() int {
	result := float64(c[0]) * 0.3
	result = result + float64(c[1])*0.59
	result = result + float64(c[2])*0.11
	return int(result)
}

func NextColor(scanner *bufio.Scanner) (Color, error) {
	r, err := NextInt(scanner)
	if err != nil {
		return Color{}, err
	}
	g, err := NextInt(scanner)
	if err != nil {
		return Color{}, err
	}
	b, err := NextInt(scanner)
	if err != nil {
		return Color{}, err
	}
	return Color([3]int{r, g, b}), nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < n; i++ {
		approach, err := NextWord(scanner)
		if err != nil {
			panic(err)
		}

		color, err := NextColor(scanner)
		if err != nil {
			panic(err)
		}

		fmt.Printf("Caso #%d: ", i+1)
		if approach == "min" {
			fmt.Println(color.Min())
		} else if approach == "max" {
			fmt.Println(color.Max())
		} else if approach == "mean" {
			fmt.Println(color.Mean())
		} else if approach == "eye" {
			fmt.Println(color.Eye())
		}
	}

	fmt.Print()
}
