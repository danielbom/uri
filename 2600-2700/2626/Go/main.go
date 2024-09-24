package main

import (
	"bufio"
	"fmt"
	"os"
)

type Play int

const (
	PLAY_EMPTY Play = iota
	PLAY_ROCK
	PLAY_PAPPER
	PLAY_SCISSOR
)

const (
	DODO_WIN   = "Os atributos dos monstros vao ser inteligencia, sabedoria..."
	LEO_WIN    = "Iron Maiden's gonna get you, no matter how far!"
	PEPPER_WIN = "Urano perdeu algo muito precioso..."
	TIE        = "Putz vei, o Leo ta demorando muito pra jogar..."
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

func NextPlay(scanner *bufio.Scanner) (Play, error) {
	word, err := NextWord(scanner)
	if err != nil {
		return PLAY_EMPTY, err
	}
	if word == "pedra" {
		return PLAY_ROCK, nil
	}
	if word == "papel" {
		return PLAY_PAPPER, nil
	}
	if word == "tesoura" {
		return PLAY_SCISSOR, nil
	}
	return PLAY_EMPTY, fmt.Errorf("invalid play format")
}

func NextTriple(scanner *bufio.Scanner) (Play, Play, Play, error) {
	_1, err := NextPlay(scanner)
	if err != nil {
		return PLAY_EMPTY, PLAY_EMPTY, PLAY_EMPTY, err
	}
	_2, err := NextPlay(scanner)
	if err != nil {
		return PLAY_EMPTY, PLAY_EMPTY, PLAY_EMPTY, err
	}
	_3, err := NextPlay(scanner)
	if err != nil {
		return PLAY_EMPTY, PLAY_EMPTY, PLAY_EMPTY, err
	}
	return _1, _2, _3, nil
}

func RockPaperScissorWinner(play1, play2 Play) bool {
	if play1 == PLAY_ROCK && play2 == PLAY_SCISSOR {
		return true
	}
	if play1 == PLAY_PAPPER && play2 == PLAY_ROCK {
		return true
	}
	if play1 == PLAY_SCISSOR && play2 == PLAY_PAPPER {
		return true
	}
	return false
}

func RockPaperScissorWinner3(play1, play2, play3 Play) int {
	if play1 == play2 && play2 == play3 {
		return 0
	}
	if RockPaperScissorWinner(play1, play2) && RockPaperScissorWinner(play1, play3) {
		return 1
	}
	if RockPaperScissorWinner(play2, play1) && RockPaperScissorWinner(play2, play3) {
		return 2
	}
	if RockPaperScissorWinner(play3, play1) && RockPaperScissorWinner(play3, play2) {
		return 3
	}
	return 0
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for {
		play1, play2, play3, err := NextTriple(scanner)
		if err != nil {
			break
		}

		winner := RockPaperScissorWinner3(play1, play2, play3)
		switch winner {
		case 0:
			fmt.Println(TIE)
		case 1:
			fmt.Println(DODO_WIN)
		case 2:
			fmt.Println(LEO_WIN)
		case 3:
			fmt.Println(PEPPER_WIN)
		}
	}
}
