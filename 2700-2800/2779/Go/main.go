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

type BitSet struct {
	bits []uint
}

func NewBitSet(max int) BitSet {
	bits := make([]uint, (max+32)/32)
	return BitSet{bits}
}

func (bs *BitSet) Add(i int) {
	k := i / 32
	v := i % 32
	bs.bits[k] = bs.bits[k] | (1 << v)
}

func (bs BitSet) CountOnes() int {
	count := 0
	for _, x := range bs.bits {
		count += bits.OnesCount(x)
	}
	return count
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	stickersAndSpacesCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	stickersPurchasedCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	set := NewBitSet(stickersAndSpacesCount)
	for i := 0; i < stickersPurchasedCount; i++ {
		card, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}
		set.Add(card)
	}

	fmt.Println(stickersAndSpacesCount - set.CountOnes())
}
