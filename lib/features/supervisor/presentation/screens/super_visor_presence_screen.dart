import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/features/supervisor/presentation/widgets/student_status_card.dart';
import 'package:lms/features/teacher/controller/teacher_controller.dart';

class SuperVisorPresenceScreen extends StatelessWidget {
  const SuperVisorPresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.put(TeacherController());
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'SuperVisor Presence',
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(160.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: DropDownList(
                      onSelectedItems: (List<String> selectedItems) {
                        teacherController.selectedCities = selectedItems;
                      },
                      dataList: teacherController.cityList,
                      textEditingController: teacherController.classController,
                      hint: 'Choose class'.tr,
                      isCitySelected: true),
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                   child: DropDownList(
                            onSelectedItems: (List<String> selectedItems) {
                              teacherController.selectedSubject = selectedItems;
                            },
                            dataList: teacherController.subjectList,
                            textEditingController: teacherController.subjectController,
                            hint: 'Choose subject'.tr,
                            isCitySelected: true),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            )),
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 25.h,
            child: Center(
              child: CustomText(
                text: 'Sunday 25/7/2024',
                color: AppColor.greyColor2,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: (1 / 1.3),
                  ),
                  itemBuilder: (_, index) {
                    return const StudentStatusCard();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
