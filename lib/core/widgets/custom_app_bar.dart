import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: AppColor.primaryColor2),
      ),
      leading: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColor.scaffoldColor),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.primaryColor2,
                size: 20.sp,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColor.scaffoldColor),
            height: 20.h,
            width: 20.w,
            child: Center(child: SvgPicture.asset(AppImages.notiImage)),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
