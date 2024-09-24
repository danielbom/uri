package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func ReadLineAsInt(reader *bufio.Reader) (int, error) {
	line, err := reader.ReadString('\n')
	if err != nil {
		return 0, err
	}
	return strconv.Atoi(strings.TrimSpace(line))
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		clonesCount, err := ReadLineAsInt(reader)
		if err != nil {
			break
		}

		clonesTechniqueCount := int(math.Log2(float64(clonesCount)))
		fmt.Println(clonesTechniqueCount)
	}
}
