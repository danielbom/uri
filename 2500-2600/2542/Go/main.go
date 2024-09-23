package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func ReadLine(reader *bufio.Reader) (string, error) {
	return reader.ReadString('\n')
}

func ReadLineAsInt(reader *bufio.Reader) (int, error) {
	line, err := ReadLine(reader)
	if err != nil {
		return -1, err
	}
	return strconv.Atoi(strings.TrimSpace(line))
}

func ReadLineAsPair(reader *bufio.Reader) (int, int, error) {
	line, err := ReadLine(reader)
	if err != nil {
		return -1, -1, err
	}
	var x, y int
	k, err := fmt.Sscanf(line, "%d %d", &x, &y)
	if k != 2 {
		return -1, -1, fmt.Errorf("invalid pair format")
	}
	return x, y, err
}

type Card struct {
	Attrs []int
}

func NewCard(attrsCounts int) Card {
	attrs := make([]int, attrsCounts)
	return Card{Attrs: attrs}
}

func ReadCard(reader *bufio.Reader, attrsCounts int) (Card, error) {
	card := NewCard(attrsCounts)
	line, err := ReadLine(reader)
	if err != nil {
		return card, err
	}

	for ix, word := range strings.Fields(line) {
		value, err := strconv.Atoi(word)
		if err != nil {
			return card, err
		}
		card.Attrs[ix] = value
	}

	return card, nil
}

func ReadDeck(reader *bufio.Reader, attrsCount, cardsCount int) ([]Card, error) {
	deck := make([]Card, cardsCount)
	for i := 0; i < cardsCount; i++ {
		card, err := ReadCard(reader, attrsCount)
		if err != nil {
			return nil, err
		}
		deck[i] = card
	}
	return deck, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	for {
		attrsCount, err := ReadLineAsInt(reader)
		if err != nil {
			break
		}

		cardsCount1, cardsCount2, err := ReadLineAsPair(reader)
		if err != nil {
			fmt.Println("ERR: missing cards count:", err)
			os.Exit(1)
		}

		deck1, err := ReadDeck(reader, attrsCount, cardsCount1)
		if err != nil {
			fmt.Println("ERR: missing deck 1:", err)
			os.Exit(1)
		}
		deck2, err := ReadDeck(reader, attrsCount, cardsCount2)
		if err != nil {
			fmt.Println("ERR: missing deck 2:", err)
			os.Exit(1)
		}

		chosenCard1, chosenCard2, err := ReadLineAsPair(reader)
		if err != nil {
			fmt.Println("ERR: missing chosen cards:", err)
			os.Exit(1)
		}

		chosenAttr, err := ReadLineAsInt(reader)
		if err != nil {
			fmt.Println("ERR: missing chosen attribute:", err)
			os.Exit(1)
		}

		attr1 := deck1[chosenCard1-1].Attrs[chosenAttr-1]
		attr2 := deck2[chosenCard2-1].Attrs[chosenAttr-1]

		if attr1 > attr2 {
			fmt.Println("Marcos")
		} else if attr1 < attr2 {
			fmt.Println("Leonardo")
		} else {
			fmt.Println("Empate")
		}
	}
}
