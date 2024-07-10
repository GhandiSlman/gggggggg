import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/teacher/data/homework_repo.dart';
import 'package:lms/features/teacher/model/create_details_homework.dart';
import 'package:lms/features/teacher/model/add_home_work.dart';
import 'package:lms/features/teacher/model/get_homework_model.dart';

class HomeWorkController extends GetxController
    with GetTickerProviderStateMixin {
  final HomeWorkRepo homeWorkRepo;

  HomeWorkController(this.homeWorkRepo);

  late TabController tabController;
  late TextEditingController classController;
  late TextEditingController sectionController;
  late TextEditingController titleHomeWorkController;
  late TextEditingController detailsHomeWorkController;
  late TextEditingController dateController;
  RxBool isLoadingSubject = false.obs;
  RxBool isLoadingAddUpdateHomeWork = false.obs;
  RxBool isLoadingGetHomeWork = false.obs;
  // RxBool isLoadingDelete = false.obs;
  RxList<String> selectedClass = <String>[].obs;
  RxList<String> selectedSubject = <String>[].obs;
  RxInt selectedSectionId = 0.obs;
  RxInt selectedSubjectId = 0.obs;

  bool isUpdateHomeWork = false;

  var classList = <SelectedListItem>[].obs;
  var selectedSectionSubjectList = <SelectedListItem>[].obs;

  Map<String, Map<String, List<SectionSubjects>>> subjectList =
      <String, Map<String, List<SectionSubjects>>>{};
  Map<String, Map<String, List<SectionSubjects>>> sectionSubjectList =
      <String, Map<String, List<SectionSubjects>>>{};

  RxList<HomeWorkData> homeWorkList = <HomeWorkData>[].obs;

  RxList<Tab> noDataTabs = <Tab>[
    Tab(
      text: 'No subjects'.tr
    ),
  ].obs;
  RxList<Tab> myTabs = <Tab>[].obs;

  var sectionToIdMap = <String, int>{}.obs;
  var subjectToIdMap = <String, int>{}.obs;

  Future<void> getSubjects() async {
    isLoadingSubject.value = true;
    final DataState result = await homeWorkRepo.getSubjects(
        createDetailsHomeWork: CreateDetailsHomeWork());
    isLoadingSubject.value = false;
    if (result is DataSuccess<CreateDetailsHomeWork>) {
      var createSubject = result.data!;
      classList.clear();
      subjectList.clear();
      sectionSubjectList.clear();
      myTabs.clear();
      sectionToIdMap.clear();
      subjectToIdMap.clear();

      for (var res in createSubject.data!) {
        for (var grade in res.grades!) {
          for (var section in grade.sections!) {
            String combinedName =
                '${box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!} ${box.read('langCode') == 'ar' ? section.name!.ar! : section.name!.en!}';
            classList.add(SelectedListItem(name: combinedName));
            subjectList[combinedName] = {};
            for (var sectionSubject in section.sectionSubjects!) {
              String combinedSectionSubjectName =
                  '${box.read('langCode') == 'ar' ? section.name!.ar! : section.name!.en!} ${box.read('langCode') == 'ar' ? sectionSubject.subject!.name!.ar! : sectionSubject.subject!.name!.en!}';
              selectedSectionSubjectList
                  .add(SelectedListItem(name: combinedSectionSubjectName));
              sectionToIdMap[combinedSectionSubjectName] = section.id!;
              subjectToIdMap[combinedSectionSubjectName] =
                  sectionSubject.subject!.id!;

              String subjectName = box.read('langCode') == 'ar'
                  ? sectionSubject.subject!.name!.ar!
                  : sectionSubject.subject!.name!.en!;
              if (!subjectList[combinedName]!.containsKey(subjectName)) {
                subjectList[combinedName]![subjectName] = [];
              }
              subjectList[combinedName]![subjectName]!.add(sectionSubject);
            }
          }
        }
      }
    } else if (DataState is DataFailed) {
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

  void updateSelectedClass(String className) {
    selectedClass.value = [className];
    selectedSubject.value = [className];
    myTabs.clear();
    selectedClass.clear();
    if (subjectList.containsKey(className)) {
      subjectList[className]!.forEach((subjectName, students) {
        myTabs.add(Tab(text: subjectName));
      });
    }

    tabController = TabController(
        length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
        vsync: this);
  }

  void updateSelectedSectionId(int sectionId, int subjectId) {
    selectedSectionId.value = sectionId;
    selectedSubjectId.value = subjectId;
  }

  void updateOnClassChange() {
    if (classController.text.isNotEmpty) {
      updateSelectedClass(classController.text);
    }
  }

  Future<void> addHomeWork() async {
    isLoadingAddUpdateHomeWork.value = true;
    final sectionModel = Homework(
      sectionId: selectedSectionId.value,
      subjectId: selectedSubjectId.value,
      description: detailsHomeWorkController.text,
      title: titleHomeWorkController.text,
      endDate: dateController.text,
    );
    final DataState result =
        await homeWorkRepo.addHomeWork(sectionSubjects: sectionModel);
    isLoadingAddUpdateHomeWork.value = false;
    if (result is DataSuccess) {
      titleHomeWorkController.clear();
      detailsHomeWorkController.clear();
      dateController.clear();
      CustomToast.showToast(
        message: 'Home work added successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (DataState is DataFailed) {
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> deleteHomeWork(int homeWorkId) async {
    final result = await homeWorkRepo.deleteHomeWork(homeWorkId: homeWorkId);
    if (result is DataSuccess) {
      homeWorkList.removeWhere((homeWork) => homeWork.id == homeWorkId);
      CustomToast.showToast(
        message: 'Lesson deleted successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed) {
      // isLoadingDelete.value = false;
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

  Future<void> updateHomeWork(int homeWorkId) async {
    isLoadingAddUpdateHomeWork.value = true;
    final homeWork = Homework(
      homeworkId: homeWorkId,
      sectionId: selectedSectionId.value,
      subjectId: selectedSubjectId.value,
      description: detailsHomeWorkController.text,
      title: titleHomeWorkController.text,
      endDate: dateController.text,
    );

    final DataState result =
        await homeWorkRepo.updateHomeWork(homework: homeWork);
    isLoadingAddUpdateHomeWork.value = false;
    if (result is DataSuccess) {
      titleHomeWorkController.clear();
      detailsHomeWorkController.clear();
      dateController.clear();
      CustomToast.showToast(
        message: 'Home work updated successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (DataState is DataFailed) {
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

  Future<void> getHomeWork() async {
    isLoadingGetHomeWork.value = true;
    final DataState result = await homeWorkRepo.getHomeWork(
      getHomeWorkModel: GetHomeWorkModel(),
      sectionId: selectedSectionId.value,
      subjectId: selectedSubjectId.value,
    );
    isLoadingGetHomeWork.value = false;
    if (result is DataSuccess<GetHomeWorkModel>) {
      homeWorkList.clear();
      homeWorkList.addAll(result.data!.data!);
    } else if (DataState is DataFailed) {
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  void handleTabSelection(int tabIndex) {
    if (myTabs.isNotEmpty && tabIndex < myTabs.length) {
      String tabText = myTabs[tabIndex].text!;
      String className = selectedSubject.first;
      if (subjectList[className]?.containsKey(tabText) ?? false) {
        var sectionsSubjects = subjectList[className]![tabText]!.first;
        updateSelectedSectionId(
            sectionsSubjects.id!, sectionsSubjects.subject!.id!);
        getHomeWork();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    classController = TextEditingController();
    sectionController = TextEditingController();
    titleHomeWorkController = TextEditingController();
    detailsHomeWorkController = TextEditingController();
    dateController = TextEditingController();
    tabController = TabController(
        length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
        vsync: this);
    classController.addListener(updateOnClassChange);
    box.read('userType') == 'teacher' ? getSubjects() : getHomeWork();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
