// https://www.urionlinejudge.com.br/judge/en/problems/view/1010
#include <iostream>

struct Product {
  int code;
  int units;
  float price;

  friend std::istream& operator >> (std::istream& in, Product &p) {
    in >> p.code >> p.units >> p.price;
    return in;
  }

  float total() {
    return this->price * this->units;
  }
};

int main() {
  Product p1, p2;
  std::cin >> p1 >> p2;

  float total = p1.total() + p2.total();
  std::cout.precision(2);
  std::cout << std::fixed << "VALOR A PAGAR: R$ " << total << std::endl;

  return 0;
}
