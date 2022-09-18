// https://www.urionlinejudge.com.br/judge/en/problems/view/1019
#include <iostream>

int main() {
  int x;
  
  std::cin >> x;

  int ss = x % 60;
  x = x / 60;
  int MM = x % 60;
  x = x / 60;
  int hh = x;

  std::cout << hh << ":" << MM << ":" << ss << std::endl;

  return 0;
}
