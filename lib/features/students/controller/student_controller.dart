import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/students/data/student_repo.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:lms/features/students/model/student_status.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';

class StudentController extends GetxController
    with GetTickerProviderStateMixin {
  final StudentRepo studentRepo;

  StudentController(this.studentRepo);

  late TextEditingController classController;
  late TabController tabController;
  var isLoading = false.obs;
  RxList<String> selectedClass = <String>[].obs;

  var classList = <SelectedListItem>[].obs;
  RxList<Tab> myTabs = <Tab>[].obs;
  RxList<Tab> noDataTabs = <Tab>[
    Tab(
      text: 'No subjects'.tr,
    )
  ].obs;
  Map<String, Map<String, List<Students>>> studentList =
      <String, Map<String, List<Students>>>{};
  Map<String, Map<String, List<Subject>>> subjectList =
      <String, Map<String, List<Subject>>>{};
  Map<String, List<SectionSubjects>> sectionSubjectList =
      <String, List<SectionSubjects>>{};

  RxMap<int, String> studentAttendanceStatus = <int, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    classController = TextEditingController();
    tabController = TabController(
        length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
        vsync: this);
    classController.addListener(updateOnClassChange);
    loadSavedAttendanceStatus();
    getClasses();
  }

  void updateOnClassChange() {
    if (classController.text.isNotEmpty) {
      updateSelectedClass(classController.text);
    }
  }

  Future<void> getClasses() async {
    isLoading.value = true;
    final DataState result = await studentRepo.getClasses(StudentAttendance());
    isLoading.value = false;
    if (result is DataSuccess) {
      var attendance = result.data!;

      classList.clear();
      studentList.clear();
      subjectList.clear();
      sectionSubjectList.clear();
      myTabs.clear();

      String currentDay = DateFormat('EEEE').format(DateTime.now());

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          for (var section in grade.sections!) {
            String combinedClassName =
                '${box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!} ${box.read('langCode') == 'ar' ? section.name!.ar! : section.name!.en!}';
            classList.add(SelectedListItem(name: combinedClassName));

            studentList[combinedClassName] = {};
            subjectList[combinedClassName] = {};
            sectionSubjectList[combinedClassName] = [];
            for (var sectionSubject in section.sectionSubjects!) {
              if (sectionSubject.day == currentDay) {
                String subjectName = box.read('langCode') == 'ar'
                    ? sectionSubject.subject!.name!.ar!
                    : sectionSubject.subject!.name!.en!;

                if (!studentList[combinedClassName]!.containsKey(subjectName)) {
                  studentList[combinedClassName]![subjectName] = [];
                }
                if (!subjectList[combinedClassName]!.containsKey(subjectName)) {
                  subjectList[combinedClassName]![subjectName] = [];
                }
                subjectList[combinedClassName]![subjectName]!
                    .add(sectionSubject.subject!);

                studentList[combinedClassName]![subjectName]!
                    .addAll(section.students!);

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

  void loadSavedAttendanceStatus() {
    Map<String, dynamic> savedStatus = box.read('attendanceStatus') ?? {};
    studentAttendanceStatus.value = savedStatus
        .map((key, value) => MapEntry(int.parse(key), value.toString()));
  }

  void saveAttendanceStatus() {
    box.write(
        'attendanceStatus',
        studentAttendanceStatus
            .map((key, value) => MapEntry(key.toString(), value)));
  }

  void updateSelectedClass(String className) {
    selectedClass.value = [className];
    myTabs.clear();
    if (sectionSubjectList.containsKey(className)) {
      for (var sectionSubject in sectionSubjectList[className]!) {
        String subjectName = box.read('langCode') == 'ar'
            ? sectionSubject.subject!.name!.ar!
            : sectionSubject.subject!.name!.en!;
        myTabs.add(Tab(text: subjectName));
      }
      tabController = TabController(
          length: myTabs.isEmpty ? noDataTabs.length : myTabs.length,
          vsync: this);
    }
  }

  Future<void> handleAttendance(
      String status, int studentId, int subjectId) async {
    studentAttendanceStatus[studentId] = status;
    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final studentStatusModel = StudentStatus(
      status: status,
      date: date,
      studentId: studentId,
      subjectId: subjectId,
    );

    final DataState result = await studentRepo.studentStatusSend(
        studentAttendance: studentStatusModel);

    if (result is DataSuccess) {
      saveAttendanceStatus();
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

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
