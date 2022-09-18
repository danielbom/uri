// https://www.urionlinejudge.com.br/judge/en/problems/view/1046
#include <iostream>

int main() {
  int start, end, total;

  std::cin >> start >> end;

  if (start == end) {
    total = 24;
  } else if (start < end) {
    total = end - start;
  } else { // if (start > end)
    total = (24 - start) + end;
  }

  std::cout << "O JOGO DUROU " << total << " HORA(S)" << std::endl;

  return 0;
}
