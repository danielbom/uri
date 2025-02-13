package main

import (
	"bufio"
	"fmt"
	"os"
)

func ColumnIndex(column string) int64 {
	n := len(column)
	a := int64('A')
	m := int64(1)
	base := (int64('Z') - a) + 1
	index := int64(0)
	for i := range column {
		ch := column[n - i - 1]
		if 'A' <= ch && ch <= 'Z' {
			index += (int64(ch) - a + 1) * m
			m *= base
		} else {
			return 0
		}
	}
	return index
}

func main() {
	lastColumn := "XFD"
	lastIndex := ColumnIndex(lastColumn)

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		column := scanner.Text()
		index := ColumnIndex(column)

		if index == 0 || index > lastIndex {
			fmt.Println("Essa coluna nao existe Tobias!")
		} else {
			fmt.Println(index)
		}
	}
}
