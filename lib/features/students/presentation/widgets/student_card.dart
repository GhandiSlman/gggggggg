import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/students/controller/student_controller.dart';
import 'package:lms/features/students/presentation/widgets/slidable_action.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int studentId;
  final int subjectId;

  const StudentCard({
    super.key,
    required this.name,
    required this.studentId,
    required this.subjectId,
  });

  @override
  Widget build(BuildContext context) {
    final StudentController studentController = Get.find();

    return Obx(() {
      String? status = studentController.studentAttendanceStatus[studentId];
      Color cardColor;

      switch (status) {
        case 'absent':
          cardColor = AppColor.redColor.withOpacity(0.5);
          break;
        case 'late':
          cardColor = AppColor.greyColor3.withOpacity(0.5);
          break;
        case 'excused':
          cardColor = AppColor.amber2Color.withOpacity(0.5);
          break;
        case 'present':
          cardColor = AppColor.green2Color.withOpacity(0.5);
          break;
        default:
          cardColor = AppColor.whiteColor;
      }

      return Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.54,
          motion: const ScrollMotion(),
          children: [
            SlidableActionWidget(
                color: AppColor.greyColor3,
                label: 'Late'.tr,
                onTap: () {
                  studentController.handleAttendance(
                      'late', studentId, subjectId);
                }),
            SlidableActionWidget(
              color: AppColor.amber2Color,
              label: 'Excused'.tr,
              onTap: () => studentController.handleAttendance(
                  'excused', studentId, subjectId),
            ),
            SlidableActionWidget(
              color: AppColor.redColor,
              label: 'Absent'.tr,
              onTap: () => studentController.handleAttendance(
                  'absent', studentId, subjectId),
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableActionWidget(
              color: AppColor.primaryColor,
              label: 'Present'.tr,
              onTap: () => studentController.handleAttendance(
                  'present', studentId, subjectId),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor, // Change card color based on attendance status
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 75.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Row(
              children: [
                Container(
                  height: 65.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(AppImages.childrenImage, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(width: 25.w),
                SizedBox(
                  width: 80.w,
                  child: FittedBox(
                    child: CustomText(
                      text: name,
                      fontSize: 20.sp,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
