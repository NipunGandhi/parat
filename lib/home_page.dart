import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parat/controller.dart';
import 'package:parat/custom_calendar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    int dd;
    int mm;
    int valueSize = 0;
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
                      controller: controller.textController,
                      decoration: const InputDecoration(
                        hintText: "dd/mm/yyyy",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        if (value.length < valueSize) {
                          print("Backspace");
                          valueSize = value.length;
                        } else {
                          valueSize = value.length;
                          if (value.length == 2) {
                            dd = int.parse(value);
                            if (dd > 31) {
                              controller.textController.clear();
                            } else {
                              value += "/";
                              controller.textController.value =
                                  controller.textController.value.copyWith(
                                text: value,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                          }
                          if (value.length == 5) {
                            mm = int.parse(value.substring(3, 5));
                            if (mm > 12) {
                              controller.textController.clear();
                            } else {
                              value += "/";
                              controller.textController.value =
                                  controller.textController.value.copyWith(
                                text: value,
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                          }
                          if (value.length == 10) {
                            controller.dd = int.parse(value.substring(0, 2));
                            controller.mm = int.parse(value.substring(3, 5));
                            controller.yyyy = int.parse(value.substring(6, 10));
                            var defaultText =
                                "${controller.dd.toString().length == 2 ? controller.dd : "0${controller.dd}"}/${controller.mm.toString().length == 2 ? controller.mm : "0${controller.mm}"}/${controller.yyyy}";
                            print(defaultText);
                            controller.date.value = defaultText;
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        }
                      },
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
                    child: Obx(
                      () => Image(
                        image: controller.date == "dd/mm/yy"
                            ? const AssetImage("assets/images/img.png")
                            : const AssetImage("assets/images/img_1.png"),
                        height: 30,
                      ),
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
