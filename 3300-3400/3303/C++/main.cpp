// https://www.urionlinejudge.com.br/judge/en/problems/view/3303
#include <iostream>

int main() {
  std::string str;
  std::cin >> str;

  if (str.length() >= 10) {
    std::cout << "palavrao" << std::endl;
  } else {
    std::cout << "palavrinha" << std::endl;
  }

  return 0;
}
