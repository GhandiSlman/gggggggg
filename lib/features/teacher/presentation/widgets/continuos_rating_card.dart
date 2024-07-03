// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/controller/continuous_rating_controller.dart';
import 'package:lms/features/teacher/model/continuous_rating.dart';
import 'package:lms/features/teacher/presentation/widgets/slidable_action.dart';

class ContinuousRatingCard extends StatelessWidget {
  ContinuousRatingData? continuousRatingData;
  String name;
  String rate;
  ContinuousRatingCard({
    super.key,
    required this.name,
    this.continuousRatingData,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    ContinuousRatingController continuousRatingController = Get.find();
    return Slidable(
        startActionPane: ActionPane(
            extentRatio: 0.5,
            motion: const ScrollMotion(),
            children: [
              SlidableActionTecherWidget(
                onTap: () {
                  continuousRatingController.deleteRate(continuousRatingData!.id!);
                },
                color: AppColor.redColor,
                label: 'Delete'.tr,
                imagePath: 'assets/delete.svg',
              ),
              SlidableActionTecherWidget(
                onTap: () {
                  Get.toNamed(AppRouter.addRate, arguments: {
                    'id': continuousRatingData!.id,
                    'isUpdate': continuousRatingController.isUpdate == true,
                    'nameCon': continuousRatingController.rateController.text =
                        continuousRatingData!.name!,
                    'pointCon': continuousRatingController.pointController
                        .text = continuousRatingData!.xp.toString(),
                  });
                },
                color: AppColor.primaryColor,
                label: 'Edit'.tr,
                imagePath: 'assets/edit.svg',
              ),
            ]),
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
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.primaryColor,
                  ),
                  leading: SvgPicture.asset(AppImages.coRate),
                  title: CustomText(
                    text: name,
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColor.greyColor2,
                      ),
                      SizedBox(width: 5.w),
                      CustomText(text: rate)
                    ],
                  ),
                ))));
  }
}
