// https://www.urionlinejudge.com.br/judge/en/problems/view/1018
#include <iostream>
#include <string.h>

enum Cash {
  CASH_100 = 0,
  CASH_50,
  CASH_20,
  CASH_10,
  CASH_5,
  CASH_2,
  CASH_1,
  CASH_COUNT
};

int cash_value(Cash cash) {
  switch (cash)
  {
  case CASH_100:
    return 100;
  case CASH_50:
    return 50;
  case CASH_20:
    return 20;
  case CASH_10:
    return 10;
  case CASH_5:
    return 5;
  case CASH_2:
    return 2;
  case CASH_1:
    return 1;
  default:
    return 0;
  }
}

void cash_cstr(Cash cash, char *ptr) {
  switch (cash)
  {
  case CASH_100:
    strcpy(ptr, "100,00");
    break;
  case CASH_50:
    strcpy(ptr, "50,00");
    break;
  case CASH_20:
    strcpy(ptr, "20,00");
    break;
  case CASH_10:
    strcpy(ptr, "10,00");
    break;
  case CASH_5:
    strcpy(ptr, "5,00");
    break;
  case CASH_2:
    strcpy(ptr, "2,00");
    break;
  case CASH_1:
    strcpy(ptr, "1,00");
    break;
  default:
    break;
  }
}

int main() {
  char buffer[16] = {0};
  int x, xx;

  std::cin >> x;
  xx = x;

  int money[CASH_COUNT] = {0};

  for (int cash = 0; cash < CASH_COUNT; cash++) {
    int value = cash_value((Cash) cash);
    money[cash] = x / value;
    x = x % value;
  }

  std::cout << xx << std::endl;
  for (int cash = 0; cash < CASH_COUNT; cash++) {
    cash_cstr((Cash) cash, buffer);
    std::cout << money[cash] << " nota(s) de R$ " << buffer << std::endl;
    buffer[0] = '\0';
  }

  return 0;
}
