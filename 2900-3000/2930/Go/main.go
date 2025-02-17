package main

import (
	"fmt"
)

func main() {
	var verificationDay, deadlineDay int 
	fmt.Scanf("%d %d", &verificationDay, &deadlineDay)

	if verificationDay > deadlineDay {
		fmt.Println("Eu odeio a professora!")
		return
	}
	if verificationDay + 3 <= deadlineDay {
		fmt.Println("Muito bem! Apresenta antes do Natal!")
		return
	}

	fmt.Println("Parece o trabalho do meu filho!")
	if deadlineDay + 2 <= 24 {
		fmt.Println("TCC Apresentado!")
	} else {
		fmt.Println("Fail! Entao eh nataaaaal!")
	}
}
