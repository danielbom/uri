// https://www.urionlinejudge.com.br/judge/en/problems/view/1041
#include <iostream>
#include <math.h>

struct Point {
  double x;
  double y;

  friend std::istream& operator >> (std::istream& in, Point &p) {
    in >> p.x >> p.y;
    return in;
  }
  friend std::ostream& operator<<(std::ostream& os, const Point& p) {
    os << "(" << p.x << "," << p.y << ")";
    return os;
  }

  std::string quadrant() {
    if (this->x == 0.0 && this->y == 0.0) {
      return "Origem";
    } else if (this->x == 0.0) {
      return "Eixo Y";
    } else if (this->y == 0.0) {
      return "Eixo X";
    } else {
      char quadrants[4][3] = {"Q3", "Q4", "Q2", "Q1"};
      int bitmap = this->x > 0 | (this->y > 0) << 1;
      return std::string(quadrants[bitmap]);
    }
  }
};

int main() {
  Point p;
  std::cin >> p;
  std::cout << p.quadrant() << std::endl;
  return 0;
}
