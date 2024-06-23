import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Make sure to add this package for formatting dates
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/data/student_repo.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:lms/features/students/model/student_status.dart';

class StudentController extends GetxController with GetTickerProviderStateMixin {
  final StudentRepo studentRepo;

  StudentController(this.studentRepo);

  late TextEditingController classController;
  late TabController tabController;
  var isLoading = false.obs;
  RxList<String> selectedClass = <String>[].obs;

  var classList = <SelectedListItem>[].obs;
  RxList<Tab> myTabs = <Tab>[].obs;
  RxList<Tab> noDataTabs = <Tab>[
    Tab(text: 'No subjects'.tr,)
  ].obs;
  Map<String, Map<String, List<Students>>> studentList = <String, Map<String, List<Students>>>{};
  Map<String, List<SectionSubjects>> sectionSubjectList = <String, List<SectionSubjects>>{};

  @override
  void onInit() {
    super.onInit();
    classController = TextEditingController();
    tabController = TabController(length: myTabs.isEmpty ? noDataTabs.length : myTabs.length, vsync: this);
    classController.addListener(updateOnClassChange);
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
    if (result is DataSuccess<StudentAttendance>) {
      var attendance = result.data!;
      classList.clear();
      studentList.clear();
      sectionSubjectList.clear();
      myTabs.clear();

      String currentDay = DateFormat('EEEE').format(DateTime.now());

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          for (var section in grade.sections!) {
            String combinedClassName = '${box.read('langCode') =='ar' ? grade.name!.ar! : grade.name!.en!} ${box.read('langCode') =='ar' ? section.name!.ar! : section.name!.en!}';
            classList.add(SelectedListItem(name: combinedClassName));
            studentList[combinedClassName] = {};
            sectionSubjectList[combinedClassName] = [];
            for (var sectionSubject in section.sectionSubjects!) {
              if (sectionSubject.day == currentDay) {
                String subjectName = box.read('langCode') =='ar' ? sectionSubject.subject!.name!.ar! : sectionSubject.subject!.name!.en!;
                if (!studentList[combinedClassName]!.containsKey(subjectName)) {
                  studentList[combinedClassName]![subjectName] = [];
                }
                studentList[combinedClassName]![subjectName]!.addAll(section.students!);
                sectionSubjectList[combinedClassName]!.add(sectionSubject);
              }
            }
          }
        }
      }
    } else {
      Get.snackbar(
        'Error',
        'Failed to load classes or no data available',
        backgroundColor: AppColor.redColor,
        colorText: AppColor.whiteColor,
      );
    }
  }

  void updateSelectedClass(String className) {
    selectedClass.value = [className];
    myTabs.clear();
    if (sectionSubjectList.containsKey(className)) {
      for (var sectionSubject in sectionSubjectList[className]!) {
        String subjectName = box.read('langCode') == 'ar' ? sectionSubject.subject!.name!.ar! : sectionSubject.subject!.name!.en!;
        myTabs.add(Tab(text: subjectName));
      }
      tabController = TabController(length: myTabs.isEmpty ? noDataTabs.length : myTabs.length, vsync: this);
    }
  }

  Future<void> store(StudentStatus sendingData) async {
    final studentstausMdel = StudentStatus();
    final DataState result = await studentRepo.studentStatusSend(studentAttendance: studentstausMdel);
    if (result is DataSuccess<StudentAttendance>) {
      Get.snackbar(
        'Success',
        'Attendance updated successfully',
        backgroundColor: AppColor.greenColor,
        colorText: AppColor.whiteColor,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to update attendance',
        backgroundColor: AppColor.redColor,
        colorText: AppColor.whiteColor,
      );
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
