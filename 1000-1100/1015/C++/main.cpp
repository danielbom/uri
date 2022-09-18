// https://www.urionlinejudge.com.br/judge/en/problems/view/1015
#include <iostream>
#include <math.h>

struct Point {
  double x;
  double y;

  double distance(Point &other) {
    double xx = other.x - x;
    double yy = other.y - y;
    xx = xx * xx;
    yy = yy * yy;
    return sqrt(xx + yy);
  }

  friend std::istream& operator >> (std::istream& in, Point &p) {
    in >> p.x >> p.y;
    return in;
  }
  friend std::ostream& operator<<(std::ostream& os, const Point& p) {
    os << "(" << p.x << "," << p.y << ")";
    return os;
  }
};

int main() {
  Point p1, p2;

  std::cin >> p1 >> p2;
  std::cout.precision(4);
  std::cout << std::fixed << p1.distance(p2) << std::endl;

  return 0;
}
