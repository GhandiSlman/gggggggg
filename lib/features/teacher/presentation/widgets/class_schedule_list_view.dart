// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/controller/class_schedule_controller.dart';

class ClassScheduleListView extends StatefulWidget {
  const ClassScheduleListView({
    super.key,
    required this.classScheduleController,
  });

  final ClassScheduleController classScheduleController;

  @override
  State<ClassScheduleListView> createState() => _ClassScheduleListViewState();
}

class _ClassScheduleListViewState extends State<ClassScheduleListView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (box.read('userType') == 'teacher') {
        if (widget.classScheduleController.scheduleByDay.keys.isNotEmpty) {
          widget.classScheduleController.filterScheduleByDay(
              widget.classScheduleController.scheduleByDay.keys.first);
        }
      } else {
        if (widget
            .classScheduleController.scheduleByDayStudent.keys.isNotEmpty) {
          widget.classScheduleController.filterScheduleByDayStudent(
              widget.classScheduleController.scheduleByDayStudent.keys.first);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: box.read('userType') == 'teacher'
            ? widget.classScheduleController.scheduleByDay.keys.map((day) {
                return GestureDetector(
                  onTap: () =>
                      widget.classScheduleController.filterScheduleByDay(day),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: widget.classScheduleController.selectedDay
                                      .value ==
                                  day
                              ? AppColor.primaryColor
                              : AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                              color: widget.classScheduleController.selectedDay
                                          .value ==
                                      day
                                  ? AppColor.whiteColor
                                  : AppColor.primaryColor)),
                      child: Center(
                          child: CustomText(
                        text: day,
                        color:
                            widget.classScheduleController.selectedDay.value ==
                                    day
                                ? AppColor.whiteColor
                                : AppColor.primaryColor,
                      )),
                    ),
                  ),
                );
              }).toList()
            : widget.classScheduleController.scheduleByDayStudent.keys
                .map((day) {
                return GestureDetector(
                  onTap: () => widget.classScheduleController
                      .filterScheduleByDayStudent(day),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: widget.classScheduleController
                                      .selectedDayStudent.value ==
                                  day
                              ? AppColor.primaryColor
                              : AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                              color: widget.classScheduleController
                                          .selectedDayStudent.value ==
                                      day
                                  ? AppColor.whiteColor
                                  : AppColor.primaryColor)),
                      child: Center(
                          child: CustomText(
                        text: day,
                        color: widget.classScheduleController.selectedDayStudent
                                    .value ==
                                day
                            ? AppColor.whiteColor
                            : AppColor.primaryColor,
                      )),
                    ),
                  ),
                );
              }).toList(),
      );
    });
  }
}
