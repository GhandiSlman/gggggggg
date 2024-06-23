import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController tabController2;

  RxBool isTyping = false.obs;

  List<String> selectedCities = [];
  List<String> selectedSubject = [];
  List<String> selectedDivision = [];
  List<SelectedListItem> cityList = [
    SelectedListItem(name: 'Class 1'),
    SelectedListItem(name: 'Class 2'),
    SelectedListItem(name: 'Class 3'),
  ];

  List<SelectedListItem> divisionList = [
    SelectedListItem(name: 'Division 1'),
    SelectedListItem(name: 'Division 2'),
    SelectedListItem(name: 'Division 3'),
  ];

  List<SelectedListItem> subjectList = [
    SelectedListItem(name: 'Subject 1'),
    SelectedListItem(name: 'Subject 2'),
    SelectedListItem(name: 'Subject 3'),
  ];
  late final TextEditingController classController;
  late final TextEditingController subjectController;
  late final TextEditingController divisionController;
  final List<Tab> weekPlaneTabs = [
    Tab(
      text: 'Tajweed Subject'.tr,
    ),
    Tab(
      text: 'Memorizing Subject'.tr,
    )
  ];

  final List<Tab> classRoomSubject = [
    Tab(
      text: 'Tajweed Subject HomeWork'.tr,
    ),
    Tab(
      text: 'Memorizing Subject HomeWork'.tr,
    )
  ];

  final List<Tab> chat = [
    Tab(
      text: 'SuperVisors'.tr,
    ),
    Tab(
      text: 'Parents'.tr,
    )
  ];

  final List<Tab> test = [
    const Tab(
      text: '1kmmkmkmkmmkmkmkm',
    ),
    const Tab(
      text: '2',
    ),
    const Tab(
      text: '3',
    ),
    const Tab(
      text: '4',
    ),
    const Tab(
      text: '5',
    ),
    const Tab(
      text: '6',
    ),
    const Tab(
      text: '7',
    ),
    const Tab(
      text: '8',
    ),
    const Tab(
      text: '9',
    ),
    const Tab(
      text: '10',
    ),
    const Tab(
      text: '11',
    ),
    const Tab(
      text: '12',
    ),
    const Tab(
      text: '13',
    ),
    const Tab(
      text: '14',
    ),
    const Tab(
      text: '15',
    ),
    const Tab(
      text: '16',
    ),
    const Tab(
      text: '17',
    ),
    const Tab(
      text: '18',
    ),
  ];
  @override
  void onInit() {
    classController = TextEditingController();
    subjectController = TextEditingController();
    divisionController = TextEditingController();
    tabController = TabController(length: 2, vsync: this);
    tabController2 = TabController(length: 18, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
