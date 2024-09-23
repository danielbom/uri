package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func ReadLine(r *bufio.Reader) string {
	line, err := r.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return strings.TrimSpace(line)
}

type Cipher struct {
	chars map[byte]byte
}

func NewCipher(n int, chars1, chars2 string) Cipher {
	chars := make(map[byte]byte)

	uppers1 := strings.ToUpper(chars1)
	uppers2 := strings.ToUpper(chars2)

	lowers1 := strings.ToLower(chars1)
	lowers2 := strings.ToLower(chars2)

	for i := 0; i < n; i++ {
		chars[uppers2[i]] = uppers1[i]
		chars[uppers1[i]] = uppers2[i]
		chars[lowers2[i]] = lowers1[i]
		chars[lowers1[i]] = lowers2[i]
	}

	return Cipher{chars}
}

func (c *Cipher) Replace(sentence string) string {
	sb := strings.Builder{}
	for j := 0; j < len(sentence); j++ {
		oldCh := sentence[j]
		newCh, ok := c.chars[oldCh]
		if ok {
			sb.WriteByte(newCh)
		} else {
			sb.WriteByte(oldCh)
		}
	}
	return sb.String()
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	for {
		line, err := reader.ReadString('\n')
		if err != nil {
			break
		}

		var cipherSize, sentencesCount int
		n, err := fmt.Sscanf(line, "%d %d", &cipherSize, &sentencesCount)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		if n != 2 {
			fmt.Println("invalid chipher format")
			os.Exit(1)
		}

		line1 := ReadLine(reader)
		line2 := ReadLine(reader)

		cipher := NewCipher(cipherSize, line1, line2)

		for i := 0; i < sentencesCount; i++ {
			sentence := ReadLine(reader)
			fmt.Println(cipher.Replace(sentence))
		}

		fmt.Println()
	}
}
