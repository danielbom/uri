package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func ReadLine(reader *bufio.Reader) string {
	line, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return strings.TrimSpace(line)
}

type PlayerStats struct {
	Name               string
	TotalServices      int
	TotalBlocks        int
	TotalAttacks       int
	SuccessfulServices int
	SuccessfulBlocks   int
	SuccessfulAttacks  int
}

func PlayerStatsScan(reader *bufio.Reader) PlayerStats {
	var totalServices int
	var totalBlocks int
	var totalAttacks int
	var successfulServices int
	var successfulBlocks int
	var successfulAttacks int
	name := ReadLine(reader)
	totals := ReadLine(reader)
	successfuls := ReadLine(reader)

	_, err := fmt.Sscanf(totals, "%d %d %d", &totalServices, &totalBlocks, &totalAttacks)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	_, err = fmt.Sscanf(successfuls, "%d %d %d", &successfulServices, &successfulBlocks, &successfulAttacks)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	return PlayerStats{
		Name:               name,
		TotalServices:      totalServices,
		TotalBlocks:        totalBlocks,
		TotalAttacks:       totalAttacks,
		SuccessfulServices: successfulServices,
		SuccessfulBlocks:   successfulBlocks,
		SuccessfulAttacks:  successfulAttacks,
	}
}

func PlayerStatsReduce(acc *PlayerStats, curr *PlayerStats) {
	acc.TotalServices += curr.TotalServices
	acc.TotalBlocks += curr.TotalBlocks
	acc.TotalAttacks += curr.TotalAttacks
	acc.SuccessfulServices += curr.SuccessfulServices
	acc.SuccessfulBlocks += curr.SuccessfulBlocks
	acc.SuccessfulAttacks += curr.SuccessfulAttacks
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	numberOfPlayersLine := ReadLine(reader)
	numberOfPlayers, err := strconv.Atoi(numberOfPlayersLine)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	acc := PlayerStats{
		Name:               "Sum",
		TotalServices:      0,
		TotalBlocks:        0,
		TotalAttacks:       0,
		SuccessfulServices: 0,
		SuccessfulBlocks:   0,
		SuccessfulAttacks:  0,
	}

	for i := 0; i < numberOfPlayers; i++ {
		player := PlayerStatsScan(reader)
		PlayerStatsReduce(&acc, &player)
	}

	servicePoints := float32(acc.SuccessfulServices) / float32(acc.TotalServices) * 100.0
	blockPoints := float32(acc.SuccessfulBlocks) / float32(acc.TotalBlocks) * 100.0
	attackPoints := float32(acc.SuccessfulAttacks) / float32(acc.TotalAttacks) * 100.0
	fmt.Printf("Pontos de Saque: %.2f %%.\n", servicePoints)
	fmt.Printf("Pontos de Bloqueio: %.2f %%.\n", blockPoints)
	fmt.Printf("Pontos de Ataque: %.2f %%.\n", attackPoints)
}
