int numberOfDays(int monthNumber, int year) {
  // January
  if (monthNumber == 0) return (31);

  // February
  if (monthNumber == 1) {
    // If the year is leap then February has
    // 29 days
    if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
      return (29);
    } else {
      return (28);
    }
  }

  // March
  if (monthNumber == 2) return (31);

  // April
  if (monthNumber == 3) return (30);

  // May
  if (monthNumber == 4) return (31);

  // June
  if (monthNumber == 5) return (30);

  // July
  if (monthNumber == 6) return (31);

  // August
  if (monthNumber == 7) return (31);

  // September
  if (monthNumber == 8) return (30);

  // October
  if (monthNumber == 9) return (31);

  // November
  if (monthNumber == 10) return (30);

  // December
  if (monthNumber == 11) return (31);

  return 0;
}

List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

List<int> years = [for (var i = 1800; i <= 2100; i += 1) i];

String defaultText = "dd/mm/yy";

String getMonthName(int monthNumber) {
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  return (months[monthNumber]);
}

int dayNumber(int day, int month, int year) {
  List<int> t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];
  if (month < 3) {
    year -= 1;
  } else {
    year -= 0;
  }
  int val =
      (year + year ~/ 4 - year ~/ 100 + year ~/ 400 + t[month - 1] + day) % 7;
  return val;
}

Future<List<int>> calendar(int year, int month) async {
  int days;
  int current = dayNumber(1, 1, year);
  List<int> ans = [];
  for (int i = 0; i < 12; i++) {
    days = numberOfDays(i, year);
    int k;
    if (month - 1 == i) {
      int a = 0;
      if (i == 0) {
        a = numberOfDays(12 - 1, year) - current + 1;
      } else {
        a = numberOfDays(i - 1, year) - current + 1;
      }
      for (k = 0; k < current; k++) {
        ans.add((a * -1));
        a += 1;
      }
      for (int j = 1; j <= days; j++) {
        ans.add(j);
        if (++k > 6) {
          k = 0;
        }
      }
    } else {
      for (k = 0; k < current; k++) {}
      for (int j = 1; j <= days; j++) {
        if (++k > 6) {
          k = 0;
        }
      }
    }
    current = k;
  }
  int i = 1;
  if (ans.length < 35) {
    while (ans.length != 35) {
      ans.add((i * -1));
      i = i + 1;
    }
  } else if (ans.length == 35) {
  } else {
    while (ans.length != 42) {
      ans.add((i * -1));
      i = i + 1;
    }
  }
  return ans;
}
