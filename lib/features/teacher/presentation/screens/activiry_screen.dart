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
import 'package:lms/features/teacher/controller/activity_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/activity_card.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ActivityController activityController = Get.find();
    return Scaffold(
      floatingActionButton: box.read('userType') == 'teacher'
          ? FloatingActionButton(
              onPressed: () {
                Get.toNamed(AppRouter.addActivity, arguments: {
                  'isUpdate': activityController.isUpdated == true
                });
              },
              backgroundColor: AppColor.primaryColor,
              child: Icon(
                Icons.add,
                color: AppColor.whiteColor,
              ),
            )
          : null,
      appBar: CustomAppBar(title: 'Activity'.tr),
      backgroundColor: AppColor.scaffoldColor,
      body: Column(
        children: [
          box.read('userType') == 'teacher'
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  child: Obx(
                    () => activityController.isLoadingSection.value
                        ? ShimmerWidget(height: 50.h)
                        : DropDownList(
                            onSelectedItems: (List<String> selectedItems) {
                              activityController
                                  .updateSelectedSection(selectedItems.last);
                            },
                            dataList: activityController.showSectionList,
                            textEditingController:
                                activityController.sectionController,
                            hint: 'Choose section'.tr,
                            isCitySelected: true),
                  ))
              : const SizedBox(),
          Expanded(
            child: Obx(
              () => box.read('userType') == 'teacher' &&
                      activityController.selectedSectionId.value.isEmpty
                  ? Center(
                      child: CustomText(
                        text: 'Please select a section'.tr,
                        color: AppColor.primaryColor,
                        fontSize: 20.sp,
                      ),
                    )
                  : activityController.isGetActivity.value
                      ? ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10.h),
                              child: ShimmerWidget(height: 175.h),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount:
                             box.read('userType') == 'teacher'?   activityController.activityList.length : activityController.activityListIndex.length,
                          itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: box.read('userType') == 'supervisor'
                                  ? ActivityCard(
                                      sectionName: box.read('langCode') == 'ar'
                                          ? activityController
                                              .activityListIndex[index]
                                              .section!
                                              .name!
                                              .ar!
                                          : activityController
                                              .activityListIndex[index]
                                              .section!
                                              .name!
                                              .en!,
                                      date: activityController
                                          .activityListIndex[index].date!,
                                      desc: activityController
                                          .activityListIndex[index]
                                          .description!,
                                      title: activityController
                                          .activityListIndex[index].title!,
                                      activityIndex: activityController
                                          .activityListIndex[index],
                                    )
                                  : ActivityCard(
                                      sectionName: '',
                                      date: activityController
                                          .activityList[index].date!,
                                      desc: activityController
                                          .activityList[index].description!,
                                      title: activityController
                                          .activityList[index].title!,
                                      activity: activityController
                                          .activityList[index],
                                    )),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
