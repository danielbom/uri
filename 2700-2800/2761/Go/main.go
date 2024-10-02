package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func ReadWord(reader *bufio.Reader) (string, error) {
	return reader.ReadString(' ')
}

func ReadWordAsInt(reader *bufio.Reader) (int, error) {
	word, err := ReadWord(reader)
	if err != nil {
		panic(err)
	}
	word = strings.TrimSpace(word)
	return strconv.Atoi(word)
}

func ReadWordAsFloat32(reader *bufio.Reader) (float32, error) {
	word, err := ReadWord(reader)
	if err != nil {
		panic(err)
	}
	word = strings.TrimSpace(word)
	value, err := strconv.ParseFloat(word, 32)
	return float32(value), err
}

func ReadWordAsByte(reader *bufio.Reader) (byte, error) {
	word, err := ReadWord(reader)
	if err != nil {
		return ' ', err
	}
	word = strings.TrimSpace(word)
	if len(word) != 1 {
		return ' ', fmt.Errorf("invalid byte")
	}
	return word[0], nil
}

func ReadLine(reader *bufio.Reader) (string, error) {
	line, err := reader.ReadString('\n')
	return line[:len(line)-1], err
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	x, err := ReadWordAsInt(reader)
	if err != nil {
		panic(err)
	}

	y, err := ReadWordAsFloat32(reader)
	if err != nil {
		panic(err)
	}

	c, err := ReadWordAsByte(reader)
	if err != nil {
		panic(err)
	}

	s, err := ReadLine(reader)
	if err != nil {
		panic(err)
	}

	fmt.Printf("%d%.6f%c%s\n", x, y, c, s)
	fmt.Printf("%d\t%.6f\t%c\t%s\n", x, y, c, s)
	fmt.Printf("%10d%10.6f%10c%10s\n", x, y, c, s)
}
