import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/supervisor/controller/student_status_controller.dart';
import 'package:lms/features/supervisor/presentation/widgets/student_status_card.dart';

class SuperVisorPresenceScreen extends StatelessWidget {
  const SuperVisorPresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentStatusController studentStatusController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'SuperVisor Presence',
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Obx(
                      () => studentStatusController.isLoadingSections.value
                          ? ShimmerWidget(
                              height: 50.h,
                            )
                          : DropDownList(
                              onSelectedItems: (List<SelectedListItem> selectedItems) {
                                if (selectedItems.isNotEmpty) {
                                  studentStatusController
                                      .updateSelectedClass(selectedItems.last.name);
                                }
                              },
                              dataList: studentStatusController.classList,
                              textEditingController:
                                  studentStatusController.classController,
                              hint: 'Choose class'.tr,
                              isCitySelected: true,
                            ),
                    )),
                SizedBox(
                  height: 10.h,
                ),
              ],
            )),
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 25.h,
            child: Center(
              child: Obx(
                () => CustomText(
                  text: studentStatusController.studentStatusList.isNotEmpty
                      ? studentStatusController.studentStatusList[0].date ?? ''
                      : 'No date available',
                  color: AppColor.greyColor2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Obx(() {
                if (studentStatusController.isLoadingStudentStatus.value) {
                  return Center(
                      child: GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: (1 / 1.3),
                    ),
                    itemBuilder: (_, index) {
                      return ShimmerWidget(height: 50.h);
                    },
                  ));
                } else if (studentStatusController.studentStatusList.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: 'No data available',
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                    ),
                  );
                } else {
                  return GridView.builder(
                    itemCount: studentStatusController.studentStatusList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: (1 / 1.3),
                    ),
                    itemBuilder: (_, index) {
                      var studentStatus =
                          studentStatusController.studentStatusList[index];
                      return StudentStatusCard(
                        name: studentStatus.status ?? '',
                        status: studentStatus.status ?? '',
                      );
                    },
                  );
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
