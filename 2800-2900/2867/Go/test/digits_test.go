package main

import (
	"testing"
	"math"
	"math/big"
)

func BenchmarkDigitsWithBigInt(b *testing.B) {
	base := new(big.Int)
	exponent := new(big.Int)
	result := new(big.Int)

	for i := 1; i <= 100; i++ {
		for j := 1; j <= 100; j++ {
			base.SetInt64(int64(i))
			exponent.SetInt64(int64(j))
			result.Exp(base, exponent, nil)
			digits := len(result.Exp(base, exponent, nil).String())
			if digits < 0 {
				b.Fail()
			}
		}
	}
}

func BenchmarkDigitsWithFloat64(b *testing.B) {
	for i := 1; i <= 100; i++ {
		for j := 1; j <= 100; j++ {
			base := float64(i)
			exponent := float64(j)
			digits := int(math.Floor(exponent*math.Log10(base)) + 1)
			if digits < 0 {
				b.Fail()
			}
		}
	}
}
