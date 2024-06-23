import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/controller/honor_board_controller.dart';
import 'package:lms/features/teacher/model/student_honor_board.dart';

class StudentHonorBoardCard extends StatelessWidget {
  final int? index;
  final HonorBoardStudent honorBoardStudent;

  const StudentHonorBoardCard(
      {super.key, this.index, required this.honorBoardStudent});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColor.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(5.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  height: 125.h,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(AppImages.studentH)),
                ),
                5.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: honorBoardStudent.students?.length,
                    itemBuilder: (context, studentIndex) {
                      return Center(
                        child: AutoSizeText(
                          honorBoardStudent.students![studentIndex].name ??
                              'No Name', // Display student name
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            //   fontSize: 18.sp,
                          ),
                          maxLines: 3,
                          minFontSize: 5.sp,
                          maxFontSize: 18.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 25.h,
          child: Container(
            width: 20.w,
            height: 25.h,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7.r),
                    bottomRight: Radius.circular(7.r))),
            child: Center(
              child: CustomText(
                text: index.toString(),
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ),
        Positioned(
          right: 25.h,
          child: InkWell(
            onTap: () {
              honorBoardController.deleteHonorBoard(honorBoardStudent.id!);
            },
            child: Container(
              width: 20.w,
              height: 25.h,
              decoration: BoxDecoration(
                  color: AppColor.redColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7.r),
                      bottomRight: Radius.circular(7.r))),
              child: Padding(
                padding: EdgeInsets.all(3.h),
                child: SvgPicture.asset(AppImages.deleteImage),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
