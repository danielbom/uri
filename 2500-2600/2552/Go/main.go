package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func ReadLineAsPair(scanner *bufio.Scanner) (int, int, error) {
	if !scanner.Scan() {
		return 0, 0, fmt.Errorf("invalid pair format")
	}
	x, err := strconv.Atoi(scanner.Text())
	if err != nil {
		return 0, 0, err
	}
	more := scanner.Scan()
	err = scanner.Err()
	if !more && err != nil {
		return 0, 0, err
	}
	y, err := strconv.Atoi(scanner.Text())
	if err != nil {
		return 0, 0, err
	}
	return x, y, nil
}

type Matrix struct {
	Data [][]int
}

func NewMatrix(rows, cols int) Matrix {
	data := make([][]int, rows)
	for i := 0; i < rows; i++ {
		data[i] = make([]int, cols)
	}
	return Matrix{Data: data}
}

func (m *Matrix) Rows() int {
	return len(m.Data)
}

func (m *Matrix) Cols() int {
	return len(m.Data[0])
}

func ReadBoard(scanner *bufio.Scanner, rows, cols int) (Matrix, error) {
	matrix := NewMatrix(rows, cols)
	for y := 0; y < rows; y++ {
		for x := 0; x < cols; x++ {
			more := scanner.Scan()
			err := scanner.Err()
			if !more && err != nil {
				return Matrix{}, nil
			}

			value := scanner.Text()
			if value == "1" {
				matrix.Data[y][x] = 1
			} else if value == "0" {
				matrix.Data[y][x] = 0
			} else {
				return Matrix{}, fmt.Errorf("invalid matrix 0s 1s format")
			}
		}
	}
	return matrix, nil
}

func BoardConfiguration(board Matrix) Matrix {
	configuration := NewMatrix(board.Rows(), board.Cols())
	for y := 0; y < board.Rows(); y++ {
		for x := 0; x < board.Cols(); x++ {
			if board.Data[y][x] == 1 {
				configuration.Data[y][x] = 9
			} else {
				ones := 0
				if y-1 >= 0 && board.Data[y-1][x] == 1 {
					ones++
				}
				if y+1 < board.Rows() && board.Data[y+1][x] == 1 {
					ones++
				}
				if x-1 >= 0 && board.Data[y][x-1] == 1 {
					ones++
				}
				if x+1 < board.Cols() && board.Data[y][x+1] == 1 {
					ones++
				}
				configuration.Data[y][x] = ones
			}
		}
	}
	return configuration
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)
	for {
		rows, cols, err := ReadLineAsPair(scanner)
		if err != nil {
			break
		}

		board, err := ReadBoard(scanner, rows, cols)
		if err != nil {
			panic(err)
		}

		configuration := BoardConfiguration(board)

		for y := 0; y < configuration.Rows(); y++ {
			for x := 0; x < configuration.Cols(); x++ {
				fmt.Print(configuration.Data[y][x])
			}
			fmt.Println()
		}
	}
}
