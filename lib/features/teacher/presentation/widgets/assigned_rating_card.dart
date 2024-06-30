// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/controller/continuous_rating_controller.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';
import 'package:lms/features/teacher/presentation/widgets/slidable_action.dart';

class AssignedRatingCard extends StatelessWidget {
  String studentName;
  String subjectName;
  int rate;
  String id;
  GetContinuousRateStudentData? getContinuousRateStudent;
  AssignedRatingCard({
    super.key,
    required this.studentName,
    required this.subjectName,
    required this.rate,
    required this.id,
    this.getContinuousRateStudent,
  });

  @override
  Widget build(BuildContext context) {
    ContinuousRatingController continuousRatingController = Get.find();
    return Slidable(
        startActionPane: ActionPane(
            extentRatio: 0.5,
            motion: const ScrollMotion(),
            children: [
              SlidableActionTecherWidget(
                onTap: () {
                  //  weekPlaneController.deleteWeekPlane(weekPlaneDetails.id!);o
                  continuousRatingController
                      .deleteRateStudent(getContinuousRateStudent!.id!);
                },
                color: AppColor.redColor,
                label: 'Delete'.tr,
                imagePath: 'assets/delete.svg',
              ),
              SlidableActionTecherWidget(
                // onTap: () {
                //   Get.toNamed(AppRouter.addToWeekPlaneScreen, arguments: {
                //     'weekPlaneId': weekPlaneDetails.id,
                //     'isUpdate': weekPlaneController.isUpdate == false,
                //     'desCon': weekPlaneController.lessonDateController.text =
                //         weekPlaneDetails.lessonDescription!,
                //     'titleCon': weekPlaneController.lessonTitleController.text =
                //         weekPlaneDetails.lessonTitle!,
                //     'dateCon': weekPlaneController.lessonDateController.text =
                //         weekPlaneDetails.lessonDate!,

                //   });
                // },
                color: AppColor.primaryColor,
                label: 'Edit'.tr,
                imagePath: 'assets/edit.svg',
              ),
            ]),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 80.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: SvgPicture.asset(AppImages.personRate),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: studentName,
                        fontSize: 20.sp,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.subjectIcon),
                          SizedBox(width: 5.w),
                          CustomText(text: subjectName),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: AppColor.greyColor2),
                      SizedBox(width: 5.w),
                      CustomText(text: rate.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
