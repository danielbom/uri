package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
	if !scanner.Scan() {
		return "", scanner.Err()
	}
	return scanner.Text(), nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
	if !scanner.Scan() {
		return 0, fmt.Errorf("missing integer")
	}
	return strconv.Atoi(scanner.Text())
}

type Encrypter struct {
	keyword      string
	keywordCount int
	buffer       []rune
}

func NewEncrypter(keyword string) Encrypter {
	buffer := make([]rune, 0, 10000)
	return Encrypter{keyword: keyword, keywordCount: len(keyword), buffer: buffer}
}

func (e *Encrypter) EncryptMessage(message string) string {
	message = strings.Trim(message, " ")
	vowels := "aeiou"
	e.buffer = e.buffer[:0]
	s := int(' ')
	n := e.keywordCount
	m := len(message)
	a, z := int('a'), int('z')
	i := 0
	j := 0
	for i < m {
		if int(message[i]) == s {
			// space
			e.buffer = append(e.buffer, rune(message[i]))
			for i < m && int(message[i]) == s {
				i++
			}
		} else if strings.ContainsRune(vowels, rune(message[i])) {
			// skip
			for i < m && int(message[i]) != s {
				e.buffer = append(e.buffer, rune(message[i]))
				i++
			}
		} else {
			// encrypt
			for i < m && int(message[i]) != s {
				ix := (int(message[i])+int(e.keyword[j])-2*a)%(z-a+1) + a
				e.buffer = append(e.buffer, rune(ix))
				j = (j + 1) % n
				i++
			}
		}
	}
	return string(e.buffer)
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	keyword, err := NextWord(scanner)
	if err != nil {
		panic(err)
	}

	encrypter := NewEncrypter(keyword)

	messagesCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < messagesCount; i++ {
		message, err := NextWord(scanner)
		if len(message) == 0 {
			fmt.Println()
		} else if err != nil {
				panic(fmt.Errorf("message %d: %v", i, err))
		} else {
			encryptedMessage := encrypter.EncryptMessage(message)
			fmt.Println(encryptedMessage)
		}
	}
}
