// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/class_schedule_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/class_schedule_card.dart';
import 'package:lms/features/teacher/presentation/widgets/class_schedule_list_view.dart';

class ClassScheduleScreen extends StatelessWidget {
  const ClassScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClassScheduleController classScheduleController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Class table'.tr),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.h),
            child: SizedBox(
              height: 30.h,
              child: Obx(() {
                return classScheduleController.isLoading.value
                    ? ShimmerWidget(height: 20.h)
                    : ClassScheduleListView(
                        classScheduleController: classScheduleController);
              }),
            ),
          ),
          Expanded(
            child: Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                  itemCount: box.read('userType') == 'teacher'
                      ? classScheduleController.filteredSchedule.length
                      : classScheduleController.filteredScheduleStudent.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: box.read('userType') == 'teacher'
                            ? ClassScheduleCard(
                                sectionName: classScheduleController
                                    .filteredSchedule[index].subject!.name,
                                schedule: classScheduleController
                                    .filteredSchedule[index],
                                time: classScheduleController
                                    .filteredSchedule[index].time,
                                subjectName: classScheduleController
                                    .filteredSchedule[index].section!.name,
                              )
                            : ClassScheduleCard(
                                sectionName: classScheduleController
                                    .filteredScheduleStudent[index]
                                    .subject
                                    .name,
                                scheduleData: classScheduleController
                                    .filteredScheduleStudent[index],
                                time: classScheduleController
                                    .filteredScheduleStudent[index].time,
                              ));
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
