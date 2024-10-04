package main

import "fmt"

func main() {
	var cs [4]int
	fmt.Scanf("%d %d %d %d", &cs[0], &cs[1], &cs[2], &cs[3])
	for i, c := range cs {
		if c == 1 {
			fmt.Println(i + 1)
			break
		}
	}
}
