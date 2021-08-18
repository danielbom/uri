// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
#include <iostream>

std::string ddd_destination(int ddd) {
  switch (ddd)
  {
  case 61: return "Brasilia";
  case 71: return "Salvador";
  case 11: return "Sao Paulo";
  case 21: return "Rio de Janeiro";
  case 32: return "Juiz de Fora";
  case 19: return "Campinas";
  case 27: return "Vitoria";
  case 31: return "Belo Horizonte";
  }
  return "DDD nao cadastrado";
}

int main() {
  int ddd;
  std::cin >> ddd;
  std::cout << ddd_destination(ddd) << std::endl;
  return 0;
}
