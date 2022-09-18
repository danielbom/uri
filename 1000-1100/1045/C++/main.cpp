// https://www.urionlinejudge.com.br/judge/en/problems/view/1045
#include <iostream>
#include <math.h>

template<typename T>
void swap(T & x, T & y) {
  T z = x;
  x = y;
  y = z;
}

template<typename T>
inline bool equals_with_error(T x, T y, T precision) {
  return ((x - precision) < y) && ((x + precision) > y);
}

enum TriangleAngle {
  InvalidAngle,
  Retangle,
  Obtusangle,
  Acutangle
};

enum TriangleType {
  InvalidType,
  Scalene,
  Equilateral,
  Isosceles
};

struct Triangle {
  double x;
  double y;
  double z;

  friend std::istream& operator >> (std::istream& in, Triangle &t) {
    in >> t.x >> t.y >> t.z;
    return in;
  }

  TriangleAngle get_angle() {
    double x = this->x;
    double y = this->y;
    double z = this->z;
    double s;

    if (x > y) swap(x, y);
    if (x > z) swap(x, z);
    if (y > z) swap(y, z);

    if (!this->is_valid()) {
      return TriangleAngle::InvalidAngle;
    } else {
      x = x * x;
      y = y * y;
      z = z * z;
      s = x + y;
      if (z > s) return TriangleAngle::Obtusangle;
      if (z < s) return TriangleAngle::Acutangle;
      return TriangleAngle::Retangle;
    }
  }

  int count_size_equals() {
    int count = 0;
    count += equals_with_error(this->x, this->y, 1e-5);
    count += equals_with_error(this->y, this->z, 1e-5);
    count += equals_with_error(this->x, this->z, 1e-5);
    return count;
  }

  TriangleType get_type() {
    if (!this->is_valid()) {
      return TriangleType::InvalidType;
    } else {
      switch (this->count_size_equals())
      {
      case 0:
        return TriangleType::Scalene;
      case 1:
        return TriangleType::Isosceles;
      case 3:
        return TriangleType::Equilateral;
      default:
        return TriangleType::InvalidType;
      }
    }
  }

  bool is_valid() {
    return _valid(x, y, z) && _valid(y, z, x) && _valid(z, x, y);
  }

private: 
  bool _valid(double x, double y, double z) {
    return abs(x - y) < z && z < (x + y);
  }
};

int main() {
  Triangle t;
  std::cin >> t;

  switch (t.get_angle())
  {
  case TriangleAngle::InvalidAngle:
    std::cout << "NAO FORMA TRIANGULO" << std::endl;
    break;
  case TriangleAngle::Retangle:
    std::cout << "TRIANGULO RETANGULO" << std::endl;
    break;
  case TriangleAngle::Obtusangle:
    std::cout << "TRIANGULO OBTUSANGULO" << std::endl;
    break;
  case TriangleAngle::Acutangle:
    std::cout << "TRIANGULO ACUTANGULO" << std::endl;
    break;
  default:
    break;
  }

  switch (t.get_type())
  {
  case TriangleType::Equilateral:
    std::cout << "TRIANGULO EQUILATERO" << std::endl;
    break;
  case TriangleType::Isosceles:
    std::cout << "TRIANGULO ISOSCELES" << std::endl;
    break;
  default:
    break;
  }

  return 0;
}
