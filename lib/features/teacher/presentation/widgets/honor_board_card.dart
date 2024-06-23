// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/controller/honor_board_controller.dart';
import 'package:lms/features/teacher/model/honor_board.dart';

class TeacherHonorBoardCard extends StatelessWidget {
  String subjectName;
  int subjectId;
  GetHonorBoardModel getHonorBoard;
  TeacherHonorBoardCard({
    super.key,
    required this.subjectId,
    required this.getHonorBoard,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    return InkWell(
      onTap: () {
        honorBoardController.getStudentHonorBoard(subjectId);
        Get.toNamed(AppRouter.studentHonorBoardScreen);
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
                title: FittedBox(
                  child: CustomText(
                    text: '${'Honor board for'.tr} $subjectName',
                    fontSize: 10.sp,
                    color: AppColor.primaryColor,
                  ),
                ),
              ))),
    );
  }
}
