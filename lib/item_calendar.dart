import 'package:calendar/theme.dart';
import 'package:flutter/material.dart';


class ItemCalendar extends StatelessWidget {
  const ItemCalendar({Key? key, required this.text,  this.month,  this.year})
      : super(key: key);
  final String text;

  final int? month;
  final int? year;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height*0.07,
      width: MediaQuery.of(context).size.width*0.1,
      decoration: BoxDecoration(
          color: getColorToday(text, month??0, year??0), borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white70),
          )),
    );

  }
}

Color getColorToday(String day, int month, int year){
  if(day==DateTime.now().day.toString()&&month==DateTime.now().month&&year==DateTime.now().year){
    return thirdColor;
  }else {
    return primaryColor;
  }
}