import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherController extends GetxController
    with GetTickerProviderStateMixin {

  RxBool isTyping = false.obs;

  List<String> selectedCities = [];
  List<SelectedListItem> cityList = [
    SelectedListItem(name: 'Class 1'),
    SelectedListItem(name: 'Class 2'),
    SelectedListItem(name: 'Class 3'),
  ];

  late final TextEditingController classController;

  @override
  void onInit() {
    classController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() { 
    super.onClose();
  }
}
