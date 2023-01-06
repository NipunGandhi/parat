import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parat/controller.dart';

import 'custom_dates.dart';
import 'logic.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late List<int> a = [];
  String selectedValueMonths = "Jan";
  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  int month = 1;
  int year = 2023;

  Future<void> refresh() async {
    a = await calendar(year, month);
    selectedValueMonths = months[month - 1];
    setState(() {});
  }

  Controller controller = Get.find();

  @override
  initState() {
    month = controller.mm;
    year = controller.yyyy;
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: a.length == 42 ? 370 : 330,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Month and Year
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (month == 1) {
                          month = 12;
                          year = year - 1;
                        } else {
                          month = month - 1;
                        }
                        refresh();
                      },
                      child: const Icon(
                        Icons.navigate_before,
                        size: 25,
                      ),
                    ),
                    DropdownButton(
                      underline: const SizedBox(),
                      menuMaxHeight: a.length == 42 ? 370 : 330,
                      value: selectedValueMonths,
                      items:
                          months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        month = months.indexOf(value.toString()) + 1;

                        setState(() {
                          selectedValueMonths = value!;
                        });
                        refresh();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        if (month == 12) {
                          month = 1;
                          year += 1;
                        } else {
                          month = month + 1;
                        }
                        refresh();
                      },
                      child: const Icon(
                        Icons.navigate_next,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        year = year - 1;
                        refresh();
                      },
                      child: const Icon(
                        Icons.navigate_before,
                        size: 25,
                      ),
                    ),
                    DropdownButton(
                      underline: const SizedBox(),
                      menuMaxHeight: a.length == 42 ? 370 : 330,
                      value: year,
                      items: years.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        year = value!;
                        refresh();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        year = year + 1;
                        refresh();
                      },
                      child: const Icon(
                        Icons.navigate_next,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //Weeks
            SizedBox(
              height: 30,
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 7,
                children: List.generate(days.length, (index) {
                  return Center(
                    child: Text(
                      days[index],
                      style: const TextStyle(
                        color: Color(0xff1C1C1C),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  );
                }),
              ),
            ),
            //Dates
            SizedBox(
              height: a.length == 42 ? 260 : 220,
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                crossAxisCount: 7,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(a.length, (index) {
                  if (a[index] < 0) {
                    return Center(
                      child: Text(
                        (a[index] * -1).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686868),
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      controller.dd = a[index];
                      setState(() {});
                    },
                    child: CustomDates(
                      date: a[index],
                    ),
                  );
                }),
              ),
            ),
            //Cancel and Okay Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 10),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color(0xff1C1C1C),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.mm = month;
                    controller.yyyy = year;
                    defaultText =
                        "${controller.dd.toString().length == 2 ? controller.dd : "0${controller.dd}"}/${month.toString().length == 2 ? month : "0$month"}/$year";
                    print(defaultText);
                    controller.date.value = defaultText;
                    controller.textController.text = defaultText;
                    setState(() {});
                    Navigator.pop(context, 'Ok');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Color(0xff1C1C1C),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
