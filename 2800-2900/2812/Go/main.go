package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
)

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing value to read")
	}
	return strconv.Atoi(scanner.Text())
}

func FilterOdds(list []int) []int {
	odds := make([]int, 0, len(list))
	for _, x := range list {
		if x%2 == 1 {
			odds = append(odds, x)
		}
	}
	return odds
}

func ShowList(list []int) {
	start := 0
	end := len(list) - 1
	back := true
	first := true
	for start <= end {
		if !first {
			fmt.Print(" ")
		}
		if back {
			fmt.Print(list[end])
			end--
		} else {
			fmt.Print(list[start])
			start++
		}
		back = !back
		first = false
	}
	fmt.Println()
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)
	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	for i := 0; i < n; i++ {
		m, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}
		list := make([]int, 0, m)
		for j := 0; j < m; j++ {
			x, err := NextInt(scanner)
			if err != nil {
				panic(err)
			}
			list = append(list, x)
		}
		odds := FilterOdds(list)
		sort.IntSlice(odds).Sort()
		ShowList(odds)
	}
}
