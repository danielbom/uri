// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
#include <iostream>

int main() {
  unsigned int start;
  std::cin >> start;

  start += start % 2 == 0 ? 1 : 2;

  for (int i = 0; i < 6; i++) {
    std::cout << start << std::endl;
    start += 2;
  }

  return 0;
}
