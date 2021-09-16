// https://www.urionlinejudge.com.br/judge/en/problems/view/1016
#include <iostream>

const double speedCarX = 60.0; // km/h
const double speedCarY = 90.0; // km/h
const double diffSpeedCars = speedCarY - speedCarX; // km/h
const double minutesByKm = 60.0 / diffSpeedCars;

int main() {
  double km;

  std::cin >> km;

  double minutes = km * minutesByKm;
  std::cout.precision(0);
  std::cout << std::fixed << minutes << " minutos" << std::endl;

  return 0;
}
