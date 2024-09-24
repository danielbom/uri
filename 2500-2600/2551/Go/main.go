package main

import (
	"bufio"
	"fmt"
	"os"
)

func ReadLine(reader *bufio.Reader) (string, error) {
	return reader.ReadString('\n')
}

func ReadLineAsInt(reader *bufio.Reader) (int, error) {
	var x int
	line, err := ReadLine(reader)
	if err != nil {
		return x, err
	}
	k, err := fmt.Sscanf(line, "%d", &x)
	if err != nil {
		return x, err
	}
	if k != 1 {
		return x, fmt.Errorf("invalid int format")
	}
	return x, nil
}

func ReadLineAsPair(reader *bufio.Reader) (int, int, error) {
	var x, y int
	line, err := ReadLine(reader)
	if err != nil {
		return x, y, err
	}
	k, err := fmt.Sscanf(line, "%d %d", &x, &y)
	if err != nil {
		return x, y, err
	}
	if k != 2 {
		return x, y, fmt.Errorf("invalid pair format")
	}
	return x, y, nil
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	for {
		trainingsCount, err := ReadLineAsInt(reader)
		if err != nil {
			break
		}

		bestVelocityValue := 0.0
		for day := 0; day < trainingsCount; day++ {
			trainingDurationMin, trainingDistanceKm, err := ReadLineAsPair(reader)
			if err != nil {
				panic(err)
			}

			velocity := float64(trainingDistanceKm) / float64(trainingDurationMin)
			if velocity > bestVelocityValue {
				bestVelocityValue = velocity
				fmt.Println(day + 1)
			}
		}
	}
}
