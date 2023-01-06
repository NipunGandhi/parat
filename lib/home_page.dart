import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parat/controller.dart';
import 'package:parat/custom_calendar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    int dd;
    int mm;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 27, top: 15, bottom: 2),
              height: 20,
              width: double.infinity,
              child: const Text(
                "Select date",
                style: TextStyle(
                  color: Color(0xff686868),
                ),
              ),
            ),
            Container(
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
                  Expanded(
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: "dd/mm/yyyy",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        print("dd - ${controller.dd}");

                        print("mm - ${controller.mm}");

                        print("YYYY- ${controller.yyyy}");
                        if (value.length == 2) {
                          dd = int.parse(value);
                          if (dd > 31) {
                            textController.clear();
                          } else {
                            value += "/";
                            textController.value =
                                textController.value.copyWith(
                              text: value,
                              selection:
                                  TextSelection.collapsed(offset: value.length),
                            );
                          }
                        }
                        if (value.length == 5) {
                          mm = int.parse(value.substring(3, 5));
                          if (mm > 12) {
                            textController.clear();
                          } else {
                            value += "/";
                            textController.value =
                                textController.value.copyWith(
                              text: value,
                              selection: TextSelection.collapsed(
                                offset: value.length,
                              ),
                            );
                          }
                        }
                        if (value.length == 10) {
                          controller.dd = int.parse(value.substring(0, 2));
                          print("dd - ${controller.dd}");
                          controller.mm = int.parse(value.substring(3, 5));
                          print("mm - ${controller.mm}");
                          controller.yyyy = int.parse(value.substring(6, 10));
                          print("YYYY- ${controller.yyyy}");
                        }
                      },
                    ),
                  ),
                  // Obx(
                  //   () => Text(controller.date.toString()),
                  // ),
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
                    child: const Image(
                      image: AssetImage("assets/images/img.png"),
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
