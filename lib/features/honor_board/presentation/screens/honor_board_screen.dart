import 'package:drop_down_list/model/selected_list_item.dart';
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
import 'package:lms/features/honor_board/controller/honor_board_controller.dart';
import 'package:lms/features/honor_board/presentation/widgets/honor_board_card.dart';

class HonorBoardScreen extends StatelessWidget {
  const HonorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    honorBoardController.getGrades();
    return Scaffold(
      floatingActionButton: box.read('userType') == 'teacher'
          ? FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              child: Icon(
                Icons.add,
                color: AppColor.whiteColor,
              ),
              onPressed: () {
                Get.toNamed(AppRouter.addHonorBoardScreen, arguments: {
                  'isUpdate': false,
                });
              },
            )
          : null,
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: 'Honor board'.tr,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.4.w, vertical: 10.h),
              child: Obx(() {
                if (honorBoardController.isGradesLoading.value) {
                  return const ShimmerWidget(height: 50);
                }
                return DropDownList(
                  onSelectedItems: (List<SelectedListItem> selectedItems) {
                    int selectedGradeId =
                        int.tryParse(selectedItems.first.value.toString()) ??
                            -1;
                    honorBoardController.getHonotBoardByGrade(
                        gradeId: selectedGradeId);
                  },
                  dataList: honorBoardController.gradesDropList,
                  textEditingController: TextEditingController(),
                  hint: 'Choose class'.tr,
                  isCitySelected: true,
                );
              }),
            ),
          )),
      body: Obx(() {
        return honorBoardController.isGetHonorsLoading.value
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.h),
                    child: ShimmerWidget(height: 75.h),
                  );
                })
            : honorBoardController.honors.isEmpty
                ? Center(
                    child: CustomText(
                    text: 'No data availabe'.tr,
                    fontSize: 20.sp,
                    color: AppColor.primaryColor,
                  ))
                : ListView.builder(
                    itemCount: honorBoardController.honors.length,
                    itemBuilder: (context, index) {
                      final honor = honorBoardController.honors[index];
                      return Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TeacherHonorBoardCard(honor: honor),
                          ],
                        ),
                      );
                    },
                  );
      }),
    );
  }
}
