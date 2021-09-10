// https://www.urionlinejudge.com.br/judge/en/problems/view/1117
#include <iostream>

int main() {
  double x;
  double sum = 0.0;
  int count = 0;
  
  while (count < 2) {
    std::cin >> x;
    if (0 <= x && x <= 10) {
      sum += x;
      count++;
    } else {
      std::cout << "nota invalida" << std::endl;
    }
  }

  double avg = sum / 2.0;
  std::cout << "media = " << avg << std::endl;

  return 0;
}
