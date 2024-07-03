import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/local/local_controller.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';

class SettingSreen extends StatelessWidget {
  const SettingSreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController localeController = Get.put(LocaleController());

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Settings'.tr),
      body: Padding(
        padding: EdgeInsets.all(15.h),
        child: Column(
          children: [
            25.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: AppColor.primaryColor,
                ),
                10.horizontalSpace,
                CustomText(
                  text: 'Language'.tr,
                  color: AppColor.primaryColor,
                  fontSize: 20.sp,
                ),
              ],
            ),
            20.verticalSpace,
            Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => ListTile(
                      title: CustomText(
                        text: 'Arabic'.tr,
                        color: AppColor.primaryColor,
                      ),
                      trailing: localeController.currentLanguage == 'Arabic'
                          ? SvgPicture.asset(AppImages.activeLang)
                          : SvgPicture.asset(AppImages.unActiveLang),
                      onTap: () => localeController.changeLocale('ar'),
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      title: CustomText(
                        text: 'English'.tr,
                        color: AppColor.primaryColor,
                      ),
                      trailing: localeController.currentLanguage == 'English'
                          ? SvgPicture.asset(AppImages.activeLang)
                          : SvgPicture.asset(AppImages.unActiveLang),
                      onTap: () => localeController.changeLocale('en'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
