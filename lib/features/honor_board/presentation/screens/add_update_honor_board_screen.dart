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
                  () => honorBoardController.isLoading.value
                      ? ShimmerWidget(height: 50.h)
                      : DropDownList(
                          onSelectedItems: (List<SelectedListItem> selectedItems) {
                            honorBoardController
                                .updateSelectedClass(selectedItems.last.name);
                          },
                          dataList: honorBoardController.showClassList,
                          textEditingController:
                              honorBoardController.classControllerAdd,
                          hint: 'Choose class'.tr,
                          isCitySelected: true),
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
                  () => honorBoardController.isLoading.value
                      ? ShimmerWidget(height: 50.h)
                      : DropDownList(
                          onSelectedItems: (List<SelectedListItem> selectedItems) {
                            honorBoardController
                                .updateSelectedSubject(selectedItems.last.name);
                            String? subjectId = honorBoardController
                                .subjectToIdMap[selectedItems.last.name];
                            if (subjectId != null) {
                              honorBoardController
                                  .updateSelectedSubjectId(subjectId);
                            }
                          },
                          dataList: honorBoardController.showSubjectList,
                          textEditingController:
                              honorBoardController.subjectController,
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
                  controller: honorBoardController.titleController,
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
                  () => Column(
                    children: honorBoardController.studentDropDownControllers
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      TextEditingController controller = entry.value;
                      return DropDownList(
                        onSelectedItems: (List<SelectedListItem> selectedItems) {
                          honorBoardController.updateSelectedStudent(
                              selectedItems.last.name, index);
                        },
                        dataList: honorBoardController.showStudentList
                            .where((item) => !honorBoardController
                                .selectedStudents
                                .contains(item.name))
                            .toList(),
                        textEditingController: controller,
                        hint: 'Choose student'.tr,
                        isCitySelected: true,
                      );
                    }).toList(),
                  ),
                ),
                10.verticalSpace,
                TextButton(
                    onPressed: () {
                      honorBoardController.addStudentDropDown();
                    },
                    child: CustomText(
                      text: 'Add student'.tr,
                      fontSize: 15.sp,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.normal,
                    )),
                25.verticalSpace,
                Obx(
                  () => honorBoardController.isAdding.value
                      ? const LoadingWidget()
                      : CustomButton(
                          text: isUpdate ? 'Update'.tr : 'Add'.tr,
                          onTap: () {
                            // honorBoardController
                            //     .addHonorBoard()
                            //     .then((value) => Get.back());
                          },
                          color: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                        ),
                ),
                5.verticalSpace,
                isUpdate
                    ? CustomButton(
                        text: 'Delete'.tr,
                        onTap: () {
                          honorBoardController.deleteHonorBoard(8);
                        },
                        color: AppColor.redColor,
                        textColor: AppColor.whiteColor,
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
