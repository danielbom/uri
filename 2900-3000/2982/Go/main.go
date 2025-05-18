package main

import (
  "bufio"
  "fmt"
  "os"
  "strconv"
)

func NextWord(scanner *bufio.Scanner) (string, error) {
  if !scanner.Scan() {
    return "", fmt.Errorf("missing word")
  }
  return scanner.Text(), nil
}

func NextInt(scanner *bufio.Scanner) (int, error) {
  if !scanner.Scan() {
    return 0, fmt.Errorf("missing integer")
  }
  return strconv.Atoi(scanner.Text())
}

func NextPair(scanner *bufio.Scanner) (string, int, error) {
  fst, err := NextWord(scanner)
  if err != nil {
    return "", 0, err
  }
  snd, err := NextInt(scanner)
  return fst, snd, err
}

func main() {
  scanner := bufio.NewScanner(os.Stdin)
  scanner.Split(bufio.ScanWords)

  n, err := NextInt(scanner)
  if err != nil {
    panic("missing N")
  }

  result := 0
  for i := 0; i < n; i++ {
    resource, value, err := NextPair(scanner)
    if err != nil {
      panic("invalid pair or T,C")
    }
    switch resource {
    case "V": // government grant
      result += value
    case "G": // university expense
      result -= value
    default:
      panic("unknown resource")
    }
  }
  if result > 0 {
    fmt.Println("A greve vai parar.")
  } else {
    fmt.Println("NAO VAI TER CORTE, VAI TER LUTA!")
  }
}
