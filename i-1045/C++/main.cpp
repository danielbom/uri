// https://www.urionlinejudge.com.br/judge/en/problems/view/1041
#include <iostream>
#include <math.h>

template<typename T>
void swap(T & x, T & y) {
  T z = x;
  x = y;
  y = z;
}

enum TriangleType {
  Invalid,
  Retangle,
  Obtusangle,
  Acutangle
};

struct Triangle {
  double x;
  double y;
  double z;

  friend std::istream& operator >> (std::istream& in, Triangle &t) {
    in >> t.x >> t.y >> t.z;
    return in;
  }

  bool _valid(double x, double y, double z) {
    return abs(x - y) < z && z < x + y;
  }

  TriangleType get_type() {
    double x = this->x;
    double y = this->y;
    double z = this->z;
    double s;

    if (x > y) swap(x, y);
    if (x > z) swap(x, z);
    if (y > z) swap(y, z);

    if (z >= x + y) {
      return TriangleType::Invalid;
    } else {
      x = x * x;
      y = y * y;
      z = z * z;
      s = x + y;
      if (z > s) return TriangleType::Obtusangle;
      if (z < s) return TriangleType::Acutangle;
      return TriangleType::Retangle;
    }
  }

  bool is_equilateral() {
    return this->x == this->y && this->y == this->z;
  }
};

int main() {
  Triangle t;
  std::cin >> t;

  switch (t.get_type())
  {
  case TriangleType::Invalid:
    std::cout << "NAO FORMA TRIANGULO" << std::endl;
    break;
  case TriangleType::Retangle:
    std::cout << "TRIANGULO RETANGULO" << std::endl;
    break;
  case TriangleType::Obtusangle:
    std::cout << "TRIANGULO OBTUSANGULO" << std::endl;
    if (t.is_equilateral()) {
      std::cout << "TRIANGULO EQUILATERO" << std::endl;
    } else {
      std::cout << "TRIANGULO ISOSCELES" << std::endl;
    }
    break;
  case TriangleType::Acutangle:
    std::cout << "TRIANGULO ACUTANGULO" << std::endl;
    if (t.is_equilateral()) {
      std::cout << "TRIANGULO EQUILATERO" << std::endl;
    } else {
      std::cout << "TRIANGULO ISOSCELES" << std::endl;
    }
    break;
  default:
    break;
  }

  return 0;
}
