import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/loading_widget.dart';
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
                DropDownList(
                  onSelectedItems: (List<String> selectedItems) {
                    continuousRatingController.honorBoardController
                        .updateSelectedSubject(selectedItems.last);
                    String? subjectId = continuousRatingController
                        .honorBoardController
                        .subjectToIdMap[selectedItems.last];
                    if (subjectId != null) {
                      continuousRatingController.honorBoardController
                          .updateSelectedSubjectId(subjectId);
                    }
                  },
                  dataList: continuousRatingController.showStudentList,
                  textEditingController: continuousRatingController
                      .honorBoardController.classController,
                  hint: 'Choose student'.tr,
                  isCitySelected: true,
                ),
                10.verticalSpace,
                CustomText(
                  text: 'Subject name'.tr,
                  color: AppColor.greyColor2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                DropDownList(
                  onSelectedItems: (List<String> selectedItems) {
                    continuousRatingController.honorBoardController
                        .updateSelectedStudentRate(selectedItems.last);
                    String? subjectId = continuousRatingController
                        .honorBoardController
                        .subjectToIdMap[selectedItems.last];
                    if (subjectId != null) {
                      continuousRatingController.honorBoardController
                          .updateSelectedStudentRateId(subjectId);
                    }
                  },
                  dataList: continuousRatingController.showSubjectList,
                  textEditingController: continuousRatingController
                      .honorBoardController.subjectController,
                  hint: 'Choose subject'.tr,
                  isCitySelected: true,
                ),
                100.verticalSpace,
                Obx(() => continuousRatingController.isLoadnigAddRateStudent.value
                    ? const LoadingWidget()
                    : CustomButton(
                        color: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        width: double.infinity,
                        text: 'Add Rate'.tr,
                        onTap: () {
                          continuousRatingController.addRateStudent(id);
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
