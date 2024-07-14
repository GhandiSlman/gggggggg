import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/features/chat/controller/chat_controller.dart';
import 'package:lms/features/supervisor/presentation/widgets/chat_card.dart';

class SuperVisorChatScreen extends GetView<ChatController> {
  const SuperVisorChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Obx(
          () => !controller.getContactsIsLoading.value
              ? ListView.separated(
                  itemCount:
                      controller.teacherContactsModel!.supervisors.length,
                  itemBuilder: (_, index) {
                    return ChatCard(
                      contactModel:
                          controller.teacherContactsModel!.supervisors[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 20.h),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
