// https://www.urionlinejudge.com.br/judge/en/problems/view/1012
#include <iostream>

int max(int a, int b) {
  return (a + b + abs(a - b)) / 2;
}

int main() {
  int a, b, c;
  std::cin >> a >> b >> c;

  int biggest = max(max(a, b), c);
  std::cout << biggest << " eh o maior" << std::endl;
  
  return 0;
}
