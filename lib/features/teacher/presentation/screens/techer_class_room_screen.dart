import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/homework_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/subject_card.dart';

class TeacherClassRoomScreen extends StatelessWidget {
  const TeacherClassRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeWorkController homeWorkController = Get.find();
    return Scaffold(
      floatingActionButton: box.read('userType') == 'teacher'
          ? FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              onPressed: () => Get.toNamed(AppRouter.addHomeWork, arguments: {
                'isUpdate': homeWorkController.isUpdateHomeWork == true
              }),
              child: Icon(Icons.add, color: AppColor.whiteColor),
            )
          : null,
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'Home Work'.tr,
        bottom: box.read('userType') == 'teacher'
            ? PreferredSize(
                preferredSize: Size.fromHeight(125.h),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Obx(
                          () => homeWorkController.isLoadingSubject.value
                              ? ShimmerWidget(
                                  height: 50.h,
                                )
                              : DropDownList(
                                  onSelectedItems:
                                      (List<String> selectedItems) {
                                    if (selectedItems.isNotEmpty) {
                                      homeWorkController.updateSelectedClass(
                                          selectedItems.last);
                                    }
                                  },
                                  dataList: homeWorkController.classList,
                                  textEditingController:
                                      homeWorkController.classController,
                                  hint: 'Choose class'.tr,
                                  isCitySelected: true),
                        )),
                    Obx(
                      () => TabBar(
                        indicatorColor: AppColor.primaryColor,
                        labelColor: AppColor.primaryColor,
                        controller: homeWorkController.tabController,
                        tabs: homeWorkController.myTabs.isEmpty
                            ? homeWorkController.noDataTabs.toList()
                            : homeWorkController.myTabs.toList(),
                        onTap: homeWorkController.handleTabSelection,
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
      body: Obx(
        () => homeWorkController.isLoadingGetHomeWork.value
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(15.h),
                  child: ShimmerWidget(height: 75.h),
                ),
              )
            : TabBarView(
              physics: const NeverScrollableScrollPhysics(),
                controller: homeWorkController.tabController,
                children: 
               homeWorkController.myTabs.isEmpty
                    ? [
                        Center(
                            child: CustomText(
                                text: 'No homework data'.tr,
                                color: AppColor.primaryColor,
                                fontSize: 20.sp))
                      ]
                    : 
                    homeWorkController.myTabs.map((tab) {
                        return homeWorkController.homeWorkList.isEmpty
                            ? Center(
                                child: CustomText(
                                    text: 'No homework today'.tr,
                                    color: AppColor.primaryColor,
                                    fontSize: 20.sp))
                            : ListView.builder(
                                itemCount:
                                    homeWorkController.homeWorkList.length,
                                itemBuilder: (context, index) {
                                  var subject =
                                      homeWorkController.homeWorkList[index];
                                  return Padding(
                                    padding: EdgeInsets.all(15.h),
                                    child: SubjectCard(
                                      homeWorkData: homeWorkController
                                          .homeWorkList[index],
                                      name: subject.title!,
                                      date: '${subject.createdAt}',
                                      id: homeWorkController
                                          .homeWorkList[index].id!,
                                    ),
                                  );
                                },
                              );
                      }).toList(),
              ),
      ),
    );
  }
}
