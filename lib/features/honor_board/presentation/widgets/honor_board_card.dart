// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/honor_board/model/honor_model.dart';

class TeacherHonorBoardCard extends StatelessWidget {
  final Honor honor;
  const TeacherHonorBoardCard({
    super.key,
    required this.honor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.studentHonorBoardScreen,
            arguments: honor.students);
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(20.r)),
          height: 75.h,
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: ListTile(
                leading: SvgPicture.asset(AppImages.honorImage),
                title: CustomText(
                  text: honor.title,
                  fontSize: 14.sp,
                  color: AppColor.primaryColor,
                ),
              ))),
    );
  }
}
