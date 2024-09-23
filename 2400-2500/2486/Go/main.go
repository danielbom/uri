package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const VITAMIN_C_MIN = 110
const VITAMIN_C_MAX = 130

func ReadLine(reader *bufio.Reader) string {
	line, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return strings.TrimSpace(line)
}

func ReadLineAsInt(reader *bufio.Reader) int {
	line := ReadLine(reader)
	n, err := strconv.Atoi(line)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return n
}

func ReadLineAsProduct(reader *bufio.Reader) (int, string) {
	line := ReadLine(reader)
	spaceIx := strings.IndexByte(line, ' ')
	amount, err := strconv.Atoi(line[:spaceIx])
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	product := line[spaceIx+1:]
	return amount, product
}

func MoreOrLessVitaminC(vitaminC int) int {
	if VITAMIN_C_MIN > vitaminC {
		return vitaminC - VITAMIN_C_MIN
	}
	if vitaminC > VITAMIN_C_MAX {
		return vitaminC - VITAMIN_C_MAX
	}
	return 0
}

func ProductVitaminC(product string) int {
	if product == "suco de laranja" {
		return 120
	}
	if product == "morango fresco" {
		return 85
	}
	if product == "mamao" {
		return 85
	}
	if product == "goiaba vermelha" {
		return 70
	}
	if product == "manga" {
		return 56
	}
	if product == "laranja" {
		return 50
	}
	if product == "brocolis" {
		return 34
	}
	return 0
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		n := ReadLineAsInt(reader)
		if n == 0 {
			break
		}

		vitaminC := 0
		for i := 0; i < n; i++ {
			amount, product := ReadLineAsProduct(reader)
			vitaminC += amount * ProductVitaminC(product)
		}

		moreOrLess := MoreOrLessVitaminC(vitaminC)
		if moreOrLess < 0 {
			fmt.Printf("Mais %d mg\n", -moreOrLess)
		} else if moreOrLess > 0 {
			fmt.Printf("Menos %d mg\n", moreOrLess)
		} else {
			fmt.Printf("%d mg\n", vitaminC)
		}
	}
}
