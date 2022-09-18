// https://www.urionlinejudge.com.br/judge/en/problems/view/1016
#include <iostream>

const double kmByLitters = 12.0;

int main() {
  double hours; // h
  double velocity; // km/h
  double distance; // km
  double litersNeeded; // L

  std::cin >> hours;
  std::cin >> velocity;

  distance = velocity * hours;
  litersNeeded = distance / kmByLitters;

  std::cout.precision(3);
  std::cout << std::fixed << litersNeeded << std::endl;

  return 0;
}
