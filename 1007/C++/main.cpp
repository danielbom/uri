// https://www.urionlinejudge.com.br/judge/en/problems/view/1007
#include <iostream>

int main() {
  int a, b, c, d, result;
  std::cin >> a >> b >> c >> d;
  result = a * b - c * d;
  std::cout << "DIFERENCA = " << result << std::endl;
  return 0;
}
