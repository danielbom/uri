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

func NextInts(scanner *bufio.Scanner, n int) ([]int, error) {
	result := make([]int, n)
	for i := 0; i < n; i++ {
		value, err := NextInt(scanner)
		if err != nil {
			return nil, err
		}
		result[i] = value
	}
	return result, nil
}

type ProblemAssemblies struct {
	Enter1       int
	Steps1       []int
	Switches_1_2 []int
	Exit1        int
	Enter2       int
	Steps2       []int
	Switches_2_1 []int
	Exit2        int
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

func (p ProblemAssemblies) Solve() int {
	n := len(p.Steps1)
	g := NewGraph(2*(1+n+1) + 2*(n-1))
	g.Add(0, 1, p.Enter1)
	g.Add(0, 2, p.Enter2)
	const sortedByLevel = true
	if sortedByLevel {
		// Keeping the graph sorted by level decreases the amount of changing iterations to solve the problem
		// But, for debugging purposes, unsorted data is easy to read
		for i := 0; i < n; i++ {
			g.Add(1+(i*2), 1+((i+1)*2), p.Steps1[i])
			g.Add(2+(i*2), 2+((i+1)*2), p.Steps2[i])
			i := i + 1
			if i < n {
				g.Add(1+(i*2), 2+(i*2), p.Switches_1_2[i-1])
				g.Add(2+(i*2), 1+(i*2), p.Switches_2_1[i-1])
			}
		}
	} else {
		for i := 0; i < n; i++ {
			g.Add(1+(i*2), 1+((i+1)*2), p.Steps1[i])
		}
		for i := 0; i < n; i++ {
			g.Add(2+(i*2), 2+((i+1)*2), p.Steps2[i])
		}
		for i := 1; i < n; i++ {
			g.Add(1+(i*2), 2+(i*2), p.Switches_1_2[i-1])
		}
		for i := 1; i < n; i++ {
			g.Add(2+(i*2), 1+(i*2), p.Switches_2_1[i-1])
		}
	}
	g.Add(1+(n*2), 1+((n+1)*2), p.Exit1)
	g.Add(2+(n*2), 1+((n+1)*2), p.Exit2)
	return g.ShortestDistance(0, 1+((n+1)*2))
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		stepsCount, err := NextInt(scanner)
		if err != nil {
			break
		}

		enter1, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		enter2, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		steps1, err := NextInts(scanner, stepsCount)
		if err != nil {
			panic(err)
		}

		steps2, err := NextInts(scanner, stepsCount)
		if err != nil {
			panic(err)
		}

		switches_1_2, err := NextInts(scanner, stepsCount-1)
		if err != nil {
			panic(err)
		}
		switches_2_1, err := NextInts(scanner, stepsCount-1)
		if err != nil {
			panic(err)
		}

		exit1, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		exit2, err := NextInt(scanner)
		if err != nil {
			panic(err)
		}

		problem := ProblemAssemblies{
			Enter1:       enter1,
			Steps1:       steps1,
			Switches_1_2: switches_1_2,
			Exit1:        exit1,

			Enter2:       enter2,
			Steps2:       steps2,
			Switches_2_1: switches_2_1,
			Exit2:        exit2,
		}

		fmt.Println(problem.Solve())
	}
}
