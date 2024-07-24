import 'dart:ffi';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/honor_board/controller/honor_board_controller.dart';

class AddHonorBoardScreen extends StatelessWidget {
  const AddHonorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    final arguments = Get.arguments;
    final isUpdate = arguments['isUpdate'];
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: isUpdate ? 'Update honor board'.tr : 'Add honor board'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Class'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                10.verticalSpace,
                Obx(
                  () => honorBoardController.isGradesLoading.value
                      ? ShimmerWidget(height: 50.h)
                      : DropDownList(
                          onSelectedItems:
                              (List<SelectedListItem> selectedItems) {
                            honorBoardController.selectedGradesId.value =
                                selectedItems.first.value.toString();
                          },
                          dataList: honorBoardController.gradesDropList,
                          textEditingController: TextEditingController(),
                          hint: 'Choose class'.tr,
                          isCitySelected: true,
                        ),
                ),
                10.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Subject'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                10.verticalSpace,
                Obx(
                  () => honorBoardController.selectedGradesId.value.isEmpty
                      ? const Center(child: CustomText(text: 'Select a grade'))
                      : DropDownList(
                          onSelectedItems:
                              (List<SelectedListItem> selectedItems) {
                            honorBoardController.selectedSubjectId.value =
                                selectedItems.first.value.toString();
                          },
                          dataList: honorBoardController.subjectDropList,
                          textEditingController: TextEditingController(),
                          hint: 'Choose subject'.tr,
                          isCitySelected: true,
                        ),
                ),
                10.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Honor board name'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                10.verticalSpace,
                CustomTextField(
                  controller:
                      honorBoardController.honorNameTextEditingController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter honor board name'.tr,
                ),
                10.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Students'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                10.verticalSpace,
                Obx(
                  () => honorBoardController.selectedSubjectId.value.isEmpty
                      ? const Center(child: CustomText(text: 'Select a grade'))
                      : Column(
                          children: honorBoardController.studentDropList
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropDownList(
                              onSelectedItems:
                                  (List<SelectedListItem> selectedItems) {
                                honorBoardController.selectedStudentsIds.add(
                                    int.parse(
                                        selectedItems.first.value.toString()));
                                honorBoardController.studentDropList
                                    .removeWhere((e) =>
                                        e.value == selectedItems.first.value);
                              },
                              dataList: honorBoardController.studentDropList,
                              textEditingController: TextEditingController(),
                              hint: 'Choose student'.tr,
                              isCitySelected: true,
                            );
                          }).toList(),
                        ),
                ),
                10.verticalSpace,
                // TextButton(
                //     onPressed: () {
                //       honorBoardController.addStudentDropDown();
                //     },
                //     child: CustomText(
                //       text: 'Add student'.tr,
                //       fontSize: 15.sp,
                //       color: AppColor.primaryColor,
                //       fontWeight: FontWeight.normal,
                //     )),
                // 25.verticalSpace,
                // Obx(
                //   () => honorBoardController.isAdding.value
                //       ? const LoadingWidget()
                //       : CustomButton(
                //           text: isUpdate ? 'Update'.tr : 'Add'.tr,
                //           onTap: () {
                //             // honorBoardController
                //             //     .addHonorBoard()
                //             //     .then((value) => Get.back());
                //           },
                //           color: AppColor.primaryColor,
                //           textColor: AppColor.whiteColor,
                //         ),
                // ),
                // 5.verticalSpace,
                // isUpdate
                //     ? CustomButton(
                //         text: 'Delete'.tr,
                //         onTap: () {
                //           honorBoardController.deleteHonorBoard(8);
                //         },
                //         color: AppColor.redColor,
                //         textColor: AppColor.whiteColor,
                //       )
                //     : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
