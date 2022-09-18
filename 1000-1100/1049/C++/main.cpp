// https://www.urionlinejudge.com.br/judge/en/problems/view/1049
#include <algorithm>
#include <iostream>
#include <cctype>
#include <map>

template<class T>
using Record = std::map<std::string, T>;

void lowercase(std::string &str) {
  std::transform(str.begin(), str.end(), str.begin(),
    [](unsigned char c){ return std::tolower(c); });
}

int main() {
  Record<Record<Record<std::string>>> map;
  map["vertebrado"]["ave"]["carnivoro"] = "aguia";
  map["vertebrado"]["ave"]["onivoro"] = "pomba";
  map["vertebrado"]["mamifero"]["onivoro"] = "homem";
  map["vertebrado"]["mamifero"]["herbivoro"] = "vaca";
  map["invertebrado"]["inseto"]["hematofago"] = "pulga";
  map["invertebrado"]["inseto"]["herbivoro"] = "lagarta";
  map["invertebrado"]["anelideo"]["hematofago"] = "sanguessuga";
  map["invertebrado"]["anelideo"]["onivoro"] = "minhoca";
  
  std::string inputs[3];
  std::cin >> inputs[0] >> inputs[1] >> inputs[2];
  for (int i = 0; i < 3; i++) lowercase(inputs[i]);
  std::cout << map[inputs[0]][inputs[1]][inputs[2]] << std::endl;
  
  return 0;
}
