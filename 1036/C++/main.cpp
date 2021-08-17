// https://www.urionlinejudge.com.br/judge/en/problems/view/1036
#include <iostream>
#include <math.h>

int main() {
  // Baskhara formula: ax² + bx + c = 0
  // x = (-b +/- sqrt(b² - 4ac)) / 2a
  std::cout.precision(5);
  std::cout << std::fixed;

  double a, b, c, delta, r1, r2, aa;

  std::cin >> a >> b >> c;
  if (std::fabs(a) < 1e-14) 
    goto impossible;

  delta = b * b - 4 * a * c;
  if (delta < 0) 
    goto impossible;

  delta = sqrt(delta);
  aa = 2*a;

  r1 = (-b + delta) / aa;
  r2 = (-b - delta) / aa;

  std::cout << "R1 = " << r1 << std::endl;
  std::cout << "R2 = " << r2 << std::endl;

  return 0;
impossible:
  std::cout << "Impossivel calcular" << std::endl;
  return 0;
}
