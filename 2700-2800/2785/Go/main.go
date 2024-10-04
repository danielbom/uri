package main

import (
	"bufio"
	"fmt"
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

func NextMatrix(scanner *bufio.Scanner, n int) ([][]int, error) {
	matrix := make([][]int, n)
	for i := 0; i < n; i++ {
		matrix[i] = make([]int, n)
		for j := 0; j < n; j++ {
			value, err := NextInt(scanner)
			if err != nil {
				return nil, err
			}
			matrix[i][j] = value
		}
	}
	return matrix, nil
}

type Graph struct {
	Edges [][3]int
	Count int
}

func NewGraph(n int) Graph {
	nodes := make([][3]int, n)
	return Graph{Edges: nodes, Count: 0}
}

func (g *Graph) Add(a, b, d int) {
	g.Edges[g.Count] = [3]int{a, b, d}
	g.Count++
}

func (g Graph) ShortestDistance(a, b int) int {
	maxInt := 0
	maxNode := 0
	for _, edge := range g.Edges {
		if maxNode < edge[0] {
			maxNode = edge[0]
		}
		if maxNode < edge[1] {
			maxNode = edge[1]
		}
		maxInt += edge[2]
	}

	distances := make([]int, maxNode+1)
	for i := 0; i < len(distances); i++ {
		distances[i] = maxInt
	}
	distances[a] = 0

	count := 0
	changed := true
	for changed {
		changed = false
		for _, edge := range g.Edges {
			if distances[edge[1]] > distances[edge[0]]+edge[2] {
				distances[edge[1]] = distances[edge[0]] + edge[2]
				changed = true
			}
		}
		count++
	}

	return distances[b]
}

type TriangleProblem struct {
	n int
}

func NodeId_v0(n, i, j int) int {
	return (i * n) + j + 1
}

func NodeId_v1(n, i, j int) int {
	k := n - (n - i)
	return (i*n - ((k * (k - 1)) / 2)) + j + 1
}

func (p *TriangleProblem) NodeId(i, j int) int {
	return NodeId_v1(p.n, i, j)
}

func (p *TriangleProblem) Solve(matrix [][]int) int {
	n := len(matrix)
	p.n = n

	g := NewGraph(2*n + (n*(n-1))/2 + ((n-1)*((n-1)-1))/2)

	for i := 0; i < n; i++ {
		g.Add(0, i+1, 0)
	}

	for i := 0; i < n; i++ {
		sum := 0
		for j := 0; j <= i; j++ {
			sum += matrix[i][j]
		}

		g.Add(p.NodeId(i+0, 0), p.NodeId(i+1, 0), sum)

		for j := 1; j < n-i; j++ {
			sum = sum - matrix[i][j-1] + matrix[i][j+i]

			if j < n-i-1 {
				g.Add(p.NodeId(i+0, j), p.NodeId(i+1, j), sum)
			}

			g.Add(p.NodeId(i+0, j), p.NodeId(i+1, j-1), sum)
		}
	}

	return g.ShortestDistance(0, p.NodeId(n, 0))
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	matrixSize, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	matrix, err := NextMatrix(scanner, matrixSize)
	if err != nil {
		panic(err)
	}

	var problem TriangleProblem
	fmt.Println(problem.Solve(matrix))
}
