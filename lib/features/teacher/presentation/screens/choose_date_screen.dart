import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/features/teacher/controller/calender_controller.dart';
import 'package:lms/features/teacher/controller/teacher_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class ChooseDateScreen extends StatelessWidget {
  const ChooseDateScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.put(TeacherController());
    Size mq = MediaQuery.of(context).size;
    final CalendarController calendarController = Get.put(CalendarController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Activity'.tr),
      body: Column(
        children: [
          GetBuilder<CalendarController>(
            builder: (_) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: AppColor.griedentSix,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mq.height * .02),
                      child: DropDownList(
                          onSelectedItems: (List<String> selectedItems) {
                            teacherController.selectedCities = selectedItems;
                          },
                          dataList: teacherController.cityList,
                          textEditingController:
                              teacherController.classController,
                          hint: 'Choose class'.tr,
                          isCitySelected: true),
                    ),
                    TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: calendarController.selectedDate,
                      calendarFormat: CalendarFormat.month,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month'
                      },
                      onDaySelected: calendarController.onDaySelected,
                      selectedDayPredicate: (day) {
                        return isSameDay(calendarController.selectedDate, day);
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: TextStyle(color: AppColor.whiteColor),
                        todayTextStyle: TextStyle(color: AppColor.whiteColor),
                        selectedTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white),
                        weekendStyle: TextStyle(color: Colors.white),
                      ),
                      headerStyle: const HeaderStyle(
                        titleTextStyle:
                            TextStyle(color: Colors.white, fontSize: 18),
                        leftChevronIcon:
                            Icon(Icons.arrow_back_ios, color: Colors.white),
                        rightChevronIcon:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                        formatButtonVisible:
                            false, // Hide format button if not needed
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(mq.height * .02),
              child: Column(
                children: [
                  CustomText(
                    text: 'Picinic',
                    color: AppColor.primaryColor,
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  CustomText(
                    maxLine: 7,
                    text:
                        'Picinicssdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddjvfwkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkewfnwjkwfnknfkwjnf2nobfi23fibif3n2jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj2bi2bewvijk23nfejjjjjjjjjjjjjjo2bgo3kqwnfoqnwfokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkknnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnniiiiiiiiiiiiiiiiiiiiiiiiiiiiiinnknkniinknnknjnnjjnjjnjnnjnnjnnjnnjnnjnjnjnjnnjnnjnjnjnnjnjnjnjnnnjnjnijjubinjlllllllllllllllllllllllllllllllllllllllllllllnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnni',
                    color: AppColor.greyColor2,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
