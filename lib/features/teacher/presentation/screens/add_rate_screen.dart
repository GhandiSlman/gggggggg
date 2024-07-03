import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/teacher/controller/continuous_rating_controller.dart';

class AddRate extends StatelessWidget {
  const AddRate({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final id = arguments['id'];
    final isUpdated = arguments['isUpdate'];
    ContinuousRatingController continuousRatingController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: isUpdated == true ? 'Add Rate'.tr : 'Update Rate'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    fontSize: 18.sp,
                    color: AppColor.greyColor2,
                    fontWeight: FontWeight.bold,
                    text: 'Rate details'.tr),
                10.verticalSpace,
                CustomTextField(
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  maxLine: 6,
                  hint: 'Enter rate details'.tr,
                  controller: continuousRatingController.rateController,
                ),
                10.verticalSpace,
                CustomText(
                    fontSize: 18.sp,
                    color: AppColor.greyColor2,
                    fontWeight: FontWeight.bold,
                    text: 'Add points'.tr),
                10.verticalSpace,
                CustomTextField(
                  keyboardType: TextInputType.number,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter points number'.tr,
                  controller: continuousRatingController.pointController,
                ),
                100.verticalSpace,
                Obx(
                  () => continuousRatingController.isLoadingAddCon.value
                      ? const LoadingWidget()
                      : CustomButton(
                          color: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                          width: double.infinity,
                          text: isUpdated == true
                              ? 'Add Rate'.tr
                              : 'Update Rate'.tr,
                          onTap: () {
                            isUpdated == true
                                ? continuousRatingController
                                    .addRate()
                                    .then((value) {
                                    Get.back();
                                    continuousRatingController
                                        .getContinuousRating();
                                  })
                                : continuousRatingController
                                    .updateRate(id)
                                    .then((value) {
                                    Get.back();
                                    continuousRatingController
                                        .getContinuousRating();
                                  });
                          }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
