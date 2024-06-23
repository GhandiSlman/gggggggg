import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   /// AuthController loginController = Get.find();
    return Stack(
      children: [
        Container(
          height: 125.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r)),
            color: AppColor.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColor.scaffoldColor),
                  height: 20.h,
                  width: 25.w,
                  child: Center(
                    child: Icon(
                      Icons.notifications_none_sharp,
                      color: AppColor.primaryColor2,
                      size: 20.sp,
                    ),
                  ),
                ),
                CustomText(
                  color: AppColor.primaryColor2,
                  text: 'Home'.tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.scaffoldColor),
                    height: 20.h,
                    width: 25.w,
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color: AppColor.primaryColor2,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 80.h,
            left: 20.w,
            right: 20.w,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.greyColor,
                        offset: const Offset(5, 5),
                        blurRadius: 2.r)
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                  color:  box.read('userType') == 'teacher'? AppColor.redColor : AppColor.amberColor,
                ),
                width: double.infinity,
                height: 125.h,
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    CircleAvatar(
                      maxRadius: 40.r,
                      backgroundColor: AppColor.whiteColor,
                      child: Center(
                        child: CircleAvatar(
                          maxRadius: 35.r,
                          backgroundImage: AssetImage(AppImages.personImage),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                width: double.infinity,
                height: 125.h,
                child: Image.asset(
                  AppImages.backGroundImage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
