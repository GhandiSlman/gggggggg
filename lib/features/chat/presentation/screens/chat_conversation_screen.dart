import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/features/chat/controller/chat_controller.dart';
import 'package:lms/features/chat/models/contact_model.dart';
import 'package:lms/features/chat/models/send_message_model.dart';
import 'package:lms/features/comments/presentation/widgets/comment_image_button.dart';
import 'package:lms/features/teacher/controller/teacher_controller.dart';
import 'package:lms/features/chat/presentation/widgets/message_card.dart';

class ChatConversationScreen extends GetView<ChatController> {
  const ChatConversationScreen({super.key, required this.contactModel});
  final ContactModel contactModel;
  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: contactModel.name),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                var chatController = Get.find<ChatController>();
                if (chatController.getConversationsIsLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                var messages = chatController.messages.reversed.toList();
                return ListView.separated(
                    dragStartBehavior: DragStartBehavior.down,
                    reverse: true,
                    controller: chatController.scrollController,
                    itemBuilder: (BuildContext context, int index) =>
                        MessageCard(message: messages[index]),
                    itemCount: messages.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        12.verticalSpace);
              }),
            ),
            SizedBox(height: 10.h),
            Obx(() => CustomTextField(
                  controller: controller.textController,
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
                              onTap: () {
                                controller.sendMessage(SendMessageModel(
                                  message: controller.textController.text,
                                  receiverId: contactModel.id,
                                ));
                              },
                            )
                          : CommentImageButton(
                              icon: SvgPicture.asset(AppImages.cameraImage),
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  controller.sendMessage(SendMessageModel(
                                    image: pickedFile.path,
                                    receiverId: contactModel.id,
                                  ));
                                }
                              },
                            )),
                ))
          ],
        ),
      ),
    );
  }
}
