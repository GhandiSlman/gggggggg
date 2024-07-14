import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/teacher/data/week_plane_repo.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';
import 'package:lms/features/teacher/model/student_info.dart';
import 'package:lms/features/teacher/model/week_plane_model.dart';

class WeekPlaneController extends GetxController
    with GetTickerProviderStateMixin {
  final WeekPlaneRepo weekPlaneRepo;
  WeekPlaneController(this.weekPlaneRepo);

  late TabController tabController;
  RxList<Subject> selectedSectionSubjects = <Subject>[].obs;

  RxList<Tab> noDataTabs = <Tab>[
    Tab(
      text: 'No subjects'.tr,
    ),
  ].obs;

  var showSectionList = <SelectedListItem>[].obs;
  var showSubjectList = <SelectedListItem>[].obs;
  Map<String, List<Section>> sectionList = <String, List<Section>>{};
  RxList<String> selectedSection = <String>[].obs;
  Map<String, int> sectionNameToIdMap = {};
  Map<String, int> subjectNameToIdMap = {};
  RxBool isLoadingSection = false.obs;
  RxBool isLoadingAdd = false.obs;
  RxBool isLoadingWeekPlane = false.obs;

  RxList<SubjectInfo> studentInfo = <SubjectInfo>[].obs;
  bool isUpdate = false;
  late final TextEditingController sectionController;
  late final TextEditingController subjectController;
  late final TextEditingController lessonTitleController;
  late final TextEditingController lessonDescController;
  late final TextEditingController lessonDateController;
  RxInt selectedSectionId = 0.obs;
  RxInt selectedSubjectId = 0.obs;

  var gradeToIdMap = <String, String>{}.obs;

  RxList<Tab> myTabs = <Tab>[].obs;

  List<WeekPlaneDetails> weekPlane = <WeekPlaneDetails>[];
  int currentPage = 1;
  bool hasMorePages = true;
  RxBool isMoreLoading = false.obs;

  Future<void> addWeekPlane() async {
    isLoadingAdd.value = true;

    var addWeekPlaneModel = AddWeekPlaneModel(
      date: lessonDateController.text,
      description: lessonDescController.text,
      title: lessonTitleController.text,
      sectionId: selectedSectionId.value.toString(),
      subjectId: selectedSubjectId.value.toString(),
    );

    final result =
        await weekPlaneRepo.addWeekPlane(addWeekPlaneModel: addWeekPlaneModel);
    isLoadingAdd.value = false;
    if (result is DataSuccess) {
      lessonDateController.clear();
      lessonDescController.clear();
      lessonTitleController.clear();
      CustomToast.showToast(
        message: 'Week plane added successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: 'Failed to add week plane',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  Future<void> getStudentInf() async {
    final result =
        await weekPlaneRepo.getStudentInfo(studentInfo: StudentInfo());
    studentInfo.clear();

    if (result is DataSuccess) {
      studentInfo.value = result.data!.subjects!;
      updateTabs();
      if (studentInfo.isNotEmpty) {
        updateSelectedSubjectIdStudent(studentInfo[0].id!);
      }
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  Future<void> getSections() async {
    isLoadingSection.value = true;

    final result = await weekPlaneRepo.getSectionsAndSubjects();

    isLoadingSection.value = false;

    if (result is DataSuccess) {
      var attendance = result.data!;
      showSectionList.clear();
      sectionList.clear();
      sectionNameToIdMap.clear();
      selectedSection.clear();
      selectedSectionSubjects.clear();
      for (var res in attendance.result) {
        for (Grade grade in res.grades) {
          String gradeName =
              box.read('langCode') == 'ar' ? grade.name.ar : grade.name.en!;
          for (Section section in grade.sections) {
            String sectionName = box.read('langCode') == 'ar'
                ? section.name.ar
                : section.name.en!;
            showSectionList.add(SelectedListItem(
                name: "$gradeName $sectionName", value: section.id.toString()));
            sectionNameToIdMap["$gradeName $sectionName"] = section.id;

            if (!sectionList.containsKey("$gradeName $sectionName")) {
              sectionList["$gradeName $sectionName"] = [];
            }
            sectionList["$gradeName $sectionName"]!.add(section);
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

  void updateSelectedSection(SelectedListItem sectionName) {
    if (sectionNameToIdMap.containsKey(sectionName.name)) {
      selectedSectionId.value = int.tryParse(sectionName.value ?? "-1") ?? -1;

      updateSubjectsForSection(selectedSectionId.value);

      // Automatically select the first tab and get the weekly plan
      if (myTabs.isNotEmpty) {
        String firstTabText = myTabs[0].text!;
        if (subjectNameToIdMap.containsKey(firstTabText)) {
          int subjectId = subjectNameToIdMap[firstTabText]!;
          selectedSubjectId.value = subjectId;
          getWeekPlane(selectedSectionId.value, selectedSubjectId.value);
        }
      }
    }
  }

  void updateSelectedSubject(String subjectName) {
    if (subjectNameToIdMap.containsKey(subjectName)) {
      int subjectId = subjectNameToIdMap[subjectName]!;
      selectedSubjectId.value = subjectId;
    }
  }

  void updateSubjectsForSection(int sectionId) {
   // weekPlane.clear();
    selectedSectionSubjects.clear();
    var selectedSection = sectionList.entries
        .firstWhere((element) =>
            element.value.any((section) => section.id == sectionId))
        .value
        .firstWhere((section) => section.id == sectionId);

    for (var value in selectedSection.subjects) {
      selectedSectionSubjects.add(value);
    }

    showSubjectList.clear();
    subjectNameToIdMap.clear();

    for (var subject in selectedSectionSubjects) {
      String subjectName =
          box.read('langCode') == 'ar' ? subject.name.ar : subject.name.en!;
      showSubjectList.add(SelectedListItem(name: subjectName));
      subjectNameToIdMap[subjectName] = subject.id;
    }

    updateTabs();
  }

  void updateTabs() {
    myTabs.clear();
    if (box.read('userType') == 'teacher') {
      for (var subject in selectedSectionSubjects) {
        String subjectName =
            box.read('langCode') == 'ar' ? subject.name.ar : subject.name.en!;

        myTabs.add(Tab(text: subjectName));
      }
    } else if (box.read('userType') == 'student') {
      for (var subject in studentInfo) {
        myTabs.add(Tab(
            text: box.read('langCode') == 'ar'
                ? subject.name!.ar
                : subject.name!.en));
      }
    }
    tabController = TabController(
        length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
        vsync: this);

    if (myTabs.isNotEmpty) {
      String firstTabText = myTabs[0].text!;
      if (subjectNameToIdMap.containsKey(firstTabText)) {
        int subjectId = subjectNameToIdMap[firstTabText]!;
        selectedSubjectId.value = subjectId;
        getWeekPlane(selectedSectionId.value, selectedSubjectId.value);
      }
    }
  }

  Future<void> getWeekPlane(int sectionId, int subjectId) async {
    isLoadingWeekPlane.value = true;
    currentPage = 1;
    hasMorePages = true;
    weekPlane.clear();
    final result = await weekPlaneRepo.getWeekPlane(
        weekPlaneModel: WeekPlaneModel(),
        sectionId: sectionId,
        subjectId: subjectId,
        pageId: currentPage);
   // weekPlane.clear();
    isLoadingWeekPlane.value = false;
    if (result is DataSuccess) {
      //weekPlane.clear();
      weekPlane.addAll(result.data!.data!.data!);
      hasMorePages = false;
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  Future<void> updateWeekPlane(int weekPlaneId) async {
    isLoadingAdd.value = true;
    final updateWeekPlaneModel = WeekPlan(
      id: weekPlaneId,
      sectionId: selectedSectionId.value,
      subjectId: selectedSubjectId.value,
      lessonTitle: lessonTitleController.text,
      lessonDescription: lessonDescController.text,
      lessonDate: lessonDateController.text,
    );

    final result = await weekPlaneRepo.updateWeekPlane(
        updateWeekPlaneModel: updateWeekPlaneModel);
    isLoadingAdd.value = false;
    if (result is DataSuccess) {
      lessonTitleController.clear();
      lessonDescController.clear();
      lessonDateController.clear();

      CustomToast.showToast(
        message: 'Week plane updated successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: 'Failed to update week plane'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> deleteWeekPlane(int weekPlaneId) async {
    final result =
        await weekPlaneRepo.deleteWeekPlane(weekPlaneId: weekPlaneId);
    if (result is DataSuccess) {
      weekPlane.removeWhere((weekPlane) => weekPlane.id == weekPlaneId);
      CustomToast.showToast(
        message: 'Lesson deleted successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: 'Failed to delete lesson'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  void loadNextPage() {
    if (hasMorePages && !isMoreLoading.value) {
      isMoreLoading.value = true;
      currentPage++;
      int initialSubjectId = int.parse(gradeToIdMap[myTabs[0].text]!);
      fetchMoreWeelPlane(selectedSectionId.value, initialSubjectId);
    }
  }

  Future<void> fetchMoreWeelPlane(int sectionId, int subjectId) async {
    final result = await weekPlaneRepo.getWeekPlane(
        weekPlaneModel: WeekPlaneModel(),
        sectionId: sectionId,
        subjectId: subjectId,
        pageId: currentPage);

    if (result is DataSuccess) {
      if (result.data!.data != null) {
        hasMorePages = false;
      } else {
        weekPlane.addAll(result.data!.data!.data!);
      }
      isMoreLoading.value = false;
    } else if (result is DataFailed) {
      isMoreLoading.value = false;
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  void updateSelectedSectionId(int sectionId, int subjectId) {
    selectedSectionId.value = sectionId;
    getWeekPlane(sectionId, subjectId);
  }

  void updateSelectedSubjectIdStudent(int subjectId) {
    selectedSubjectId.value = subjectId;
    int sectionId =
        studentInfo.firstWhere((subject) => subject.id == subjectId).id!;
    getWeekPlane(sectionId, subjectId);
  }

  @override
  void onInit() {
    tabController = TabController(
        length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
        vsync: this);

    box.read('userType') == 'student'
        ? getStudentInf().then((value) {
            updateTabs();
          })
        : getSections();

    sectionController = TextEditingController();
    subjectController = TextEditingController();
    lessonTitleController = TextEditingController();
    lessonDescController = TextEditingController();
    lessonDateController = TextEditingController();

    super.onInit();
  }
}
