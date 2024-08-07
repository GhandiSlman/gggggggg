import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/students/data/student_repo_imp.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/supervisor/data/student_status_repo.dart';
import 'package:lms/features/supervisor/model/student_attendance_status.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';

class StudentStatusController extends GetxController
    with GetTickerProviderStateMixin {
  final StudentStatusRepo studentStatusRepo;
  StudentRepoImp studentRepo = StudentRepoImp(Get.find());
  StudentStatusController(this.studentStatusRepo);

  RxList<StudentAttendanceStatusData> studentStatusList =
      <StudentAttendanceStatusData>[].obs;

  RxBool isLoadingSections = false.obs;
  RxBool isLoadingStudentStatus = false.obs;
  RxList<String> selectedClass = <String>[].obs;
  RxInt selectedSectionId = 0.obs;
  RxInt selectedSubjectId = 0.obs;
  late final TextEditingController classController;
  var classList = <SelectedListItem>[].obs;
  var selectedSectionSubjectList = <SelectedListItem>[].obs;

  Map<String, Map<String, List<Students>>> studentList =
      <String, Map<String, List<Students>>>{};
  Map<String, Map<String, List<Subject>>> subjectList =
      <String, Map<String, List<Subject>>>{};
  Map<String, List<SectionSubjects>> sectionSubjectList =
      <String, List<SectionSubjects>>{};

  var sectionToIdMap = <String, int>{}.obs;
  var subjectToIdMap = <String, int>{}.obs;
  late TabController tabController;
  RxList<Tab> myTabs = <Tab>[].obs;
  RxList<Tab> noDataTabs = <Tab>[
    Tab(
      text: 'No subjects'.tr,
    )
  ].obs;

  @override
  void onInit() {
    classController = TextEditingController();
    tabController = TabController(
        length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
        vsync: this);
    getClasses();
    super.onInit();
  }

  List<int> subjectIds = [];
  RxString selectedSection = "".obs;
  Future<void> getClasses() async {
    isLoadingSections.value = true;
    final DataState result = await studentRepo.getClasses(StudentAttendance());
    isLoadingSections.value = false;
    if (result is DataSuccess) {
      var attendance = result.data!;
      classList.clear();
      subjectList.clear();
      sectionSubjectList.clear();
      myTabs.clear();

      String currentDay = DateFormat('EEEE').format(DateTime.now());

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          for (var section in grade.sections!) {
            String combinedClassName =
                '${box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!} ${box.read('langCode') == 'ar' ? section.name!.ar! : section.name!.en!}';
            classList.add(SelectedListItem(
                name: combinedClassName, value: section.id.toString()));
            subjectList[combinedClassName] = {};
            sectionSubjectList[combinedClassName] = [];
            for (var sectionSubject in section.sectionSubjects!) {
              if (sectionSubject.day == currentDay) {
                String subjectName = box.read('langCode') == 'ar'
                    ? sectionSubject.subject!.name!.ar!
                    : sectionSubject.subject!.name!.en!;

                if (!subjectList[combinedClassName]!.containsKey(subjectName)) {
                  subjectList[combinedClassName]![subjectName] = [];
                }
                subjectList[combinedClassName]![subjectName]!
                    .add(sectionSubject.subject!);
                sectionSubjectList[combinedClassName]!.add(sectionSubject);
              }
            }
          }
        }
      }
    } else if (result is DataFailed) {
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

  handleTabBarChange(int subjectIndex) {
    int id = subjectIds[subjectIndex];
    print(id);

    print(selectedSectionId.value);
    getStudentStatus(selectedSectionId.value, subjectIds[subjectIndex]);

    // print(subjectToIdMap[subjectName]);
  }

  void updateSelectedClass(String className) {
    subjectIds.clear();
    selectedSection.value = className;
    selectedClass.value = [className];
    myTabs.clear();
    if (sectionSubjectList.containsKey(className)) {
      for (var sectionSubject in sectionSubjectList[className]!) {
        String subjectName = box.read('langCode') == 'ar'
            ? sectionSubject.subject!.name!.ar
            : sectionSubject.subject!.name!.en!;
        subjectIds.add(sectionSubject.subject!.id);
        myTabs.add(Tab(text: subjectName));
      }
      tabController = TabController(
          length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
          vsync: this);
    }
  }

  Future<void> getStudentStatus(int sectionId, int subjectId) async {
    isLoadingStudentStatus.value = true;
    final result = await studentStatusRepo.getStudentStatus(
        studentAttendanceStatus: StudentAttendanceStatus(),
        sectoinId: sectionId,
        subjectId: subjectId);
    isLoadingStudentStatus.value = false;
    if (result is DataSuccess) {
      studentStatusList.value = result.data!.data!;
    } else if (result is DataFailed) {
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

  // List<String> getSubjectList() {
  //   if (selectedClass.isEmpty) {
  //     return [];
  //   }
  //   String className = selectedClass.first;
  //   return subjectList[className]?.keys.toList() ?? [];
  // }
}
