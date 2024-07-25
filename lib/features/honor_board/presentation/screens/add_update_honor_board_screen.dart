import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/honor_board/controller/honor_board_controller.dart';
import 'package:lms/features/honor_board/model/honor_model.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';

class AddHonorBoardScreen extends StatelessWidget {
  const AddHonorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    final arguments = Get.arguments;
    final bool isUpdate = arguments['isUpdate'];
    final Honor? honor = isUpdate ? arguments['honor'] : null;
    if (isUpdate) {
      honorBoardController.honorNameTextEditingController.text = honor!.title;
      honorBoardController.getStudentsBySubject(subjectId: honor.subjectId);
      honorBoardController.selectedSubjectId.value = honor.subjectId.toString();
      honorBoardController.studentsTextFeilds.value = honor.students!;
    } else {
      honorBoardController.isGradesLoading = false.obs;
      honorBoardController.selectedGradesId = ''.obs;
      honorBoardController.selectedSubjectId = ''.obs;
      honorBoardController.honorNameTextEditingController.clear();
      honorBoardController.studentsTotalLength = 0.obs;
      honorBoardController.studentsTextFeilds = <Student>[Student()].obs;
    }
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
                if (!isUpdate) ...[
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
                        ? const Center(
                            child: CustomText(text: 'Select a grade'))
                        : DropDownList(
                            onSelectedItems:
                                (List<SelectedListItem> selectedItems) {
                              int selectedSubjectId = int.parse(
                                  selectedItems.first.value.toString());
                              honorBoardController.getStudentsBySubject(
                                  subjectId: selectedSubjectId);
                              honorBoardController.selectedSubjectId.value =
                                  selectedItems.first.value.toString();
                            },
                            dataList: honorBoardController.allSubjects
                                .where((e) =>
                                    e.gradeId.toString() ==
                                    honorBoardController.selectedGradesId.value)
                                .toList()
                                .map((e) => SelectedListItem(
                                    name: box.read('langCode') == 'ar'
                                        ? e.name?.ar ?? ''
                                        : e.name?.en ?? '',
                                    value: e.id.toString()))
                                .toSet()
                                .toList(),
                            textEditingController: TextEditingController(),
                            hint: 'Choose subject'.tr,
                            isCitySelected: true,
                          ),
                  ),
                ],
                10.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Students'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                10.verticalSpace,
                Obx(
                  () {
                    if (isUpdate &&
                        honorBoardController.studentDropList.isNotEmpty) {
                      honorBoardController.studentDropList.removeWhere((e) =>
                          honor!.students!
                              .map((e) => e.id.toString())
                              .toList()
                              .contains(e.value));
                    }
                    return honorBoardController.selectedSubjectId.value.isEmpty
                        ? const Center(
                            child: CustomText(text: 'Select a Subject'))
                        : Column(
                            children: honorBoardController
                                    .isGetStudentsBySubjectLoading.value
                                ? [const ShimmerWidget(height: 50)]
                                : List.generate(
                                    honorBoardController
                                        .studentsTextFeilds.length, (index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: DropDownList(
                                            onSelectedItems:
                                                (List<SelectedListItem>
                                                    selectedItems) {
                                              honorBoardController
                                                      .studentsTextFeilds[index]
                                                      .id =
                                                  (int.parse(selectedItems
                                                      .first.value
                                                      .toString()));
                                              honorBoardController
                                                      .studentsTextFeilds[index]
                                                      .name =
                                                  selectedItems.first.name;
                                              honorBoardController
                                                  .studentDropList
                                                  .removeWhere((e) =>
                                                      e.value ==
                                                      selectedItems
                                                          .first.value);
                                            },
                                            dataList: honorBoardController
                                                .studentDropList,
                                            textEditingController:
                                                TextEditingController(
                                                    text: honorBoardController
                                                        .studentsTextFeilds[
                                                            index]
                                                        .name),
                                            hint: 'Choose student'.tr,
                                            isCitySelected: true,
                                          ),
                                        ),
                                        8.horizontalSpace,
                                        IconButton(
                                            onPressed: () {
                                              if (honorBoardController
                                                      .studentsTextFeilds[index]
                                                      .id !=
                                                  null) {
                                                honorBoardController
                                                    .studentDropList
                                                    .add(SelectedListItem(
                                                        name: honorBoardController
                                                                .studentsTextFeilds[
                                                                    index]
                                                                .name ??
                                                            '',
                                                        value: honorBoardController
                                                            .studentsTextFeilds[
                                                                index]
                                                            .id
                                                            .toString()));
                                              }
                                              honorBoardController
                                                  .studentsTextFeilds
                                                  .removeAt(index);
                                            },
                                            icon: const Icon(Icons.close)),
                                      ],
                                    );
                                  }).toList(),
                          );
                  },
                ),
                10.verticalSpace,
                Obx(() {
                  if (honorBoardController.studentsTotalLength >
                      honorBoardController.studentsTextFeilds.length) {
                    return TextButton(
                        onPressed: () {
                          honorBoardController.studentsTextFeilds
                              .add(Student());
                        },
                        child: CustomText(
                          text: 'Add student'.tr,
                          fontSize: 15.sp,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.normal,
                        ));
                  }
                  return const SizedBox();
                }),
                25.verticalSpace,
                Obx(
                  () => honorBoardController.isAddHonorLoading.value
                      ? const LoadingWidget()
                      : CustomButton(
                          text: isUpdate ? 'Update'.tr : 'Add'.tr,
                          onTap: () {
                            if (honorBoardController
                                .honorNameTextEditingController.text.isEmpty) {
                              CustomToast.customErrorToast('Enter the name');
                            } else if (honorBoardController
                                .selectedSubjectId.value.isEmpty) {
                              CustomToast.customErrorToast('Select a Subject');
                            } else if (honorBoardController
                                .studentsTextFeilds.isEmpty) {
                              CustomToast.customErrorToast('Select a Students');
                            } else {
                              if (honorBoardController.studentsTextFeilds
                                  .map((e) => e.id.toString())
                                  .toList()
                                  .contains('null')) {
                                CustomToast.customErrorToast(
                                    'Select a Students');
                              } else {
                                if (isUpdate) {
                                  honorBoardController
                                      .updateHonorBoard(honor!.id!)
                                      .then((value) => Get.back());
                                } else {
                                  honorBoardController
                                      .addHonorBoard()
                                      .then((value) => Get.back());
                                }
                              }
                            }
                          },
                          color: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                        ),
                ),
                5.verticalSpace,
                if (isUpdate)
                  Obx(() {
                    if (honorBoardController.isDeleteHonorLoading.value) {
                      return const ShimmerWidget(height: 50);
                    }
                    return CustomButton(
                      text: 'Delete'.tr,
                      onTap: () => honorBoardController
                          .deleteHonorBoard(honor!.id!)
                          .then((value) {
                        Get.back();
                        Get.back();
                      }),
                      color: AppColor.redColor,
                      textColor: AppColor.whiteColor,
                    );
                  })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
