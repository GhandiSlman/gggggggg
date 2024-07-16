import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/continuous_rating_controller.dart';

class AddAsignRateScreen extends StatelessWidget {
  const AddAsignRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final id = arguments['id'];
    ContinuousRatingController continuousRatingController = Get.find();

    return Scaffold(
      appBar: CustomAppBar(title: 'Assign rate to student'.tr),
      backgroundColor: AppColor.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Student name'.tr,
                  color: AppColor.greyColor2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                Obx(() => continuousRatingController
                        .isLoadingStudentSubject.value
                    ? ShimmerWidget(height: 50.h)
                    : DropDownList(
                        onSelectedItems:
                            (List<SelectedListItem> selectedItems) {
                          continuousRatingController
                              .updateSelectedStudent(selectedItems.last.name);
                          String? studentId = continuousRatingController
                              .studentToIdMap[selectedItems.last.name];
                          if (studentId != null) {
                            continuousRatingController.selectedStudentId.value =
                                studentId;
                          }
                        },
                        dataList: continuousRatingController.showStudentList,
                        textEditingController:
                            TextEditingController(), // Using a new controller instance to avoid conflicts
                        hint: 'Choose student'.tr,
                        isCitySelected: true,
                      )),
                10.verticalSpace,
                CustomText(
                  text: 'Subject name'.tr,
                  color: AppColor.greyColor2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                Obx(() => continuousRatingController
                        .isLoadingStudentSubject.value
                    ? ShimmerWidget(height: 50.h)
                    : DropDownList(
                        onSelectedItems:
                            (List<SelectedListItem> selectedItems) {
                          continuousRatingController
                              .updateSelectedSubject(selectedItems.last.name);
                          String? subjectId = continuousRatingController
                              .subjectToIdMap[selectedItems.last.name];
                          if (subjectId != null) {
                            continuousRatingController.selectedSubjectId.value =
                                subjectId;
                          }
                        },
                        dataList: continuousRatingController.showSubjectList,
                        textEditingController:
                            TextEditingController(), // Using a new controller instance to avoid conflicts
                        hint: 'Choose subject'.tr,
                        isCitySelected: true,
                      )),
                100.verticalSpace,
                Obx(
                  () => continuousRatingController.isLoadnigAddRateStudent.value
                      ? const LoadingWidget()
                      : CustomButton(
                          color: AppColor.primaryColor,
                          textColor: AppColor.whiteColor,
                          width: double.infinity,
                          text: 'Add Rate'.tr,
                          onTap: () {
                            continuousRatingController
                                .addRateStudent(id)
                                .then((value) {
                              continuousRatingController
                                  .getContinuousRatingStudent(id);
                              Get.back();
                            });
                          },
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
