// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/teacher/controller/activity_controller.dart';
import 'package:lms/features/teacher/model/activity.dart';
import 'package:lms/features/teacher/model/test_activity.dart';

class ActivityCard extends StatelessWidget {
  Activity? activity;
  ActivityIndex? activityIndex;
  String date;
  String desc;
  String title;
  String sectionName;
  ActivityCard({
    super.key,
    this.activity,
    required this.title,
    this.activityIndex,
    required this.date,
    required this.desc,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    ActivityController activityController = Get.find();
    return Container(
      height: 175.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.whiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Row(
              children: [
                SvgPicture.asset(AppImages.date2Image),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        color: AppColor.primaryColor,
                        fontSize: 20.h,
                      ),
                      box.read('userType') == 'teacher'
                          ? Row(
                              children: [
                                SvgPicture.asset(AppImages.dateImage),
                                2.horizontalSpace,
                                FittedBox(
                                  child: CustomText(
                                    text: date,
                                    //fontSize: 20.h,
                                  ),
                                ),
                                8.horizontalSpace,
                                Expanded(
                                  child: AutoSizeText(
                                    sectionName,
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      //   fontSize: 18.sp,
                                    ),
                                    maxLines: 1,
                                    minFontSize: 5.sp,
                                    maxFontSize: 10.sp,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            )
                          : AutoSizeText(
                              sectionName,
                              style: TextStyle(
                                color: AppColor.greyColor3,
                                //   fontSize: 18.sp,
                              ),
                              maxLines: 1,
                              minFontSize: 5.sp,
                              maxFontSize: 10.sp,
                              overflow: TextOverflow.visible,
                            ),
                    ],
                  ),
                ),
                if (box.read('useType') == 'teacher')
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Obx(
                              () => activityController.isLoadingDelete.value
                                  ? const LoadingWidget()
                                  : SimpleDialog(
                                      children: [
                                        ListTile(
                                          title: CustomText(text: 'Update'.tr),
                                          leading: SvgPicture.asset(
                                              AppImages.updateImage),
                                          onTap: () {
                                            Get.toNamed(AppRouter.addActivity,
                                                arguments: {
                                                  'activityId': activity!.id,
                                                  'isUpdate': activityController
                                                          .isUpdated ==
                                                      false,
                                                  'desCon': activityController
                                                          .descriptionController
                                                          .text =
                                                      activity!.description!,
                                                  'titleCon': activityController
                                                      .titleController
                                                      .text = activity!.title!,
                                                  'dateCon': activityController
                                                      .dateController
                                                      .text = activity!.date!,
                                                });
                                          },
                                        ),
                                        ListTile(
                                          title: CustomText(text: 'Delete'.tr),
                                          leading: SvgPicture.asset(
                                              AppImages.delete2Image),
                                          onTap: () {
                                            activityController
                                                .deleteActivity(activity!.id!)
                                                .then((value) => Get.back());
                                          },
                                        ),
                                      ],
                                    ));
                        },
                      );
                    },
                    icon: const Icon(Icons.more_horiz),
                  )
                else
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.dateImage),
                      2.horizontalSpace,
                      CustomText(
                        text: date,
                        //fontSize: 20.h,
                        color: AppColor.greyColor3,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: AutoSizeText(
                desc,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  //   fontSize: 18.sp,
                ),
                maxLines: 8,
                minFontSize: 10.sp,
                maxFontSize: 16.sp,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
