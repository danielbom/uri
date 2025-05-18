package main

import "fmt"

func main() {
  a := int('A')
  var c rune
  fmt.Scanf("%c", &c)
  fmt.Println(int(c) - a + 1)
}
