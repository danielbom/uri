package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type Token int

const (
	TOKEN_NONE Token = iota
	TOKEN_OP
	TOKEN_INT
	TOKEN_OPEN
	TOKEN_CLOSE
)

type TokenFinder interface {
	Find(content string, start int) (Token, int, int)
}

type TokenNumber struct{}

func (tf *TokenNumber) Find(content string, start int) (Token, int, int) {
	end := start
	for _, ch := range content[start:] {
		if !('0' <= ch && ch <= '9') {
			break
		}
		end++
	}
	if end == start {
		return TOKEN_NONE, 0, 0
	}
	return TOKEN_INT, start, end
}

type TokenOp struct{}

func (tf *TokenOp) Find(content string, start int) (Token, int, int) {
	ch := content[start]
	if ch == '+' || ch == '-' || ch == '*' || ch == '/' {
		return TOKEN_OP, start, start + 1
	}
	return TOKEN_NONE, 0, 0
}

type Tokenizer struct {
	content string
	finders []TokenFinder
	current int
	start   int
	end     int
	token   Token
	done    bool
}

func NewTokenizer(content string) Tokenizer {
	finders := make([]TokenFinder, 0, 2)
	finders = append(finders, &TokenNumber{})
	finders = append(finders, &TokenOp{})
	return Tokenizer{
		content: content,
		current: 0,
		start:   0,
		end:     0,
		token:   TOKEN_NONE,
		finders: finders,
		done:    false,
	}
}

func (t *Tokenizer) Scan() bool {
	if t.done {
		return false
	}
	for _, tf := range t.finders {
		if token, start, end := tf.Find(t.content, t.current); start < end {
			t.start = start
			t.end = end
			t.token = token
			t.current = end
			if t.current >= len(t.content) {
				t.done = true
			}
			return true
		}
	}
	t.done = true
	return false
}

func (t *Tokenizer) Text() string {
	if t.start < t.end {
		return t.content[t.start:t.end]
	}
	return "???"
}

type TokenSlice struct {
	token Token
	text string
}

func ExpressionToInfixTokens(infixExpression string) []TokenSlice {
	tokens := make([]TokenSlice, 0)
	tk := NewTokenizer(infixExpression)
	for tk.Scan() {
		tokens = append(tokens, TokenSlice{
			token: tk.token,
			text: tk.Text(),
		})
	}
	return tokens
}

func precedence(t TokenSlice) int {
	if t.token == TOKEN_OP {
		if t.text == "+" || t.text == "-" {
			return 1
		} else if t.text == "*" || t.text == "/" {
			return 2
		}
	}
	return 0
}

// https://github.com/xTecna/solucoes-da-beecrowd/tree/main/base-teorica/algoritmos-raros/shunting-yard
func InfixToPostfixTokens(infixTokens []TokenSlice) []TokenSlice {
	result := make([]TokenSlice, 0, len(infixTokens))
	stack := make([]TokenSlice, 0, len(infixTokens))
	for _, t := range infixTokens {
		switch t.token {
		case TOKEN_INT:
			result = append(result, t)
		case TOKEN_OPEN:
			stack = append(stack, t)
		case TOKEN_CLOSE:
			for len(stack) > 0 {
				top := stack[len(stack)-1]
				if top.token != TOKEN_OPEN {
					result = append(result, top)
				} else {
					break
				}
				stack = stack[:len(stack)-1]
			}
			if len(stack) > 0 {
				stack = stack[:len(stack)-1]
			}
		case TOKEN_OP:
			for len(stack) > 0 {
				top := stack[len(stack)-1]
				if top.token == TOKEN_OPEN {
					break
				}
				if precedence(t) > precedence(top) {
					break
				}
				result = append(result, top)
				stack = stack[:len(stack)-1]
			}
			stack = append(stack, t)
		}
	}
	for len(stack) > 0 {
		result = append(result, stack[len(stack)-1])
		stack = stack[:len(stack)-1]
	}
	return result
}

func ExecutePostfixTokens(infixTokens []TokenSlice) int {
	stack := make([]int, 0, 2)
	for _, t := range infixTokens {
		switch t.token {
		case TOKEN_INT:
			number, err := strconv.Atoi(t.text)
			if err != nil {
				panic(err)
			}
			stack = append(stack, number)
		case TOKEN_OP:
			switch t.text {
			case "+":
				rhs := stack[len(stack)-1]
				lhs := stack[len(stack)-2]
				stack = stack[:len(stack)-2]
				stack = append(stack, lhs + rhs)
			case "-":
				rhs := stack[len(stack)-1]
				lhs := stack[len(stack)-2]
				stack = stack[:len(stack)-2]
				stack = append(stack, lhs - rhs)
			default:
				panic("unknown operation")
			}
		default:
			panic("unknown token")
		}
	}
	if len(stack) == 1 {
		return stack[0]
	}
	return 0
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for i:=1; scanner.Scan(); i++ {
		if scanner.Text() == "0" {
			break
		}
		if !scanner.Scan() {
			panic("missing expression")
		}
		infixExpression := scanner.Text()
		infixTokens := ExpressionToInfixTokens(infixExpression)
		postfixTokens := InfixToPostfixTokens(infixTokens)
		fmt.Printf("Teste %d\n", i)
		fmt.Println(ExecutePostfixTokens(postfixTokens))
		fmt.Println()
	}
}
