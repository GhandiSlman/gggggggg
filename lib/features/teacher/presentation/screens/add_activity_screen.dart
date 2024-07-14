// ignore_for_file: must_be_immutable
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
import 'package:lms/features/teacher/controller/activity_controller.dart';

class AddActivityScreen extends StatelessWidget {
  AddActivityScreen({super.key});
  ActivityController activityController = Get.find();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final activityId = arguments['activityId'];
    final isUpdated = arguments['isUpdate'];
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: isUpdated == false ? 'Add Activity'.tr : 'Update Activity'.tr),
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                10.verticalSpace,
                DropDownList(
                  onSelectedItems: (List<SelectedListItem> selectedItems) {
                    if (selectedItems.isNotEmpty) {
                      String selectedSection = selectedItems.last.name;
                      activityController.updateSelectedSection(selectedSection);

                      String? sectionId = activityController
                          .sectionNameToIdMap[selectedSection];
                      if (sectionId != null) {
                        activityController.updateSelectedSectionId(sectionId);
                      }
                    }
                  },
                  dataList: activityController.showSectionList,
                  textEditingController: activityController.sectionController,
                  hint: 'Choose section'.tr,
                  isCitySelected: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Activity name'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter activity name'.tr,
                  controller: activityController.titleController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Activity details'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter Activity details'.tr,
                  maxLine: 6,
                  controller: activityController.descriptionController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Activity date'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  onTap: () {
                    pickDate(context, activityController.dateController,
                        PickerType.date);
                  },
                  controller: activityController.dateController,
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
                  () => activityController.isAdded.value
                      ? const LoadingWidget()
                      : CustomButton(
                          text: isUpdated == false ? 'Add'.tr : 'Update'.tr,
                          onTap: () async {
                            isUpdated == false
                                ? activityController
                                    .addActivity()
                                    .then((value) {
                                    activityController.getSections();
                                    activityController.getActivity(
                                        activityController
                                            .selectedSectionId.value);
                                    Get.back();
                                  })
                                : activityController
                                    .updateActivity(activityId)
                                    .then((value) {
                                    activityController.getSections();
                                    activityController.getActivity(
                                        activityController
                                            .selectedSectionId.value);
                                    Get.back();
                                    Get.back();
                                  });
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
