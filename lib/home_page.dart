import 'package:flutter/material.dart';
import 'package:parat/custom_calendar.dart';
import 'package:parat/logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 27, top: 15, bottom: 2),
              height: 20,
              width: double.infinity,
              child: const Text(
                "Select a date",
                style: TextStyle(
                  color: Color(0xff686868),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                    actions: <Widget>[
                      CustomCalendar(),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(defaultText),
                    Image(
                      image: AssetImage("assets/images/img.png"),
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
