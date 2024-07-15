// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/posts/presentation/widgets/add_image_button.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    final arguments = Get.arguments;
    final postId = arguments['postId'];
    final isUpdate = arguments['isUpdate'];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: isUpdate == true ? 'Update Post'.tr : 'Add Post'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Text'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                CustomTextField(
                  controller: postController.descController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  maxLine: 6,
                  hint: 'Enter text of post'.tr,
                ),
                5.verticalSpace,
                isUpdate
                    ? const SizedBox()
                    : CustomText(
                        color: AppColor.greyColor2,
                        text: 'Images/Added videos'.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                5.verticalSpace,
                isUpdate
                    ? const SizedBox()
                    : Obx(() {
                        return SizedBox(
                          height: 80.h,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10.w,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: postController.images.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return const AddImageButton();
                              }
                              String imagePath =
                                  postController.images[index - 1];
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
                  text: 'Class'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5.h),
                DropDownList(
                  onSelectedItems: (List<SelectedListItem> selectedItems) {
                    if (selectedItems.isNotEmpty) {
                      String selectedName = selectedItems.last.name;
                      postController.updateSelectedClass(selectedName);

                      String? classId =
                          postController.gradeToIdMap[selectedName];
                      if (classId != null) {
                        postController.updateSelectedSectionId(classId);
                      }
                      String? gradeId =
                          postController.intgradeToIdMap[selectedName];
                      if (gradeId != null) {
                        postController.updateSelectedGradeId(gradeId);
                      }
                    }
                  },
                  dataList: postController.classList.toList(),
                  textEditingController: postController.classController,
                  hint: 'Choose class'.tr,
                  isCitySelected: true,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Obx(
                  () => postController.isLoadingAddPost.value
                      ? const LoadingWidget()
                      : CustomButton(
                          text: isUpdate == true ? 'Update Post'.tr : 'Post'.tr,
                          onTap: () {
                            isUpdate == true
                                ? postController
                                    .updatePost(postId)
                                    .then((value) {
                                    postController.getClasses();
                                    Get.back();
                                    Get.back();
                                  })
                                : postController.addPost().then((value) {
                                    postController.getClasses();
                                    Get.back();
                                  });
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
