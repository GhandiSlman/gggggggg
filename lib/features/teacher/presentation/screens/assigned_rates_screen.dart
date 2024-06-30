import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/continuous_rating_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/assigned_rating_card.dart';

class AssignedRatesScreen extends StatelessWidget {
  const AssignedRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final id = arguments['id'];
    ContinuousRatingController continuousRatingController = Get.find();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          Get.toNamed(AppRouter.addAssignRatescreen, arguments: {'id': id});
        },
        child: Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Assigned Rating'.tr),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Obx(
          () => continuousRatingController.isLoadnigGetRateStudent.value
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10.h),
                      child: ShimmerWidget(height: 75.h),
                    );
                  },
                )
              : continuousRatingController.ratingStudentList.isEmpty
                  ? Center(
                      child: CustomText(
                        text: 'No ratings assigned'.tr,
                        fontSize: 20.sp,
                        color: AppColor.primaryColor,
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          continuousRatingController.ratingStudentList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10.h),
                          child: AssignedRatingCard(
                            getContinuousRateStudent: continuousRatingController
                                .ratingStudentList[index],
                            id: id.toString(),
                            studentName: continuousRatingController
                                .ratingStudentList[index].student!.name!,
                            subjectName: continuousRatingController
                                .ratingStudentList[index].subject!.name!.ar!,
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
