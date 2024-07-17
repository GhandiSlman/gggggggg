import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/students/controller/student_controller.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/students/presentation/widgets/student_card.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentController studentController = Get.find();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'Student Attendance'.tr,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(125.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Obx(
                  () => studentController.isLoading.value
                      ? ShimmerWidget(
                          height: 50.h,
                        )
                      : DropDownList(
                          onSelectedItems: (List<SelectedListItem> selectedItems) {
                            if (selectedItems.isNotEmpty) {
                              studentController
                                  .updateSelectedClass(selectedItems.last.name);
                            }
                          },
                          dataList: studentController.classList,
                          textEditingController:
                              studentController.classController,
                          hint: 'Choose class'.tr,
                          isCitySelected: true,
                        ),
                ),
              ),
              Obx(
                () => TabBar(
                  indicatorColor: AppColor.primaryColor,
                  labelColor: AppColor.primaryColor,
                  controller: studentController.tabController,
                  tabs: studentController.myTabs.isEmpty
                      ? studentController.noDataTabs.toList()
                      : studentController.myTabs.toList(),
                  //  onTap: studentController.handleTabSelection,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => studentController.isLoading.value
          ? ListView.builder(
              itemCount: 3,
              itemBuilder: ((context, index) => Padding(
                    padding: EdgeInsets.all(15.h),
                    child: ShimmerWidget(
                      height: 75.h,
                    ),
                  )))
          : TabBarView(
              controller: studentController.tabController,
              children: studentController.myTabs.isEmpty
                  ? studentController.noDataTabs
                      .map((tab) => Center(child: Text(tab.text!)))
                      .toList()
                  : studentController.myTabs.map((tab) {
                      String currentClassName =
                          studentController.selectedClass.isNotEmpty
                              ? studentController.selectedClass.first
                              : 'No Data';
                      Map<String, List<Students>>? subjects =
                          studentController.studentList[currentClassName];
                      Map<String, List<Subject>>? subjectIds =
                          studentController.subjectList[currentClassName];
                      List<Students>? students = subjects?[tab.text];
                      List<Subject>? subjectList = subjectIds?[tab.text];
                      return students!.isEmpty
                          ? Center(
                              child: CustomText(
                                text: 'No students today'.tr,
                                color: AppColor.primaryColor,
                                fontSize: 20.sp,
                              ),
                            )
                          : ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (context, index) {
                                var student = students[index];
                                var subject = subjectList![0];
                                return Padding(
                                  padding: EdgeInsets.all(15.h),
                                  child: StudentCard(
                                    name: student.name!,
                                    studentId: student.id!,
                                    subjectId: subject.id,
                                  ),
                                );
                              },
                            );
                    }).toList(),
            )),
    );
  }
}
