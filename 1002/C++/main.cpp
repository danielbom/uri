// https://www.urionlinejudge.com.br/judge/en/problems/view/1002
#include <iostream>
#include <math.h>

const double PI = 3.14159;

int main() {
  double radius, result;

  std::cin >> radius;
  result = PI * radius * radius;

  std::cout.precision(4);
  std::cout << std::fixed << "A=" << result << std::endl;

  return 0;
}
