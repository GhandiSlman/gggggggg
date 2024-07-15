import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/features/chat/controller/chat_controller.dart';
import 'package:lms/features/chat/presentation/screens/chat_contacts_tab_view.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({super.key});

  @override
  State<ChatContactsScreen> createState() => _ChatContactsScreenState();
}

TabController? tabController;

class _ChatContactsScreenState extends State<ChatContactsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    tabController = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.find<ChatController>();
    controller.getContacts();
    return Obx(() {
      if (Get.find<ChatController>().getContactsIsLoading.value) {
        return Scaffold(
            appBar: CustomAppBar(title: 'Chats'.tr),
            body: const Center(child: CircularProgressIndicator()));
      }
      int length = 0;
      if (controller.contactsModel?.teachers != null) length++;
      if (controller.contactsModel?.guardians != null) length++;
      if (controller.contactsModel?.students != null) length++;
      if (controller.contactsModel?.supervisors != null) length++;
      tabController ??= TabController(length: length, vsync: this);
      return Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        appBar: CustomAppBar(
            title: 'Chats'.tr,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    indicatorColor: AppColor.primaryColor,
                    labelColor: AppColor.primaryColor,
                    tabs: [
                      if (controller.contactsModel?.teachers != null)
                        Tab(text: 'Teachers'.tr),
                      if (controller.contactsModel?.students != null)
                        Tab(text: 'Students'.tr),
                      if (controller.contactsModel?.supervisors != null)
                        Tab(text: 'Supervisors'.tr),
                      if (controller.contactsModel?.guardians != null)
                        Tab(text: 'Parents'.tr),
                    ],
                  ),
                ],
              ),
            )),
        body: TabBarView(
          controller: tabController,
          children: [
            if (controller.contactsModel?.teachers != null)
              ChatContactsTabView(list: controller.contactsModel!.teachers!),
            if (controller.contactsModel?.students != null)
              ChatContactsTabView(list: controller.contactsModel!.students!),
            if (controller.contactsModel?.supervisors != null)
              ChatContactsTabView(list: controller.contactsModel!.supervisors!),
            if (controller.contactsModel?.guardians != null)
              ChatContactsTabView(list: controller.contactsModel!.guardians!),
          ],
        ),
      );
    });
  }
}
