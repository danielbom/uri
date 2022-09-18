// https://www.urionlinejudge.com.br/judge/en/problems/view/1042
#include <iostream>

void swap(int &x, int &y) {
  int z = x;
  x = y;
  y = z;
}

int main() {
  int xs[3];
  int ys[3];

  for (int i = 0; i < 3; i++) {
    std::cin >> xs[i];
    ys[i] = xs[i];
  }

  // bubble sort
  if (xs[0] > xs[1]) swap(xs[0], xs[1]);
  if (xs[0] > xs[2]) swap(xs[0], xs[2]);
  if (xs[1] > xs[2]) swap(xs[1], xs[2]);

  for (int i = 0; i < 3; i++) 
    std::cout << xs[i] << std::endl;

  std::cout << std::endl;

  for (int i = 0; i < 3; i++) 
    std::cout << ys[i] << std::endl;

  return 0;
}
