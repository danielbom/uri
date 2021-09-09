// https://www.urionlinejudge.com.br/judge/en/problems/view/1012
#include <iostream>

const double PI = 3.14159;

int main() {
  double a, b, c;
  std::cin >> a >> b >> c;

  std::cout.precision(3);
  std::cout << std::fixed;
  
  double triangle = a * c / 2.0;
  double circle = PI * c * c;
  double trapeze = c * ((a + b) / 2);
  double square = b * b;
  double rectangle = a * b;
  std::cout << "TRIANGULO: " << triangle << std::endl;
  std::cout << "CIRCULO: " << circle << std::endl;
  std::cout << "TRAPEZIO: " << trapeze << std::endl;
  std::cout << "QUADRADO: " << square << std::endl;
  std::cout << "RETANGULO: " << rectangle << std::endl;
  
  return 0;
}
