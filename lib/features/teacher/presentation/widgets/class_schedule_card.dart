// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/model/get_class_schedule.dart';

class ClassScheduleCard extends StatelessWidget {
  Schedule schedule;
  ClassScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10.r)),
        height: 80.h,
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 7.h,
            ),
            child: ListTile(
              leading: SvgPicture.asset(AppImages.date2Image),
              title: Row(
                children: [
                  CustomText(
                    text: schedule.section!.name!,
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  ),
                  CustomText(
                    text: '-',
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  ),
                  CustomText(
                    text: schedule.subject!.name!,
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  SvgPicture.asset(AppImages.clockImage),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(text: schedule.time!)
                ],
              ),
            )));
  }
}
