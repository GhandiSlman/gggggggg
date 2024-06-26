import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/features/supervisor/presentation/widgets/chat_card.dart';

class SuperVisorChatScreen extends StatelessWidget {
  const SuperVisorChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (_, index) {
            return const ChatCard();
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 20.h
          ),
        ),
      ),
    );
  }
}
