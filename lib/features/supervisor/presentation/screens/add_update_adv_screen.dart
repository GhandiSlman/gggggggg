// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/posts/presentation/widgets/add_image_button.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';

class AddUpdateAdvScreen extends StatelessWidget {
  const AddUpdateAdvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AdvertisementsController advertisementsController = Get.find();
    //final arguments = Get.arguments;
    //final postId = arguments['postId'];
   // final isUpdate = arguments['isUpdate'];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Add Advertisement'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Images'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                Obx(() {
                        return SizedBox(
                          height: 80.h,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10.w,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: advertisementsController.images.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return const AddImageButton();
                              }
                              String imagePath =
                                  advertisementsController.images[index - 1];
                              return Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  border:
                                      Border.all(color: AppColor.primaryColor),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      5.verticalSpace,
                       CustomText(
                  color: AppColor.greyColor2,
                  text: 'Title'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                CustomTextField(
                  controller: advertisementsController.descController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter title of advertisement'.tr,
                ),
                25.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Text'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                CustomTextField(
                  controller: advertisementsController.descController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  maxLine: 6,
                  hint: 'Enter text of advertisement'.tr,
                ),
                5.verticalSpace,
                SizedBox(
                  height: 25.h,
                ),
                Obx(
                  () => advertisementsController.isLoadingAddUpdateAd.value
                      ? const LoadingWidget()
                      : CustomButton(
                          text: 'Add'.tr,
                          onTap: () {
                            // postController.isUpdatePost
                            //     ? postController.updatePost(postId)
                            //     : postController.addPost();
                          },
                          color: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
