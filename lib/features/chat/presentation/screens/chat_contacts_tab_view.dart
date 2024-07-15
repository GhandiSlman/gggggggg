import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/features/chat/controller/chat_controller.dart';
import 'package:lms/features/chat/models/contact_model.dart';
import 'package:lms/features/chat/presentation/widgets/chat_contact_card.dart';

class ChatContactsTabView extends GetView<ChatController> {
  const ChatContactsTabView(this.list, {super.key});
  final List<ContactModel> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Obx(
          () => !controller.getContactsIsLoading.value
              ? ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (_, index) =>
                      ChatCard(contactModel: list[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      16.verticalSpace,
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
