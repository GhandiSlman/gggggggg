import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/honor_board_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/honor_board_card.dart';
import 'package:lms/features/supervisor/controller/student_status_controller.dart';

class HonorBoardScreen extends StatelessWidget {
  const HonorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    StudentStatusController studentStatusController = Get.find();
    String userType = box.read('userType') ?? '';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        child: Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
        onPressed: () {
          Get.toNamed(AppRouter.addHonorBoardScreen, arguments: {
            'isUpdate': honorBoardController.isUpdateHonorBoard == true
          });
        },
      ),
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'Honor board'.tr,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.4.w, vertical: 10.h),
            child: DropDownList(
              onSelectedItems: (List<String> selectedItems) {
                box.read('userType') == 'teacher'
                    ? honorBoardController
                        .updateSelectedClass(selectedItems.first)
                    : studentStatusController
                        .updateSelectedClass(selectedItems.first);
              },
              dataList: box.read('userType') == 'teacher'
                  ? honorBoardController.showClassList
                  : studentStatusController.classList,
              textEditingController: honorBoardController.classController,
              hint: 'Choose class'.tr,
              isCitySelected: true,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (honorBoardController.selectedClass.isEmpty) {
          return Center(
            child: Text(
              'Choose a class'.tr,
              style: TextStyle(fontSize: 18.sp, color: AppColor.primaryColor),
            ),
          );
        } else if (honorBoardController.isGetHonor.value) {
          return ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(10.h),
              child: ShimmerWidget(height: 50.h),
            ),
          );
        } else {
          return Obx(() {
            List<String> subjects = studentStatusController.getSubjectList();
            return ListView.builder(
              itemCount: honorBoardController.filteredHonorBoardList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CustomText(
                      //   text: subjects.isNotEmpty
                      //       ? subjects[index % subjects.length]
                      //       : 'No subjects',
                      //   color: AppColor.primaryColor,
                      //   fontSize: 18.sp,
                      // ),
                      TeacherHonorBoardCard(
                        getHonorBoard:
                            honorBoardController.filteredHonorBoardList[index],
                        subjectName: box.read('langCode') == 'ar'
                            ? honorBoardController.filteredHonorBoardList[index]
                                .data![index].subjects![index].name!.ar!
                            : honorBoardController.filteredHonorBoardList[index]
                                .data![index].subjects![index].name!.en!,
                        subjectId: honorBoardController
                            .filteredHonorBoardList[index]
                            .data![index]
                            .subjects![index]
                            .id!,
                      ),
                    ],
                  ),
                );
              },
            );
          });
        }
      }),
    );
  }
}
