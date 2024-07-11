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
import 'package:lms/features/teacher/controller/week_plane_controller.dart';

class AddToWeekPlaneScreen extends StatelessWidget {
  const AddToWeekPlaneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final weekPlaneId = arguments['weekPlaneId'];
    final isUpdated = arguments['isUpdate'];
    WeekPlaneController weekPlaneController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: isUpdated == false ? ' Add lesson'.tr : 'Update lesson'.tr),
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
                5.verticalSpace,
                DropDownList(
                    onSelectedItems: (List<SelectedListItem> selectedItems) {
                      String selectedSection = selectedItems.last.name;
                      weekPlaneController
                          .updateSelectedSection(selectedSection);
                    },
                    dataList: weekPlaneController.showSectionList,
                    textEditingController:
                        weekPlaneController.sectionController,
                    hint: 'Choose division'.tr,
                    isCitySelected: true),
                5.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Subject'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,

                DropDownList(
                    onSelectedItems: (List<SelectedListItem> selectedItems) {
                      String selectedSubject = selectedItems.last.name;
                      weekPlaneController
                          .updateSelectedSubject(selectedSubject);
                    },
                    dataList: weekPlaneController.showSubjectList,
                    textEditingController:
                        weekPlaneController.subjectController,
                    hint: 'Choose subject'.tr,
                    isCitySelected: true),
                // ),
                5.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Lesson name'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                CustomTextField(
                  controller: weekPlaneController.lessonTitleController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter lesson name'.tr,
                ),
                5.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Lesson details'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                CustomTextField(
                  controller: weekPlaneController.lessonDescController,
                  filled: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter lesson details'.tr,
                  maxLine: 6,
                ),
                5.verticalSpace,
                CustomText(
                  color: AppColor.greyColor2,
                  text: 'Lesson date'.tr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                5.verticalSpace,
                CustomTextField(
                  onTap: () {
                    pickDate(context, weekPlaneController.lessonDateController,
                        PickerType.date);
                  },
                  controller: weekPlaneController.lessonDateController,
                  filled: true,
                  readOnly: true,
                  filledColor: AppColor.whiteColor,
                  hint: 'Enter submission date'.tr,
                  suffix: Container(
                    margin: EdgeInsets.all(10.h),
                    child: SvgPicture.asset(AppImages.dateImage),
                  ),
                ),
                25.verticalSpace,
                Obx(() => weekPlaneController.isLoadingAdd.value
                    ? const LoadingWidget()
                    : CustomButton(
                        text: isUpdated == false ? ' Add'.tr : 'Update'.tr,
                        onTap: () {
                          isUpdated == false
                              ? weekPlaneController
                                  .addWeekPlane()
                                  .then((value) {
                                  weekPlaneController.getSections();
                                  weekPlaneController.getWeekPlane(
                                      weekPlaneController
                                          .selectedSectionId.value,
                                      weekPlaneController
                                          .selectedSubjectId.value);
                                  Get.back();
                                })
                              : weekPlaneController
                                  .updateWeekPlane(weekPlaneId)
                                  .then((value) {
                                  weekPlaneController.getSections();
                                  weekPlaneController.getWeekPlane(
                                      weekPlaneController
                                          .selectedSectionId.value,
                                      weekPlaneController
                                          .selectedSubjectId.value);
                                  Get.back();
                                });
                        },
                        color: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                      ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
