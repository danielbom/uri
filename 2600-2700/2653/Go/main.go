package main

import (
	"bufio"
	"fmt"
	"os"
)

type StringSet map[string]bool

func (ss *StringSet) Add(s string) {
	(*ss)[s] = true
}

func (ss *StringSet) Len() int {
	return len(*ss)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	ss := make(StringSet, 0)
	for scanner.Scan() {
		jewelry := scanner.Text()
		ss.Add(jewelry)
	}
	fmt.Println(ss.Len())
}
