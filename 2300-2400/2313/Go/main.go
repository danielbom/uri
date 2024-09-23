package main

import (
	"bufio"
	"fmt"
	"os"
)

type Triangle struct {
	A int
	B int
	C int
}

func TriangleScan(reader *bufio.Reader) (Triangle, error) {
	line, err := reader.ReadString('\n')
	if err != nil {
		return Triangle{}, err
	}

	var a, b, c int
	n, err := fmt.Sscanf(line, "%d %d %d", &a, &b, &c)
	if err != nil {
		return Triangle{}, err
	}
	if n != 3 {
		return Triangle{}, fmt.Errorf("3 integers not found")
	}

	if a > b && a > c {
		max := a
		a = c
		c = max
	}
	if b > a && b > c {
		max := b
		b = c
		c = max
	}
	if a > b {
		mid := a
		a = b
		b = mid
	}

	return Triangle{A: a, B: b, C: c}, nil
}

func (t *Triangle) IsValid() bool {
	return t.A+t.B > t.C
}

func (t *Triangle) IsRectangle() bool {
	return t.A*t.A+t.B*t.B == t.C*t.C
}

func (t *Triangle) Kind() string {
	if t.A == t.B && t.B == t.C {
		return "Equilatero"
	}
	if t.A < t.B && t.B < t.C {
		return "Escaleno"
	}
	return "Isoceles"
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	triangle, err := TriangleScan(reader)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	if triangle.IsValid() {
		fmt.Printf("Valido-%s\n", triangle.Kind())
		if triangle.IsRectangle() {
			fmt.Println("Retangulo: S")
		} else {
			fmt.Println("Retangulo: N")
		}
	} else {
		fmt.Println("Invalido")
	}
}
