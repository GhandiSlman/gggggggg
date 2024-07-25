import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';

class SonRateCard extends StatelessWidget {
  final int xp;
  final String name;

  const SonRateCard({super.key, required this.name, required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    height: 10.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColor.scaffoldColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColor.primaryColor,
                        ),
                        SizedBox(
                          width: 20.w,
                          child: FittedBox(
                            child: CustomText(
                              text: '$xp',
                              color: AppColor.primaryColor,
                              fontSize: 15.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SvgPicture.asset(AppImages.cup2Image),
              ],
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100.w,
                  child: FittedBox(
                    child: CustomText(
                      text: name,
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColor.primaryColor),
                  child: Center(
                      child: CustomText(
                    text: 'Message parent'.tr,
                    color: AppColor.whiteColor,
                    fontSize: 13.sp,
                  )),
                ),
              ],
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                height: 100.h,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.childImage,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
