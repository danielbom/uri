package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

func NextFloat(scanner *bufio.Scanner) (float64, error) {
	scanner.Scan()
	err := scanner.Err()
	if err != nil {
		return 0.0, err
	}
	text := scanner.Text()
	if text == "" {
		return 0.0, fmt.Errorf("empty scanner")
	}
	return strconv.ParseFloat(text, 32)
}

type Time struct {
	Hours   int
	Minutes int
	Seconds int
}

const SECONDS_1_DAY = 24 * 60 * 60

func TimeFromAngle(angle float64) Time {
	totalSeconds := int(math.Floor(SECONDS_1_DAY * angle / 360.0))
	seconds := totalSeconds % 60
	totalMinutes := totalSeconds / 60
	minutes := totalMinutes % 60
	totalHours := totalMinutes / 60
	return Time{Hours: (totalHours + 6) % 24, Minutes: minutes, Seconds: seconds}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for {
		angle, err := NextFloat(scanner)
		if err != nil {
			break
		}

		time := TimeFromAngle(angle)

		if time.Hours < 6 {
			fmt.Println("De Madrugada!!")
		} else if time.Hours < 12 {
			fmt.Println("Bom Dia!!")
		} else if time.Hours < 18 {
			fmt.Println("Boa Tarde!!")
		} else if time.Hours < 24 {
			fmt.Println("Boa Noite!!")
		}

		fmt.Printf("%02d:%02d:%02d\n", time.Hours, time.Minutes, time.Seconds)
	}
}
