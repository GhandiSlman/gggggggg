import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';

class HomeController extends GetxController {
  //Teacher//
  final List<String> techerTitle = [
    'Student Attendance'.tr,
    'Class table'.tr,
    'Activity'.tr,
    'Home Work'.tr,
    'Daily Coverage'.tr,
    'Chats'.tr,
    'Continuous Rating'.tr,
    'Week Plan'.tr,
  ];

  final List<SvgPicture> teacherImages = [
    SvgPicture.asset(AppImages.studentAImage),
    SvgPicture.asset(AppImages.classTableImage),
    SvgPicture.asset(AppImages.activityImage),
    SvgPicture.asset(AppImages.date3Image),
    SvgPicture.asset(AppImages.dailyCoverImage),
    SvgPicture.asset(AppImages.mmessageImage),
    SvgPicture.asset(AppImages.rateImage),
    SvgPicture.asset(AppImages.weekPlaneImage),
  ];

  final List teacherOnPressed = [
    () => Get.toNamed(AppRouter.studentScreen),
    () => Get.toNamed(AppRouter.classScheduleScreen),
    () => Get.toNamed(AppRouter.activityScreen),
    () => Get.toNamed(AppRouter.techerClassRoomScreen),
    () => Get.toNamed(AppRouter.postScreen),
    () => Get.toNamed(AppRouter.chatScreen),
    () => Get.toNamed(AppRouter.continousRatingScreen),
    () => Get.toNamed(AppRouter.teacherWeekPlane),
  ];

  final List<Color> teacherColorList = AppColor.colorList;

  //super visor

  final List<String> superVisorTitle = [
    'Student Attendance'.tr,
    'Chats'.tr,
    'Daily Coverage'.tr,
    'Activity'.tr,
    'Advertisements'.tr,
    'News'.tr,
  ];

  final List<SvgPicture> superVisorImages = [
    SvgPicture.asset(AppImages.studentAImage),
    SvgPicture.asset(AppImages.mmessageImage),
    SvgPicture.asset(AppImages.dailyCoverImage),
    SvgPicture.asset(AppImages.activityImage),
    SvgPicture.asset(AppImages.adImage),
    SvgPicture.asset(AppImages.newsImage),
  ];

  final List superVisorOnPressed = [
    () => Get.toNamed(AppRouter.superVisorPresence),
    () => Get.toNamed(AppRouter.chatScreen),
    () => Get.toNamed(AppRouter.postScreen),
    () => Get.toNamed(AppRouter.activityScreen),
    () => Get.toNamed(AppRouter.advertisementsScreen),
    () => Get.toNamed(AppRouter.newsScreen),
  ];

  //parent

  final List<String> parentTitle = [
    'My children'.tr,
    'Honor board'.tr,
    'Daily Coverage'.tr,
    'Chats'.tr,
  ];

  final List parentPressed = [
    () => Get.toNamed(AppRouter.sonsScreen),
    () => Get.toNamed(AppRouter.parentHonorBoardScreen),
    () => Get.toNamed(AppRouter.postScreen),
    () => Get.toNamed(AppRouter.chatScreen),
  ];

  final List<SvgPicture> parentImages = [
    SvgPicture.asset(AppImages.myChildrenImage),
    SvgPicture.asset(AppImages.honorPanelImage),
    SvgPicture.asset(AppImages.dailyCoverImage),
    SvgPicture.asset(AppImages.mmessageImage),
  ];

  //Student//

  final List<String> studentTitle = [
    'Honor board'.tr,
    'Class table'.tr,
    'Activity'.tr,
    'Home Work'.tr,
    'Daily Coverage'.tr,
    'Chats'.tr,
    'Continuous Rating'.tr,
    'Week Plan'.tr,
  ];

  final List<SvgPicture> studentImages = [
    SvgPicture.asset(AppImages.honorPanelImage),
    SvgPicture.asset(AppImages.classTableImage),
    SvgPicture.asset(AppImages.activityImage),
    SvgPicture.asset(AppImages.date3Image),
    SvgPicture.asset(AppImages.dailyCoverImage),
    SvgPicture.asset(AppImages.mmessageImage),
    SvgPicture.asset(AppImages.rateImage),
    SvgPicture.asset(AppImages.weekPlaneImage),
  ];

  final List studentOnPressed = [
    () {
      Get.toNamed(AppRouter.parentHonorBoardScreen);
    },
    () => Get.toNamed(AppRouter.classScheduleScreen),
    () => Get.toNamed(AppRouter.activityScreen),
    () => Get.toNamed(AppRouter.techerClassRoomScreen),
    () => Get.toNamed(AppRouter.postScreen),
    () => Get.toNamed(AppRouter.chatScreen),
    () => Get.toNamed(AppRouter.continousRatingScreen),
    () => Get.toNamed(
          AppRouter.teacherWeekPlane,
        ),
  ];

}
