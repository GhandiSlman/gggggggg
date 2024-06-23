import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/features/comments/presentation/widgets/comment_image_button.dart';
import 'package:lms/features/teacher/controller/teacher_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/message_card.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: const CustomAppBar(title: 'Ghandi'),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return const MessageCard();
                },
                itemCount: 5,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 10.h,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Obx(() => CustomTextField(
                  minLine: 1,
                  maxLine: 2,
                  onChanged: (String val) {
                    val.isEmpty
                        ? teacherController.isTyping.value = false
                        : teacherController.isTyping.value = true;
                  },
                  hint: 'Type your message ..'.tr,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  suffix: Padding(
                      padding: EdgeInsets.all(
                        10.h,
                      ),
                      child: teacherController.isTyping.value
                          ? CommentImageButton(
                              icon: Icon(
                                Icons.send,
                                color: AppColor.whiteColor,
                              ),
                            )
                          : CommentImageButton(
                              icon: SvgPicture.asset(AppImages.cameraImage),
                            )),
                ))
          ],
        ),
      ),
    );
  }
}
