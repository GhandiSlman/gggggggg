import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/data/activity_repo.dart';
import 'package:lms/features/teacher/model/activity.dart';
import 'package:lms/features/teacher/model/test_activity.dart';
import 'package:lms/features/teacher/model/update_activity.dart';

class ActivityController extends GetxController {
  ActivityRepo activityRepo;

  ActivityController(this.activityRepo);

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController dateController;
  late final TextEditingController sectionController;
  RxBool isLoadingSection = false.obs;
  RxString selectedSectionId = ''.obs;
  RxBool isAdded = false.obs;
  RxBool isGetActivity = false.obs;
  bool isUpdated = false;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingDeleted = false.obs;
  var showSectionList = <SelectedListItem>[].obs;
  Map<String, List<Sections>> sectionList = <String, List<Sections>>{};
  RxList<Activity> activityList = <Activity>[].obs;
  RxList<ActivityIndex> activityListIndex = <ActivityIndex>[].obs;
  Map<String, String> sectionNameToIdMap = {};

  RxList<String> selectedSection = <String>[].obs;

  var gradeToIdMap = <String, String>{}.obs;

  void updateSelectedSectionId(String sectionId) {
    selectedSectionId.value = sectionId;
    getActivity(sectionId); // Fetch activities based on selected section ID
  }

  void updateSelectedSection(String className) {
    selectedSection.value = [className];
    if (sectionNameToIdMap.containsKey(className)) {
      updateSelectedSectionId(sectionNameToIdMap[className]!);
    }
  }

  Future<void> getSections() async {
    isLoadingSection.value = true;

    final result =
        await activityRepo.getSections(studentAttendance: StudentAttendance());

    isLoadingSection.value = false;

    if (result is DataSuccess<StudentAttendance>) {
      var attendance = result.data!;
      showSectionList.clear();
      sectionList.clear();
      sectionNameToIdMap.clear();
      selectedSection.clear();

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          for (var section in grade.sections!) {
            String sectionName = box.read('langCode') == 'ar'
                ? section.name!.ar!
                : section.name!.en!;
            showSectionList.add(SelectedListItem(name: sectionName));
            sectionNameToIdMap[sectionName] =
                section.id.toString(); // Store section ID

            if (!sectionList.containsKey(sectionName)) {
              sectionList[sectionName] = [];
            }
            sectionList[sectionName]!.add(section);
          }
        }
      }
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: 'Failed to load data',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  Future<void> addActivity() async {
    isAdded.value = true;
    final createActivityModel = CreateActivityModel(
      sectionId: selectedSectionId.value,
      title: titleController.text,
      description: descriptionController.text,
      date: dateController.text,
    );

    final result = await activityRepo.addActivity(
        createActivityModel: createActivityModel);

    if (result is DataSuccess) {
      titleController.clear();
      descriptionController.clear();
      dateController.clear();
      isAdded.value = false;
      CustomToast.showToast(
        message: 'Activity added successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed) {
      isAdded.value = false;
      CustomToast.showToast(
        message: 'Failed to add activity'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> updateActivity(String activityId) async {
    isAdded.value = true;
    final createActivityModel = UpdateActivityModel(
      sectionId: selectedSectionId.value,
      activityId: activityId,
      title: titleController.text,
      description: descriptionController.text,
      date: dateController.text,
    );

    final result = await activityRepo.updateActivity(
        createActivityModel: createActivityModel);

    if (result is DataSuccess) {
      titleController.clear();
      descriptionController.clear();
      dateController.clear();
      isAdded.value = false;
      CustomToast.showToast(
        message: 'Activity updated successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed) {
      isAdded.value = false;
      CustomToast.showToast(
        message: 'Failed to update activity'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> deleteActivity(int activityId) async {
    isLoadingDelete.value = true;
    final result = await activityRepo.deleteActivity(activityId: activityId);
    isLoadingDelete.value = false;
    if (result is DataSuccess<GetActivity>) {
      activityList.removeWhere((activity) => activity.id == activityId);
      CustomToast.showToast(
        message: 'Activity deleted successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed) {
      // isLoadingDelete.value = false;
      CustomToast.showToast(
        message: 'Failed to delete activity'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> getActivity(String sectionId) async {
    isGetActivity.value = true;
    final result = await activityRepo.getActivity(
        sectionId: sectionId, getActivity: GetActivity());
    isGetActivity.value = false;
    print(result.statusCode);
    if (result is DataSuccess<GetActivity>) {
      activityList.clear();
      if (result.data?.activity != null) {
        activityList.addAll(result.data!.activity!);
      }
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: 'Failed to load activities'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> getActivitySuper() async {
    print('[[[[[[[[[[]]]]]]]]]]');
    print(box.read('userType'));
    print('[[[[[[[[[[]]]]]]]]]]');
    isGetActivity.value = true;
    final result =
        await activityRepo.getActivitySuper(getActivity: GetActivityIndex());
    isGetActivity.value = false;
    print(result.statusCode);
    if (result is DataSuccess<GetActivityIndex>) {
      activityListIndex.clear();
      if (result.data?.activity != null) {
        activityListIndex.addAll(result.data!.activity!);
      }
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: 'Failed to load activities'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else {
      print('0000000000000000000000');
      print(result.statusCode);
      print('0000000000000000000000');
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    sectionController = TextEditingController();
    box.read('userType') == 'teacher' ? getSections() : getActivitySuper();
    //getActivitySuper();
    super.onInit();
  }
}
