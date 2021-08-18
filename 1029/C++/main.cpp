// https://www.urionlinejudge.com.br/judge/en/problems/view/1019
#include <iostream>

typedef struct {
  int calls;
  int ones;
} FibCount;

FibCount fib_count(int x) {
  FibCount a = { .calls = 1, .ones = 0 };
  FibCount b = { .calls = 1, .ones = 1 };
  FibCount c;

  if (x <= 0) return a;
  if (x == 1) return b;

  for (int i = 1; i < x; i++) {
    c.calls = a.calls + b.calls + 1;
    c.ones = a.ones + b.ones;
    a = b;
    b = c;
  }

  b.calls--;
  return b;
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
