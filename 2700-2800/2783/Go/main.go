package main

import (
	"bufio"
	"fmt"
	"math/bits"
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
		return "", fmt.Errorf("empty scanner")
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

func NextIntOrFail(scanner *bufio.Scanner) int {
	value, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}
	return value
}

type BitSet []uint

func NewBitSet(max int) BitSet {
	bits := make([]uint, (max+bits.UintSize)/bits.UintSize)
	return BitSet(bits)
}

func (bs BitSet) Add(i int) {
	k := i / bits.UintSize
	v := i % bits.UintSize
	bs[k] = bs[k] | (1 << v)
}

func (bs BitSet) Remove(i int) {
	k := i / bits.UintSize
	v := i % bits.UintSize
	bs[k] = bs[k] & ^(1 << v)
}

func (bs BitSet) CountOnes() int {
	count := 0
	for _, x := range bs {
		count += bits.OnesCount(x)
	}
	return count
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	// line 1
	cardsCount := NextIntOrFail(scanner)
	stampsCount := NextIntOrFail(scanner)
	cardsPuchasedCount := NextIntOrFail(scanner)

	set := NewBitSet(cardsCount)

	// line 2
	for i := 0; i < stampsCount; i++ {
		stamp := NextIntOrFail(scanner)
		set.Add(stamp)
	}

	// line 3
	for i := 0; i < cardsPuchasedCount; i++ {
		card := NextIntOrFail(scanner)
		set.Remove(card)
	}

	fmt.Println(set.CountOnes())
}
