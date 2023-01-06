import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var date = "dd/mm/yy".obs;
  int dd = 06;
  int mm = 01;
  int yyyy = 2022;
  TextEditingController textController = TextEditingController();
}
