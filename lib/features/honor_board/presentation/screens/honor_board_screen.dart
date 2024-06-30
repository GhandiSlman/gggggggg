import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/honor_board/controller/honor_board_controller.dart';
import 'package:lms/features/honor_board/presentation/widgets/honor_board_card.dart';

class HonorBoardScreen extends StatelessWidget {
  const HonorBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HonorBoardController honorBoardController = Get.find();
    //  StudentStatusController studentStatusController = Get.find();
    // String userType = box.read('userType') ?? '';

    return Scaffold(
      floatingActionButton: box.read('userType') == 'teacher'
          ? FloatingActionButton(
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
            )
          : null,
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
          title: 'Honor board'.tr,
          bottom: box.read('userType') == 'teacher'
              ? PreferredSize(
                  preferredSize: Size.fromHeight(100.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.4.w, vertical: 10.h),
                    child: DropDownList(
                      onSelectedItems: (List<String> selectedItems) {
                        // box.read('userType') == 'teacher'
                        //?
                        honorBoardController
                            .updateSelectedClass(selectedItems.first);
                        // : studentStatusController
                        //     .updateSelectedClass(selectedItems.first);
                      },
                      dataList:
                          // box.read('userType') == 'teacher'
                          //     ?
                          honorBoardController.showClassList,
                      //  : studentStatusController.classList,
                      textEditingController:
                          honorBoardController.classController,
                      hint: 'Choose class'.tr,
                      isCitySelected: true,
                    ),
                  ),
                )
              : null),
      body: Obx(() {
        // if (honorBoardController.selectedClass.isEmpty) {
        //   return Center(
        //     child: Text(
        //       'Choose a class'.tr,
        //       style: TextStyle(fontSize: 18.sp, color: AppColor.primaryColor),
        //     ),
        //   );
        // } else if (honorBoardController.isGetHonor.value) {
        //   return ListView.builder(
        //     itemCount: 3,
        //     itemBuilder: (context, index) => Padding(
        //       padding: EdgeInsets.all(10.h),
        //       child: ShimmerWidget(height: 50.h),
        //     ),
        //   );
        // }
        //else {
        // return
        // Obx(() {
        //  List<String> subjects = studentStatusController.getSubjectList();
        return honorBoardController.isGetHonor.value
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.h),
                    child: ShimmerWidget(height: 75.h),
                  );
                })
            : ListView.builder(
                itemCount: box.read('userType') == 'student'
                    ? honorBoardController.honorBoardList.length
                    : honorBoardController.filteredHonorBoardList.length,
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
                            getHonorBoard: box.read('userType') == 'student'
                                ? honorBoardController.honorBoardList[index]
                                : honorBoardController
                                    .filteredHonorBoardList[index],
                            subjectName: box.read('langCode') == 'ar'
                                ? box.read('userType') == 'student'
                                    ? honorBoardController.honorBoardList[index]
                                        .data![index].subjects![index].name!.ar!
                                    : honorBoardController
                                        .filteredHonorBoardList[index]
                                        .data![index]
                                        .subjects![index]
                                        .name!
                                        .ar!
                                : box.read('userType') == 'student'
                                    ? honorBoardController.honorBoardList[index]
                                        .data![index].subjects![index].name!.en!
                                    : honorBoardController
                                        .filteredHonorBoardList[index]
                                        .data![index]
                                        .subjects![index]
                                        .name!
                                        .en!,
                            subjectId: box.read('userType') == 'student'
                                ? honorBoardController.honorBoardList[index]
                                    .data![index].subjects![index].id!
                                : honorBoardController
                                    .filteredHonorBoardList[index]
                                    .data![index]
                                    .subjects![index]
                                    .id!),
                      ],
                    ),
                  );
                },
              );
        //  });
        // }
      }),
    );
  }
}
