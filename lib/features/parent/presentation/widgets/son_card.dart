import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';

class SonCard extends StatelessWidget {
  const SonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouter.sonAchievementScreen);
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
                      child: Image.network(
                        'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
                title: CustomText(
                  text: 'Ghandi',
                  fontSize: 20.sp,
                  color: AppColor.primaryColor,
                ),
                subtitle: const CustomText(text: 'First class'),
                trailing: SvgPicture.asset(AppImages.cupImage),
              ))),
    );
  }
}
