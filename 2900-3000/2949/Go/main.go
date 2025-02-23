package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	scanner.Scan() // ignore first line

	var stats Statistics 

	for scanner.Scan() {
		line := scanner.Text()
		if len(line) > 0 {
			race := line[len(line)-1]
			switch race {
			case 'A': stats.Dwarves++
			case 'E': stats.Elves++
			case 'H': stats.Humans++
			case 'M': stats.Magicians++
			case 'X': stats.Hobbits++
			default: panic(fmt.Errorf("unknown race: %c", race)) 
			}
		}
	}

	fmt.Printf("%d Hobbit(s)\n", stats.Hobbits)
	fmt.Printf("%d Humano(s)\n", stats.Humans)
	fmt.Printf("%d Elfo(s)\n", stats.Elves)
	fmt.Printf("%d Anao(oes)\n", stats.Dwarves)
	fmt.Printf("%d Mago(s)\n", stats.Magicians)
}

type Statistics struct {
	Dwarves int
	Elves int
	Humans int
	Magicians int
	Hobbits int
}