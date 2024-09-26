package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return "", err
	}
	text := scanner.Text()
	if text == "" {
		return text, fmt.Errorf("empty scanner")
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

type Plate string

func NextPlate(scanner *bufio.Scanner) (Plate, error) {
	text, err := NextWord(scanner)
	return Plate(text), err
}

var RE_PLATE *regexp.Regexp

func init() {
	RE_PLATE = regexp.MustCompile(`^[A-Z]{3}-\d{4}$`)
}

func (p *Plate) IsValid() bool {
	return RE_PLATE.Match([]byte(*p))
}

func (p *Plate) AllowedDayOfWeek() int {
	s := string(*p)
	if strings.HasSuffix(s, "1") || strings.HasSuffix(s, "2") {
		return 0
	} else if strings.HasSuffix(s, "3") || strings.HasSuffix(s, "4") {
		return 1
	} else if strings.HasSuffix(s, "5") || strings.HasSuffix(s, "6") {
		return 2
	} else if strings.HasSuffix(s, "7") || strings.HasSuffix(s, "8") {
		return 3
	} else if strings.HasSuffix(s, "9") || strings.HasSuffix(s, "0") {
		return 4
	} else {
		return -1
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	plateCount, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < plateCount; i++ {
		plate, err := NextPlate(scanner)
		if err != nil {
			panic(err)
		}

		if plate.IsValid() {
			switch plate.AllowedDayOfWeek() {
			case 0:
				fmt.Println("MONDAY")
			case 1:
				fmt.Println("TUESDAY")
			case 2:
				fmt.Println("WEDNESDAY")
			case 3:
				fmt.Println("THURSDAY")
			case 4:
				fmt.Println("FRIDAY")
			}
		} else {
			fmt.Println("FAILURE")
		}
	}
}
