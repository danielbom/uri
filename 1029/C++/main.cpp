// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
#include <iostream>
#include <map>

typedef struct {
  int calls;
  int ones;
} FibCount;

using FibMemo = std::map<int, FibCount>;

FibCount _fib_count_rec(int a, FibMemo &memo) {
  if (memo.count(a) > 0) return memo.at(a);
  FibCount x = _fib_count_rec(a - 1, memo);
  FibCount y = _fib_count_rec(a - 2, memo);
  memo[a] = {
    .calls = x.calls + y.calls + 1,
    .ones = x.ones + y.ones
  };
  return memo[a];
}

FibCount fib_count(int a) {
  FibMemo memo;
  memo[0] = { .calls = 1, .ones = 0 };
  memo[1] = { .calls = 1, .ones = 1 };
  FibCount result = _fib_count_rec(a, memo);
  result.calls--;
  return result;
}

int main() {
  int n, x;
  FibCount result;
  std::cin >> n;

  while (n-- > 0) {
    std::cin >> x;
    result = fib_count(x);
    std::cout << "fib(" << x << ") = " << result.calls << " calls = " << result.ones << std::endl;
  }

  return 0;
}
