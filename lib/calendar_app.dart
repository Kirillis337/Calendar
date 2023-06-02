import 'package:calendar/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_calendar.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  int leftEmptyDay = 0;
  int rightEmptyDay = 0;
  List<String> listCalendar = [];

  @override
  void initState() {
    leftEmptyDay = getFirstDay() - 1;
    for (int i = 0; i < leftEmptyDay; i++) {
      listCalendar.add(" ");
    }
    for (int i = 1; i <= getMonthLeng(month, year); i++) {
      listCalendar.add(i.toString());
    }
    while (listCalendar.length < 42) {
      rightEmptyDay++;
      listCalendar.add(" ");
    }
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: thirdColor,
        title: const Text("Календарь"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => tapLeft(leftEmptyDay, month, year),
                      icon: const Icon(
                        CupertinoIcons.left_chevron,
                        color: thirdColor,
                      )),
                  Text(
                    " ${getMonthName(month)} ${year.toString()}",
                    style: const TextStyle(fontSize: 30, color: thirdColor),
                  ),
                  IconButton(
                      onPressed: () => tapRight(rightEmptyDay, month, year),
                      icon: const Icon(CupertinoIcons.right_chevron,
                          color: thirdColor)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ItemCalendar(
                      text: "Пн",
                    ),
                    ItemCalendar(
                      text: "Вт",
                    ),
                    ItemCalendar(
                      text: "Ср",
                    ),
                    ItemCalendar(
                      text: "Чт",
                    ),
                    ItemCalendar(
                      text: "Пт",
                    ),
                    ItemCalendar(
                      text: "Сб",
                    ),
                    ItemCalendar(
                      text: "Вс",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.grey[700],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCalendar
                          .getRange(0, 7)
                          .map((e) => ItemCalendar(
                                text: e,
                                month: month,
                                year: year,
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: thirdColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCalendar
                          .getRange(7, 14)
                          .map((e) => ItemCalendar(
                                text: e,
                                month: month,
                                year: year,
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: thirdColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCalendar
                          .getRange(14, 21)
                          .map((e) => ItemCalendar(
                                text: e,
                                month: month,
                                year: year,
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: thirdColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCalendar
                          .getRange(21, 28)
                          .map((e) => ItemCalendar(
                                text: e,
                                month: month,
                                year: year,
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: thirdColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCalendar
                          .getRange(28, 35)
                          .map((e) => ItemCalendar(
                                text: e,
                                month: month,
                                year: year,
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: thirdColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCalendar
                          .getRange(35, 42)
                          .map((e) => ItemCalendar(
                                text: e,
                                month: month,
                                year: year,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }

  void tapLeft(int localLeftDay, int localMonth, int localYear) {
    int localRightDay = 7 - localLeftDay % 7;
    if (localMonth == 1) {
      localMonth = 12;
      localYear = localYear - 1;
    } else {
      localMonth = localMonth - 1;
      localYear = localYear;
    }
    List<String> res = [];
    localLeftDay = 42 - getMonthLeng(localMonth, localYear) - localRightDay;
    localLeftDay %= 7;
    localRightDay %= 7;
    for (int i = 1; i <= localLeftDay; i++) {
      res.add(" ");
    }
    for (int i = 1; i <= getMonthLeng(localMonth, localYear); i++) {
      res.add(i.toString());
    }
    while (res.length < 42) {
      res.add(" ");
    }
    setState(() {
      year = localYear;
      month = localMonth;
      leftEmptyDay = localLeftDay;
      rightEmptyDay = localRightDay;
      listCalendar = res;
    });
  }

  void tapRight(int localRightDay, int localMonth, int localYear) {
    int localLeftDay = 7 - localRightDay % 7;
    if (localMonth == 12) {
      localMonth = 1;
      localYear = localYear + 1;
    } else {
      localMonth = localMonth + 1;
      localYear = localYear;
    }
    List<String> res = [];
    localRightDay = 42 - getMonthLeng(localMonth, localYear) - localLeftDay;
    localLeftDay %= 7;
    localRightDay %= 7;
    for (int i = 1; i <= localLeftDay; i++) {
      res.add(" ");
    }
    for (int i = 1; i <= getMonthLeng(localMonth, localYear); i++) {
      res.add(i.toString());
    }
    while (res.length < 42) {
      res.add(" ");
    }
    setState(() {
      year = localYear;
      month = localMonth;
      leftEmptyDay = localLeftDay;
      rightEmptyDay = localRightDay;
      listCalendar = res;
    });
  }

  int getFirstDay() {
    int weekday = DateTime.now().weekday;
    int today = DateTime.now().day;
    if (today % 7 == 0) {
      if (weekday == 7) {
        weekday = 1;
      } else {
        weekday++;
      }
      today++;
    }
    int res = today %= 7;
    while (res != 1) {
      if (res > weekday) {
        res -= weekday;
        weekday = 7;
      } else {
        res--;
        weekday--;
      }
    }
    return weekday;
  }

  int getMonthLeng(int month, int year) {
    List month31 = [1, 3, 5, 7, 8, 10, 12];
    List month30 = [4, 6, 9, 11];
    if (month31.contains(month)) {
      return 31;
    } else if (month30.contains(month)) {
      return 30;
    } else if (year % 4 != 0) {
      return 28;
    } else {
      return 29;
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case (1):
        {
          return "Январь";
        }
      case (2):
        {
          return "Февраль";
        }
      case (3):
        {
          return "Март";
        }
      case (4):
        {
          return "Апрель";
        }
      case (5):
        {
          return "Май";
        }
      case (6):
        {
          return "Июнь";
        }
      case (7):
        {
          return "Июль";
        }
      case (8):
        {
          return "Август";
        }
      case (9):
        {
          return "Сентябрь";
        }
      case (10):
        {
          return "Октябрь";
        }
      case (11):
        {
          return "Ноябрь";
        }
      default:
        return "Декабрь";
    }
  }
}
