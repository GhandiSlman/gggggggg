import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/home/controller/home_controller.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    String userType = box.read('userType');

    final List<String> titles = userType == 'teacher'
        ? homeController.techerTitle
        : userType == 'supervisor'
            ? homeController.superVisorTitle
            : userType == 'guardian'
                ? homeController.parentTitle
                : homeController.studentTitle;

    final List<SvgPicture> images = userType == 'teacher'
        ? homeController.teacherImages
        : userType == 'supervisor'
            ? homeController.superVisorImages
            : userType == 'guardian'
                ? homeController.parentImages
                : homeController.studentImages;

    final List onPressedActions = userType == 'teacher'
        ? homeController.teacherOnPressed
        : userType == 'supervisor'
            ? homeController.superVisorOnPressed
            : userType == 'guardian'
                ? homeController.parentPressed
                : homeController.studentOnPressed;

    final int itemCount = titles.length;

    return SingleChildScrollView(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 30.h,
          horizontal: 36.w,
        ),
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          BoxDecoration boxDecoration = BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: homeController.teacherColorList[
                index % homeController.teacherColorList.length],
            gradient: index == 2 ||
                    index == 3 ||
                    index == 4 ||
                    index == 6 ||
                    index == 7
                ? LinearGradient(
                    colors: index == 2
                        ? AppColor.griedentTow
                        : index == 3
                            ? AppColor.griedentOne
                            : index == 4
                                ? AppColor.griedentThree
                                : index == 6
                                    ? AppColor.griedentFour
                                    : AppColor.griedentFive,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
          );

          return InkWell(
            onTap: onPressedActions[index],
            child: Container(
              decoration: boxDecoration,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Expanded(
                    child: Center(
                      child: images[index],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomText(
                    text: titles[index],
                    color: AppColor.whiteColor,
                    fontSize: 15.sp,
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 1 / 0.7,
        ),
      ),
    );
  }
}
