package main

import (
	"bufio"
	"fmt"
	"math"
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

func NextFloat(scanner *bufio.Scanner) (float64, error) {
	text, err := NextWord(scanner)
	if err != nil {
		return 0, err
	}
	return strconv.ParseFloat(text, 64)
}

func Mean(values []float64) float64 {
	sum := 0.0
	for _, x := range values {
		sum += x
	}
	return sum / float64(len(values))
}

func SensorAccuracy(temperatures []float64) float64 {
	mean := Mean(temperatures)
	squaredSum := 0.0
	for _, temp := range temperatures {
		diff := temp - mean
		squaredSum += diff * diff
	}
	return math.Sqrt(squaredSum / float64(len(temperatures)-1))
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		hoursTesting, err := NextInt(scanner)
		if err != nil {
			break
		}
		minutesPerTest, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		testsCount := int((hoursTesting * 60) / minutesPerTest)

		temperatures := make([]float64, testsCount)
		for i := 0; i < testsCount; i++ {
			temperature, err := NextFloat(scanner)
			if err != nil {
				panic(err)
			}
			temperatures[i] = temperature
		}

		fmt.Printf("%.5f\n", SensorAccuracy(temperatures))
	}
}
