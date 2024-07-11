import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/date_time_picker.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/teacher/controller/homework_controller.dart';

class AddHomeWorkScreen extends StatelessWidget {
  const AddHomeWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final homeWorkId = arguments['homeWorkId'];
    final isUpdated = arguments['isUpdate'];
    HomeWorkController homeWorkController = Get.find();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: isUpdated == false ? 'Add HomeWork'.tr : 'Update HomeWork'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
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
                SizedBox(height: 10.h),
                DropDownList(
                  onSelectedItems: (List<SelectedListItem> selectedItems) {
                    if (selectedItems.isNotEmpty) {
                      String selectedClass = selectedItems.last.name;
                      homeWorkController
                          .updateSelectedClass(selectedItems.last);

                      int? sectionId =
                          homeWorkController.sectionToIdMap[selectedClass];
                      int? subjectId =
                          homeWorkController.subjectToIdMap[selectedClass];
                      if (sectionId != null && subjectId != null) {
                        homeWorkController.updateSelectedSectionId(sectionId,
                            subjectId); // Implement this method to handle the ID
                      }
                    }
                  },
                  dataList:
                      homeWorkController.selectedSectionSubjectList.toList(),
                  textEditingController: homeWorkController.sectionController,
                  hint: 'Choose class'.tr,
                  isCitySelected: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'HomeWork title'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: homeWorkController.titleHomeWorkController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter homeWork title'.tr,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'HomeWork details'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: homeWorkController.detailsHomeWorkController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter homeWork details'.tr,
                  maxLine: 6,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Submission date'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  onTap: () {
                    pickDate(context, homeWorkController.dateController,
                        PickerType.dateTime);
                  },
                  controller: homeWorkController.dateController,
                  filled: true,
                  readOnly: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter submission date'.tr,
                  suffix: Container(
                    margin: EdgeInsets.all(10.h),
                    child: SvgPicture.asset(AppImages.dateImage),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Obx(
                  () => homeWorkController.isLoadingAddUpdateHomeWork.value
                      ? const LoadingWidget()
                      : CustomButton(
                          text: isUpdated == false ? 'Add'.tr : 'Update'.tr,
                          onTap: () {
                            isUpdated == false
                                ? homeWorkController
                                    .addHomeWork()
                                    .then((value) {
                                    Get.back();
                                  })
                                : homeWorkController.updateHomeWork(homeWorkId);
                          },
                          color: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
