import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';

class StudentHonorBoardCard extends StatelessWidget {
  final int index;
  final List<Student> students;

  const StudentHonorBoardCard({
    super.key,
    required this.index,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
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
                AutoSizeText(
                  students[index].name ?? 'No Name',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 18.sp,
                  ),
                  maxLines: 3,
                  minFontSize: 0,
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 25.h,
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
                text: (index + 1).toString(),
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
