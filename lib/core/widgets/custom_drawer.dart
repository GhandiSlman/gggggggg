import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/local/local_controller.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/auth/controller/auth_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.find();
    AuthController authController = Get.find();
    return Drawer(
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                color: box.read('userType') == 'teacher'
                    ? AppColor.redColor
                    : box.read('userType') == 'supervisor'
                        ? AppColor.orangeColor
                        : box.read('userType') == 'guardian'
                            ? AppColor.greenHeader
                            : AppColor.amberColor,
                height: 140.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    CircleAvatar(
                      maxRadius: 40.r,
                      backgroundColor: AppColor.whiteColor,
                      child: Center(
                        child: CircleAvatar(
                          maxRadius: 35.r,
                          backgroundImage: AssetImage(AppImages.childrenImage),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Ghandi Alslman',
                          color: AppColor.whiteColor,
                          fontSize: 20.sp,
                        ),
                        CustomText(
                          text: 'Fourth year',
                          color: AppColor.whiteColor,
                          fontSize: 15.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Image.asset(AppImages.backGroundImage),
              ),
            ],
          ),
          box.read('userType') == 'supervisor'
              ? ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset(AppImages.teacherBlueImage),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomText(
                        text: 'Teachers'.tr,
                        color: AppColor.primaryColor,
                      )
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.primaryColor,
                    size: 20.sp,
                  ),
                )
              : const SizedBox(),
          box.read('userType') == 'teacher'
              ? InkWell(
                  onTap: () {
                    Get.toNamed(AppRouter.parentHonorBoardScreen);
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset(AppImages.honorSmallImage),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomText(
                          text: 'Honor board'.tr,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                )
              : const SizedBox(),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppImages.shareImage),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: 'Share app'.tr,
                  color: AppColor.primaryColor,
                )
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.primaryColor,
              size: 20.sp,
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppImages.contactUsImage),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: 'Contact Us'.tr,
                  color: AppColor.primaryColor,
                )
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.primaryColor,
              size: 20.sp,
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppImages.aboutImage),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: 'About Us'.tr,
                  color: AppColor.primaryColor,
                )
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.primaryColor,
              size: 20.sp,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouter.settingsScreen);
            },
            child: ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(AppImages.settingsImage),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    text: 'Settings'.tr,
                    color: AppColor.primaryColor,
                  )
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.primaryColor,
                size: 20.sp,
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     localeController.changeLocal('ar');
          //   },
          //   child: ListTile(
          //     title: Row(
          //       children: [
          //         //SvgPicture.asset(AppImages),
          //         const Icon(Icons.language_outlined),
          //         SizedBox(
          //           width: 5.w,
          //         ),
          //         CustomText(
          //           text: 'Arabic'.tr,
          //           color: AppColor.primaryColor,
          //         )
          //       ],
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios_rounded,
          //       color: AppColor.primaryColor,
          //       size: 20.sp,
          //     ),
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     localeController.changeLocal('en');
          //   },
          //   child: ListTile(
          //     title: Row(
          //       children: [
          //         //SvgPicture.asset(AppImages),
          //         const Icon(Icons.language_outlined),
          //         SizedBox(
          //           width: 5.w,
          //         ),
          //         CustomText(
          //           text: 'English'.tr,
          //           color: AppColor.primaryColor,
          //         )
          //       ],
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios_rounded,
          //       color: AppColor.primaryColor,
          //       size: 20.sp,
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: () {
              authController.logOut();
            },
            child: ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(AppImages.logOutImage),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    text: 'Log Out'.tr,
                    color: AppColor.redColor,
                  )
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.redColor,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
