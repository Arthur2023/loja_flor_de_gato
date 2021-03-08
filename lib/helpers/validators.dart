bool emailValid(String email) {
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

String isValidDate(String input) {
  List<String> number = input.split("/");
  int day = int.parse(number[0]);
  int month = int.parse(number[1]);
  int year = int.parse(number[2]);
  DateTime now = DateTime.now();
  if (day < now.day && month == now.month && year == now.year) return 'Date less than today';

  print(input);

  if (day < 32 && day > 0 && month > 0 && month < 13 && year > 1800) {
    if (day == 31 && (month == 4 || month == 6 || month == 9 || month == 11)) {
      return 'month $month does not support 31 days';
    } else if (day >= 30 && month == 2) {
      return 'February can only have 29 days';
    } else if (month == 2 && day == 29 && !(year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
      return 'February 29 only accepted in leap year';
    } else {
      return null;
    }
  }

  return 'Invalid date';
}
