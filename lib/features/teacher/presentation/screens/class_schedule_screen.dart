// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/class_schedule_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/class_schedule_card.dart';

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
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: classScheduleController.scheduleByDay.keys
                            .map((day) {
                          return GestureDetector(
                            onTap: () => classScheduleController
                                .filterScheduleByDay(day),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: classScheduleController
                                                .selectedDay.value ==
                                            day
                                        ? AppColor.primaryColor
                                        : AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(30.r),
                                    border: Border.all(
                                        color: classScheduleController
                                                    .selectedDay.value ==
                                                day
                                            ? AppColor.whiteColor
                                            : AppColor.primaryColor)),
                                child: Center(
                                    child: CustomText(
                                  text: day,
                                  color:
                                      classScheduleController.selectedDay.value ==
                                              day
                                          ? AppColor.whiteColor
                                          : AppColor.primaryColor,
                                )),
                              ),
                            ),
                          );
                        }).toList(),
                      );
              }),
            ),
          ),
          Expanded(
            child: Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                  itemCount: classScheduleController.filteredSchedule.length,
                  itemBuilder: (context, index) {
                    final schedule =
                        classScheduleController.filteredSchedule[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: ClassScheduleCard(schedule: schedule),
                    );
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
