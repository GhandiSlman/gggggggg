import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/drop_down.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/week_plane_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/week_plane_card.dart';

class TeacherWeekPlaneScreen extends StatelessWidget {
  const TeacherWeekPlaneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeekPlaneController weekPlaneController = Get.find();
    return Scaffold(
      floatingActionButton: box.read('userType') == 'student'
          ? null
          : FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              onPressed: () {
                Get.toNamed(AppRouter.addToWeekPlaneScreen, arguments: {
                  'isUpdate': weekPlaneController.isUpdate == true
                });
              },
              child: Icon(
                Icons.add,
                color: AppColor.whiteColor,
              ),
            ),
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'Week plane'.tr,
        bottom: PreferredSize(
          preferredSize: box.read('userType') == 'teacher'
              ? Size.fromHeight(125.h)
              : Size.fromHeight(60.h),
          child: Column(
            children: [
              box.read('userType') == 'teacher'
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Obx(
                        () => weekPlaneController.isLoadingSection.value
                            ? ShimmerWidget(height: 50.h)
                            : DropDownList(
                                onSelectedItems:
                                    (List<SelectedListItem> selectedItems) {
                                  weekPlaneController.updateSelectedSection(
                                      selectedItems.last.name);
                                },
                                dataList: weekPlaneController.showSectionList,
                                textEditingController:
                                    weekPlaneController.sectionController,
                                hint: 'Choose section'.tr,
                                isCitySelected: true,
                              ),
                      ),
                    )
                  : const SizedBox(),
              Obx(
                () => TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: AppColor.primaryColor,
                  labelColor: AppColor.primaryColor,
                  controller: weekPlaneController.tabController,
                  onTap: (index) {
                    if (box.read('userType') == 'teacher') {
                      if (weekPlaneController
                          .selectedSectionSubjects.isNotEmpty) {
                        int subjectId = weekPlaneController
                            .selectedSectionSubjects[index].id!;
                        weekPlaneController.updateSelectedSectionId(
                            weekPlaneController.selectedSectionId.value,
                            subjectId);
                      }
                    } else if (box.read('userType') == 'student') {
                      if (weekPlaneController.studentInfo.isNotEmpty) {
                        int subjectId =
                            weekPlaneController.studentInfo[index].id!;
                        weekPlaneController
                            .updateSelectedSubjectIdStudent(subjectId);
                      }
                    }
                  },
                  tabs: weekPlaneController.myTabs.isEmpty
                      ? weekPlaneController.noDataTabs.toList()
                      : weekPlaneController.myTabs.toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => TabBarView(
          controller: weekPlaneController.tabController,
          children: weekPlaneController.myTabs.isEmpty
              ? weekPlaneController.noDataTabs
                  .map((tab) => Center(child: Text(tab.text!)))
                  .toList()
              : weekPlaneController.myTabs.map((tab) {
                  var weekPlanDetails = weekPlaneController.weekPlane;
                  return weekPlaneController.isLoadingWeekPlane.value
                      ? ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10.h),
                              child: ShimmerWidget(height: 75.h),
                            );
                          })
                      : ListView.builder(
                          itemCount: weekPlanDetails.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10.h),
                              child: WeekPlaneCard(
                                weekPlaneDetails: weekPlanDetails[index],
                                title: weekPlanDetails[index].lessonTitle ??
                                    'No title',
                                date: weekPlanDetails[index].lessonDate ??
                                    'No date',
                              ),
                            );
                          },
                        );
                }).toList(),
        ),
      ),
    );
  }
}
