// https://www.urionlinejudge.com.br/judge/en/problems/view/1046
#include <iostream>

struct Time {
  int hours;
  int minutes;

  friend std::istream& operator >> (std::istream& in, Time &t) {
    int hours, minutes;
    in >> t.hours >> t.minutes;
    return in;
  }

  friend std::ostream& operator << (std::ostream& out, Time &t) {
    out << t.hours << ":" << t.minutes << "h";
    return out;
  }

  int compare(const Time &other) const {
    if (this->hours == other.hours && this->minutes == other.minutes) {
      return 0;
    } else {
      if (this->hours == other.hours) {
        return this->minutes > other.minutes ? 1 : -1;
      } else {
        return this->hours > other.hours ? 1 : -1;
      }
    }
  }

  Time sub(const Time &other) const {
    Time time = {0};
    time.hours = this->hours - other.hours;
    time.minutes = this->minutes - other.minutes;

    if (time.minutes < 0) {
      time.hours -= 1;
      time.minutes += 60;
    }

    return time;
  }

  Time add(const Time &other) const {
    Time time = {0};
    time.hours = this->hours + other.hours;
    time.minutes = this->minutes + other.minutes;

    if (time.minutes > 60) {
      time.hours =+ 1;
      time.minutes -= 60;
    }

    return time;
  }
};

inline bool operator==(const Time& lhs, const Time& rhs){ return lhs.compare(rhs) == 0; }
inline bool operator!=(const Time& lhs, const Time& rhs){ return lhs.compare(rhs) != 0; }
inline bool operator< (const Time& lhs, const Time& rhs){ return lhs.compare(rhs) <  0; }
inline bool operator> (const Time& lhs, const Time& rhs){ return lhs.compare(rhs) >  0; }
inline bool operator<=(const Time& lhs, const Time& rhs){ return lhs.compare(rhs) <= 0; }
inline bool operator>=(const Time& lhs, const Time& rhs){ return lhs.compare(rhs) >= 0; }

int main() {
  Time one_day = { .hours = 24 };
  Time start, end;
  Time total = {0};

  std::cin >> start >> end;

  if (start == end) {
    total = one_day;
  } else if (start < end) {
    total = end.sub(start);
  } else { // if (start > end)
    total = one_day.sub(start).add(end);
  }

  std::cout << "O JOGO DUROU " << total.hours << " HORA(S) E " << total.minutes << " MINUTO(S)"  << std::endl;

  return 0;
}
