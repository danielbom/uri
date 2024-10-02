package main

import (
	"bufio"
	"fmt"
	"os"
)

type Cpf struct {
	a string
	b string
	c string
	d string
}

func IsAllDigits(digits string) error {
	for _, ch := range digits {
		isDigit := '0' <= ch && ch <= '9'
		if !isDigit {
			return fmt.Errorf("expects only digits")
		}
	}
	return nil
}

func ReadCpf(reader *bufio.Reader) (Cpf, error) {
	cpf := Cpf{}

	buffer := make([]byte, 14)
	bufN, err := reader.Read(buffer)
	if err != nil {
		return cpf, err
	}
	if bufN != 14 {
		return cpf, fmt.Errorf("cpf expects 14 bytes")
	}
	if buffer[3] != '.' {
		return cpf, fmt.Errorf("missing first delimiter `.`")
	}
	if buffer[7] != '.' {
		return cpf, fmt.Errorf("missing second delimiter `.`")
	}
	if buffer[11] != '-' {
		return cpf, fmt.Errorf("missing third delimiter `-`")
	}
	cpf.a = string(buffer[0:3])
	if err := IsAllDigits(cpf.a); err != nil {
		return cpf, err
	}
	cpf.b = string(buffer[4:7])
	if err := IsAllDigits(cpf.b); err != nil {
		return cpf, err
	}
	cpf.c = string(buffer[8:11])
	if err := IsAllDigits(cpf.c); err != nil {
		return cpf, err
	}
	cpf.d = string(buffer[12:14])
	if err := IsAllDigits(cpf.d); err != nil {
		return cpf, err
	}
	return cpf, err
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	cpf, err := ReadCpf(reader)
	if err != nil {
		panic(err)
	}

	fmt.Println(cpf.a)
	fmt.Println(cpf.b)
	fmt.Println(cpf.c)
	fmt.Println(cpf.d)
}
