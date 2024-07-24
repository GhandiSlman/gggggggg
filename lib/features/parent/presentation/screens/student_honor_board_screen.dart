import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/features/parent/presentation/widgets/student_honor_board_card.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';

class StudentHonorBoardScreen extends StatelessWidget {
  const StudentHonorBoardScreen({super.key, required this.students});
  final List<Student> students;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.toNamed(AppRouter.addHonorBoardScreen, arguments: {
      //       'isUpdate': true,
      //     });
      //   },
      //   backgroundColor: AppColor.primaryColor,
      //   child: Icon(
      //     Icons.edit,
      //     color: AppColor.whiteColor,
      //   ),
      // ),

      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Students'.tr),
      body: Padding(
        padding: EdgeInsets.all(8.h),
        child: GridView.builder(
            itemCount: students.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: (1 / 1.2),
            ),
            itemBuilder: (_, index) {
              return StudentHonorBoardCard(
                index: index,
                students: students,
              );
            }),
      ),
    );
  }
}
