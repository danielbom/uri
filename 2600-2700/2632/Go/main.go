package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type SpellSpec struct {
	Type   string
	Damage int
	Radius [3]int
}

var spellsTable = []SpellSpec{
	// Um meteoro é conjurado para eliminar as unidades inimigas com o calor do fogo
	SpellSpec{"fire", 200, [3]int{20, 30, 50}},
	// Uma tsunami arrasta os inimigos com a força da água
	SpellSpec{"water", 300, [3]int{10, 25, 40}},
	// Um terremoto abala as unidades inimigas, causando dano massivo
	SpellSpec{"earth", 400, [3]int{25, 55, 70}},
	// Um tornado mina as forças inimigas com a velocidade do ar
	SpellSpec{"air", 100, [3]int{18, 38, 60}},
}

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

type Enemy struct {
	Width  int
	Height int
	X0     int
	Y0     int
}

func NextEnemy(scanner *bufio.Scanner) (Enemy, error) {
	width, err := NextInt(scanner)
	if err != nil {
		return Enemy{}, err
	}
	height, err := NextInt(scanner)
	if err != nil {
		return Enemy{}, err
	}
	x0, err := NextInt(scanner)
	if err != nil {
		return Enemy{}, err
	}
	y0, err := NextInt(scanner)
	if err != nil {
		return Enemy{}, err
	}
	return Enemy{Width: width, Height: height, X0: x0, Y0: y0}, nil
}

type Spell struct {
	Spec  *SpellSpec
	Level int
	CX    int
	CY    int
}

func NextSpell(scanner *bufio.Scanner) (Spell, error) {
	spellType, err := NextWord(scanner)
	if err != nil {
		return Spell{}, err
	}
	level, err := NextInt(scanner)
	if err != nil {
		return Spell{}, err
	}
	if level < 1 || level > 3 {
		return Spell{}, fmt.Errorf("invalid spell level")
	}
	cx, err := NextInt(scanner)
	if err != nil {
		return Spell{}, err
	}
	cy, err := NextInt(scanner)
	if err != nil {
		return Spell{}, err
	}
	for _, spec := range spellsTable {
		if spec.Type == spellType {
			return Spell{Spec: &spec, Level: level, CX: cx, CY: cy}, nil
		}
	}
	return Spell{}, fmt.Errorf("invalid spell type")
}

func (s *Spell) Radius() int {
	return s.Spec.Radius[s.Level-1]
}

func (s *Spell) Damage() int {
	return s.Spec.Damage
}

func PointInCircle(x, y, cx, cy, r int) bool {
	dx := x - cx
	dy := y - cy
	return dx*dx+dy*dy <= r*r
}

// https://algo.monster/liteproblems/1401
func distanceToEdge(min, max, center int) int {
	if min <= center && center <= max {
		return 0
	}
	if center < min {
		return min - center
	}
	return center - max
}

func SpellIntersectEnemy(circle *Spell, rect *Enemy) bool {
	radius := circle.Radius()
	x1, y1 := rect.X0, rect.Y0
	x2, y2 := x1+rect.Width, y1+rect.Height
	dx := distanceToEdge(x1, x2, circle.CX)
	dy := distanceToEdge(y1, y2, circle.CY)
	return dx*dx+dy*dy <= radius*radius
}

func ComputeDamage(spell *Spell, enemy *Enemy) int {
	if SpellIntersectEnemy(spell, enemy) {
		return spell.Damage()
	}
	return 0
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	n, err := NextInt(scanner)
	if err != nil {
		panic(err)
	}

	for i := 0; i < n; i++ {
		enemy, err := NextEnemy(scanner)
		if err != nil {
			panic(err)
		}

		spell, err := NextSpell(scanner)
		if err != nil {
			panic(err)
		}

		damage := ComputeDamage(&spell, &enemy)
		fmt.Println(damage)
	}
}
