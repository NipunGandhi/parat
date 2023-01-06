import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parat/controller.dart';

class CustomDates extends StatefulWidget {
  const CustomDates({Key? key, required this.date}) : super(key: key);
  final int date;
  @override
  State<CustomDates> createState() => _CustomDatesState();
}

class _CustomDatesState extends State<CustomDates> {
  Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.date == controller.dd ? Colors.black : Colors.white,
      ),
      child: Center(
        child: Text(
          widget.date.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: widget.date == controller.dd
                ? Colors.white
                : const Color(0xff1C1C1C),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
