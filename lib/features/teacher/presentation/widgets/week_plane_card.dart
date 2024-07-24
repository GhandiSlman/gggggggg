// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/teacher/controller/week_plane_controller.dart';
import 'package:lms/features/teacher/model/week_plane_model.dart';
import 'package:lms/features/teacher/presentation/widgets/slidable_action.dart';

class WeekPlaneCard extends StatelessWidget {
  WeekPlaneDetails weekPlaneDetails;
  String title;
  String date;
  WeekPlaneCard({
    super.key,
    required this.title,
    required this.date,
    required this.weekPlaneDetails,
  });

  @override
  Widget build(BuildContext context) {
    WeekPlaneController weekPlaneController = Get.find();
    PostController postController = Get.find();
    return Slidable(
      enabled: box.read('id') == weekPlaneDetails.teacherId,
      startActionPane:
          ActionPane(extentRatio: 0.5, motion: const ScrollMotion(), children: [
        SlidableActionTecherWidget(
          onTap: () {
            weekPlaneController.deleteWeekPlane(weekPlaneDetails.id!);
          },
          color: AppColor.redColor,
          label: 'Delete'.tr,
          imagePath: 'assets/delete.svg',
        ),
        SlidableActionTecherWidget(
          onTap: () {
            Get.toNamed(AppRouter.addToWeekPlaneScreen, arguments: {
              'weekPlaneId': weekPlaneDetails.id,
              'isUpdate': weekPlaneController.isUpdate == false,
              'desCon': weekPlaneController.lessonDateController.text =
                  weekPlaneDetails.lessonDescription!,
              'titleCon': weekPlaneController.lessonTitleController.text =
                  weekPlaneDetails.lessonTitle!,
              'dateCon': weekPlaneController.lessonDateController.text =
                  weekPlaneDetails.lessonDate!,
            });
          },
          color: AppColor.primaryColor,
          label: 'Edit'.tr,
          imagePath: 'assets/edit.svg',
        ),
      ]),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRouter.commentScreen, arguments: {
            'isCommentWeekPlane': postController.isCommentWeelPlane == true,
            'descCon': weekPlaneController.lessonDateController.text =
                weekPlaneDetails.lessonDescription!,
            'weekPlaneId': weekPlaneDetails.id,
          });
        },
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10.r)),
            height: 80.h,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 7.h,
                ),
                child: ListTile(
                  isThreeLine: true,
                  leading: SvgPicture.asset(AppImages.oneImage),
                  title: CustomText(
                    text: title,
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  ),
                  subtitle: Row(
                    children: [
                      SvgPicture.asset(AppImages.dateImage),
                      SizedBox(width: 5.w),
                      CustomText(text: date)
                    ],
                  ),
                ))),
      ),
    );
  }
}
