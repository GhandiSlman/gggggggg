import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';

class StudentStatusCard extends StatelessWidget {
  final String name;
  final String status;

  const StudentStatusCard({
    super.key,
    required this.name,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    switch (status) {
      case 'absent':
        statusColor = AppColor.redColor;
        statusText = 'absent';
        break;
      case 'present':
        statusColor = AppColor.primaryColor;
        statusText = 'present';
        break;
      case 'late':
        statusColor = AppColor.greyColor3;
        statusText = 'late';
        break;
      case 'excused':
        statusColor = AppColor.amber2Color;
        statusText = 'excused';
        break;
      default:
        statusColor = AppColor.greyColor3;
        statusText = status;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.whiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(7.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  height: 103.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child:Image.asset(AppImages.childImage)
                  ),
                ),
                10.verticalSpace,
                CustomText(
                  text: name,
                  color: AppColor.primaryColor,
                  fontSize: 18.sp,
                ),
                10.verticalSpace,
              ],
            ),
          ),
          Container(
            height: 23.5.h,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: Center(
              child: CustomText(
                text: statusText,
                color: AppColor.whiteColor,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
