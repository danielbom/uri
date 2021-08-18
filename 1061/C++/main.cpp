// https://www.urionlinejudge.com.br/judge/en/problems/view/1061
#include <iostream>

void ignore(std::string str) {
  for (int i = str.length(); i > 0; i--) {
    std::cin.ignore();
  }
}

struct Event {
  int days;
  int hours;
  int minutes;
  int seconds;

  static Event from_seconds(long seconds) {
    Event e;
    e.seconds = seconds % 60;
    seconds = seconds / 60;
    e.minutes = seconds % 60;
    seconds = seconds / 60;
    e.hours = seconds % 24;
    seconds = seconds / 24;
    e.days = seconds;
    return e;
  }

  long to_seconds() {
    int result = seconds;
    result += minutes * 60;
    result += hours * 60 * 60;
    result += days * 60 * 60 * 24;
    return result;
  }

  friend std::istream& operator >> (std::istream& in, Event &e) {
    ignore("Dia ");
    in >> e.days;
    in >> e.hours;
    ignore(" : ");
    in >> e.minutes;
    ignore(" : ");
    in >> e.seconds;
    return in;
  }
  friend std::ostream& operator<<(std::ostream& os, const Event& e) {
    os << e.days << " dia(s)" << std::endl;
    os << e.hours << " hora(s)" << std::endl;
    os << e.minutes << " minuto(s)" << std::endl;
    os << e.seconds << " segundo(s)" << std::endl;
    return os;
  }
};

int main() {
  Event start_event, end_event;
  std::cin >> start_event >> end_event;
  long seconds = end_event.to_seconds() - start_event.to_seconds();
  std::cout << Event::from_seconds(seconds);
  return 0;
}
