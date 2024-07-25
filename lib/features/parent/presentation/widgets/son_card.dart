// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/parent/model/my_children.dart';

class SonCard extends StatelessWidget {
  SonModel son;
  SonCard({super.key, required this.son});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.sonAchievementScreen, arguments: son);
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
              ),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  height: 125.h,
                  width: 60.w,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        AppImages.childImage,
                        fit: BoxFit.cover,
                      )),
                ),
                title: CustomText(
                  text: son.name,
                  fontSize: 20.sp,
                  color: AppColor.primaryColor,
                ),
                subtitle: CustomText(text: ""),
                trailing: SvgPicture.asset(AppImages.cupImage),
              ))),
    );
  }
}
