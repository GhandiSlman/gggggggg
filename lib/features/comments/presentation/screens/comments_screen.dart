import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/comments/controller/comment_controller.dart';
import 'package:lms/features/comments/presentation/widgets/comment_card.dart';
import 'package:lms/features/comments/presentation/widgets/comment_image_button.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.find();
    final arguments = Get.arguments;
    final postId = arguments['postId'];
    final isCommentWeekPlane = arguments['isCommentWeekPlane'];
    final lessonDescription = arguments['descCon'];
    final weekPlaneId = arguments['weekPlaneId'];

    return Scaffold(
      appBar: isCommentWeekPlane == false
          ? const CustomAppBar(title: 'Lesson details')
          : null,
      backgroundColor: AppColor.commentScaffoldColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: isCommentWeekPlane == false ? 20.h : 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isCommentWeekPlane == true
                ? CustomText(
                    text: 'Comments'.tr,
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  )
                : const SizedBox.shrink(),
            if (!isCommentWeekPlane)
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                child: CustomText(
                  text: lessonDescription,
                  fontSize: 16.sp,
                  color: AppColor.primaryColor,
                  maxLine: 10,
                ),
              ),
            isCommentWeekPlane == false
                ? const Divider()
                : const SizedBox.shrink(),
            isCommentWeekPlane == false
                ? CustomText(
                    text: 'Comments on the lesson'.tr,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  )
                : const SizedBox.shrink(),
            isCommentWeekPlane == false
                ? 10.verticalSpace
                : const SizedBox.shrink(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          if (commentController.isLoadingComment.value) {
                            return ListView.separated(
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return ShimmerWidget(height: 20.h);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 20.h);
                              },
                            );
                          } else if (isCommentWeekPlane
                              ? commentController.commentsList.isEmpty
                              : commentController
                                  .commentWeekPlaneList.isEmpty) {
                            return Center(
                              child: CustomText(
                                text: 'No Comments',
                                color: AppColor.primaryColor,
                                fontSize: 20.sp,
                              ),
                            );
                          } else {
                            return ListView.separated(
                              controller: commentController.scrollController,
                              itemCount: isCommentWeekPlane == true
                                  ? commentController.commentsList.length
                                  : commentController
                                      .commentWeekPlaneList.length,
                              itemBuilder: (context, index) {
                                final comment = isCommentWeekPlane == true
                                    ? commentController.commentsList[index]
                                    : commentController
                                        .commentWeekPlaneList[index];

                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: CommentCard(
                                    comments: comment,
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 50.h,
                                );
                              },
                            );
                          }
                        }),
                      ),
                      SizedBox(height: 20.h),
                      Obx(() => Form(
                            key: commentController.formKey,
                            child: CustomTextField(
                              validator:
                                  ValidationBuilder().minLength(1).build(),
                              controller: isCommentWeekPlane == true
                                  ? commentController.comment
                                  : commentController.commentWeekPlane,
                              maxLine: 2,
                              minLine: 1,
                              onChanged: (String val) {
                                val.isEmpty
                                    ? commentController.isTyping.value = false
                                    : commentController.isTyping.value = true;
                              },
                              hint: 'Write a comment ..'.tr,
                              filled: true,
                              filledColor: AppColor.whiteColor,
                              suffix: Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: commentController.isTyping.value
                                      ? CommentImageButton(
                                          onTap: () {
                                            if (commentController
                                                .formKey.currentState!
                                                .validate()) {
                                              isCommentWeekPlane == true
                                                  ? commentController
                                                      .addComment(postId)
                                                  : commentController
                                                      .addCommentWeekPlane(
                                                          weekPlaneId);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            color: AppColor.whiteColor,
                                          ))
                                      : CommentImageButton(
                                          icon: SvgPicture.asset(
                                              AppImages.cameraImage),
                                        )),
                            ),
                          )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
