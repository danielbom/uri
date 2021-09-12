// https://www.urionlinejudge.com.br/judge/en/problems/view/1014
#include <iostream>

int main() {
  int km;
  float spentFuel;

  std::cin >> km;
  std::cin >> spentFuel;

  float kmByFuel = km / spentFuel;
  std::cout.precision(3);
  std::cout << std::fixed << kmByFuel << " km/l" << std::endl;
  return 0;
}
