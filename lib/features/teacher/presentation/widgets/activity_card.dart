// ignore_for_file: must_be_immutable
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

class ActivityCard extends StatelessWidget {
  Activity? activity;
  String date;
  String desc;
  String title;
  String? sectionName;
  final int teacherId;
  ActivityCard({
    super.key,
    this.activity,
    required this.title,
    required this.date,
    required this.desc,
    this.sectionName,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    ActivityController activityController = Get.find();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.whiteColor,
      ),
      padding: EdgeInsets.all(14.h),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.date2Image),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColor.primaryColor,
                  fontSize: 17.h,
                ),
                4.verticalSpace,
                CustomText(
                  text: desc,
                  color: AppColor.greyColor,
                  fontSize: 14.h,
                  maxLine: 5,
                ),
                4.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(AppImages.dateImage),
                    2.horizontalSpace,
                    Expanded(child: CustomText(text: date)),
                    8.horizontalSpace,
                  ],
                )
              ],
            ),
          ),
          if (box.read('userType') == 'teacher' && box.read('id') == teacherId)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Obx(() => activityController.isLoadingDelete.value
                        ? const LoadingWidget()
                        : Dialog(
                            child: SizedBox(
                            height: 120,
                            child: Center(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: CustomText(text: 'Update'.tr),
                                    leading:
                                        SvgPicture.asset(AppImages.updateImage),
                                    onTap: () {
                                      Get.toNamed(AppRouter.addActivity,
                                          arguments: {
                                            'activityId': activity!.id,
                                            'isUpdate':
                                                activityController.isUpdated ==
                                                    false,
                                            'desCon': activityController
                                                .descriptionController
                                                .text = activity!.description!,
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
                              ),
                            ),
                          )));
                  },
                );
              },
              icon: const Icon(Icons.more_horiz),
            )
        ],
      ),
    );
  }
}
