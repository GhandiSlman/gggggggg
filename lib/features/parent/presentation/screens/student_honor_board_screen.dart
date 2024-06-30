import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/parent/presentation/widgets/student_honor_board_card.dart';
import 'package:lms/features/honor_board/controller/honor_board_controller.dart';

class StudentHonorBoardScreen extends StatelessWidget {
  const StudentHonorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRouter.addHonorBoardScreen, arguments: {
            'isUpdate': honorBoardController.isUpdateHonorBoard == false,
           
          });
        },
        backgroundColor: AppColor.primaryColor,
        child: Icon(
          Icons.edit,
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Students'.tr),
      body: Padding(
          padding: EdgeInsets.all(8.h),
          child: Obx(
            () => honorBoardController.isLoadingStudentH.value
                ? GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: (1 / 1.2),
                    ),
                    itemBuilder: (_, index) {
                      return ShimmerWidget(
                        height: 125.h,
                        width: double.infinity,
                      );
                    })
                : GridView.builder(
                    itemCount:
                        honorBoardController.honorBoardStudentList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: (1 / 1.2),
                    ),
                    itemBuilder: (_, index) {
                      final honorBoardStudentList =
                          honorBoardController.honorBoardStudentList[index];
                      return StudentHonorBoardCard(
                        index: index + 1,
                        honorBoardStudent: honorBoardStudentList,
                      );
                    }),
          )),
    );
  }
}
