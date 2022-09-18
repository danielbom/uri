// https://www.urionlinejudge.com.br/judge/en/problems/view/3306
#include <iostream>
#include <string>
#include <vector>

int gcd(int a, int b) {
  if (a == 0) return b;
  return gcd(b % a, a);
}

void add_value_in_range(std::vector<int> &array, int start, int end, int value) {
  int length = array.size();
  end = end < length ? end : length;
  for (int i = start; i < end; i++) {
    array[i] += value;
  }
}

int greatest_common_divisor_in_range(std::vector<int> &array, int start, int end) {
  int result = array[start];
  for (int i = start + 1; i < end; i++) {
    result = gcd(array[i], result);
    if (result == 1) return 1;
  }
  return result;
}

int main() {
  int n, q, i;
  int testType, start, end, value;
  std::vector<int> array;

  std::cin >> n >> q;
  array.assign(n, 0);

  for (i = 0; i < n; i++) {
    std::cin >> array[i];
  }

  for (i = 0; i < q; i++) {
    std::cin.ignore(1,'\n');
    char head = std::cin.peek();

    if (head == '\n') {
      std::cout << i + 1 << std::endl;
      continue;
    }

    std::cin >> testType;
    
    switch (testType)
    {
    case 1:
      std::cin >> start >> end >> value;
      add_value_in_range(array, start, end, value);
      break;
    
    case 2:
      std::cin >> start >> end;
      std::cout << greatest_common_divisor_in_range(array, start, end) << std::endl;
      break;

    default:
      return 1;
    }
  }

  return 0;
}
