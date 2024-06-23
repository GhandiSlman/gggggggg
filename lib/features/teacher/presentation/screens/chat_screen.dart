import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/features/parent/presentation/screens/parent_chat_screen.dart';
import 'package:lms/features/supervisor/presentation/screens/super_visor_chats_screen.dart';

import '../../controller/teacher_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.put(TeacherController());
    return  Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: 'Chats'.tr,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Column(
              children: [
                
                TabBar(
                  indicatorColor: AppColor.primaryColor,
                  labelColor: AppColor.primaryColor,
                  controller: teacherController.tabController,
                  tabs: teacherController.chat,
                ),
              ],
            ),
          )),
      body: TabBarView(
        controller: teacherController.tabController,
        children: const [
          SuperVisorChatScreen(),
          ParentChatScreen(),
        ],
      ),
    );
  }
}
