// https://www.urionlinejudge.com.br/judge/en/problems/view/1011
#include <iostream>

const double PI = 3.14159;

int main() {
  double radius;
  std::cin >> radius;

  double volume = (4.0/3.0) * PI * (radius * radius * radius);
  std::cout.precision(3);
  std::cout << std::fixed << "VOLUME = " << volume << std::endl;
  return 0;
}
