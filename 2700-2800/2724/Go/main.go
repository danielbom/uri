package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
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

type Atom struct {
	Name  string
	Count int
}

type Compound []Atom

var RE_ATOM *regexp.Regexp

func init() {
	RE_ATOM = regexp.MustCompile(`([A-Z][a-z]?)(\d*)`)
}

func NewCompound(atomsSequence string) (Compound, error) {
	compound := make(Compound, 0)
	for _, groups := range RE_ATOM.FindAllStringSubmatch(atomsSequence, -1) {
		count := 1
		if groups[2] != "" {
			parsedCount, err := strconv.Atoi(groups[2])
			if err != nil {
				panic(fmt.Errorf("unexpected error: " + err.Error()))
			}
			count = parsedCount
		}
		if count == 0 {
			return nil, fmt.Errorf("invalid atom")
		}
		atom := Atom{Name: groups[1], Count: count}
		compound = append(compound, atom)
	}
	if len(compound) == 0 {
		return nil, fmt.Errorf("empty compound")
	}
	return compound, nil
}

func (compound Compound) Contains(other Compound) bool {
	lenOther := len(other)
	lenCompound := len(compound)
	for i := 0; i+lenOther <= lenCompound; i++ {
		if compound[i].Name == other[0].Name {
			if compound[i].Count < other[0].Count {
				continue
			}
			if compound[i].Count%other[0].Count != 0 {
				continue
			}
			ratio := compound[i].Count / other[0].Count
			proportional := true
			for j := 1; j < lenOther; j++ {
				if compound[i+j].Name != other[j].Name || compound[i+j].Count != other[j].Count*ratio {
					proportional = false
					break
				}
			}
			if proportional {
				return true
			}
		}
	}
	return false
}

func NextCompound(scanner *bufio.Scanner) (Compound, error) {
	compound, err := NextWord(scanner)
	if err != nil {
		return nil, err
	}
	return NewCompound(compound)
}

func IsDangerousCompound(experimentalCompound Compound, dangerousCompounds []Compound) bool {
	for _, c := range dangerousCompounds {
		if experimentalCompound.Contains(c) {
			return true
		}
	}
	return false
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	tests, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < tests; i++ {
		dangerousCompoundsCount, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		dangerousCompounds := make([]Compound, dangerousCompoundsCount)
		for j := 0; j < dangerousCompoundsCount; j++ {
			dangerousCompound, err := NextCompound(scanner)
			if err != nil {
				panic(err)
			}

			dangerousCompounds[j] = dangerousCompound
		}

		experimentalCompoundsCount, err := NextInt(scanner)

		for j := 0; j < experimentalCompoundsCount; j++ {
			experimentalCompound, err := NextCompound(scanner)
			if err != nil {
				panic(err)
			}

			if IsDangerousCompound(experimentalCompound, dangerousCompounds) {
				fmt.Println("Abortar")
			} else {
				fmt.Println("Prossiga")
			}
		}

		if i+1 != tests {
			fmt.Println()
		}
	}
}
