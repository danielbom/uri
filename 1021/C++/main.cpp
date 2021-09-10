// https://www.urionlinejudge.com.br/judge/en/problems/view/1021
#include <iostream>
#include <string.h>

int main()
{
  int real, cents;

  std::cin >> real;
  std::cin.ignore();
  std::cin >> cents;

  {
    const int CASH_COUNT = 6;
    const int cash_values[CASH_COUNT] = {100, 50, 20, 10, 5, 2};
    const char cash_cstr[CASH_COUNT][16] = {"100.00", "50.00", "20.00", "10.00", "5.00", "2.00"};

    std::cout << "NOTAS:" << std::endl;

    int real_count[CASH_COUNT] = {0};

    for (int cash = 0; cash < CASH_COUNT; cash++)
    {
      int value = cash_values[cash];
      real_count[cash] = real / value;
      real = real % value;
    }

    for (int cash = 0; cash < CASH_COUNT; cash++)
    {
      std::cout << real_count[cash] << " nota(s) de R$ " << cash_cstr[cash] << std::endl;
    }
  }

  cents += real * 100;

  {
    const int CENT_COUNT = 6;
    const int cents_values[CENT_COUNT] = {100, 50, 25, 10, 5, 1};
    const char cents_cstr[CENT_COUNT][16] = {"1.00", "0.50", "0.25", "0.10", "0.05", "0.01"};

    std::cout << "MOEDAS:" << std::endl;

    int cents_count[CENT_COUNT] = {0};

    for (int cash = 0; cash < CENT_COUNT; cash++)
    {
      int value = cents_values[cash];
      cents_count[cash] = cents / value;
      cents = cents % value;
    }

    for (int cash = 0; cash < CENT_COUNT; cash++)
    {
      std::cout << cents_count[cash] << " moeda(s) de R$ " << cents_cstr[cash] << std::endl;
    }
  }

  return 0;
}
