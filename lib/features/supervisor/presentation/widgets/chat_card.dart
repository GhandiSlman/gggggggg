import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/chat/controller/chat_controller.dart';
import 'package:lms/features/chat/models/contact_model.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.contactModel});

  final ContactModel contactModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<ChatController>().getConversations(contactModel.id);
        Get.toNamed(AppRouter.chatDetails,arguments: contactModel);
      },
      child: ListTile(
        tileColor: AppColor.whiteColor,
        leading: ClipRRect(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.whiteColor,
              ),
              child: Image.asset(
                'assets/person.png',
                fit: BoxFit.fill,
              )),
        ),
        title: CustomText(
          text: contactModel.name,
          color: AppColor.primaryColor,
        ),
        subtitle: CustomText(
          text: contactModel.lastMessageDate != null
              ? formatDurationToString(
                  DateTime.now().difference(contactModel.lastMessageDate!))
              : "",
          color: AppColor.greyColor2,
        ),
        // trailing:  CircleAvatar(
        //   backgroundColor: AppColor.primaryColor,
        //   child: Center(
        //     child: CustomText(
        //       text: '10',
        //       color: AppColor.whiteColor,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

String formatDurationToString(Duration duration) {
  final int days = duration.inDays;
  final int hours = duration.inHours.remainder(24);
  final int minutes = duration.inMinutes.remainder(60);
  final int seconds = duration.inSeconds.remainder(60);

  List<String> parts = [];

  if (days > 0) {
    parts.add("$days days ");
  }

  if (hours > 0 || (parts.isNotEmpty && parts.last.endsWith('day'))) {
    parts.add("${hours} hours ");
  }

  if (minutes > 0 || (parts.isNotEmpty && parts.last.endsWith('hour'))) {
    parts.add("${minutes} minutes ");
  }

  if (seconds > 0) {
    parts.add("just now");
  }
  if (parts.length > 1) parts.removeLast();
  // Remove trailing space and join the parts
  return parts.join().trim();
}
