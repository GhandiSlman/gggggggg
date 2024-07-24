import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/honor_board/controller/honor_board_controller.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/data/continuous_rating_repo.dart';
import 'package:lms/features/teacher/model/add_continuous_rate.dart';
import 'package:lms/features/teacher/model/add_continuous_rate_student.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';
import 'package:lms/features/teacher/model/continuous_rating.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';
import 'package:lms/features/teacher/model/update_continuous_rate.dart';

class ContinuousRatingController extends GetxController {
  ContinuousRatingRepo continuousRatingRepo;
  ContinuousRatingController(
      this.continuousRatingRepo, this.honorBoardController);

  late final TextEditingController rateController;
  late final TextEditingController pointController;

  HonorBoardController honorBoardController;

  RxBool isLoadingGetCon = false.obs;
  RxBool isLoadingAddCon = false.obs;
  RxBool isLoadnigGetRateStudent = false.obs;
  RxBool isLoadnigAddRateStudent = false.obs;
  RxBool isLoadingStudentSubject = false.obs;
  bool isUpdate = false;
  RxList<ContinuousRatingData> ratingList = <ContinuousRatingData>[].obs;
  RxList<GetContinuousRateStudentData> ratingStudentList =
      <GetContinuousRateStudentData>[].obs;

  // Class
  var showClassList = <SelectedListItem>[].obs;
  Map<String, List<Students>> classList = <String, List<Students>>{};
  RxList<String> selectedClass = <String>[].obs;

  // Subject
  var showSubjectList = <SelectedListItem>[].obs;
  Map<String, List<Subject>> subjectList = <String, List<Subject>>{};
  RxList<String> selectedSubject = <String>[].obs;
  RxString selectedSubjectId = ''.obs;

  var subjectToIdMap = <String, String>{}.obs;

  // Students
  RxString selectedStudentId = ''.obs;
  var studentToIdMap = <String, String>{}.obs;
  var showStudentList = <SelectedListItem>[].obs;
  Map<String, List<Students>> studentList = <String, List<Students>>{};
  RxList<String> selectedStudents = <String>[].obs;

  Future<void> getClassSubjectStudent() async {
    isLoadingStudentSubject.value = true;
    final result = await continuousRatingRepo.getSubjects(
        studentAttendance: StudentAttendance());

    // Clear lists before populating
    classList.clear();
    showClassList.clear();
    subjectList.clear();
    showSubjectList.clear();
    studentList.clear();
    showStudentList.clear();
    isLoadingStudentSubject.value = false;

    if (result is DataSuccess<StudentAttendance>) {
      classList.clear();
      showClassList.clear();
      subjectList.clear();
      showSubjectList.clear();
      studentList.clear();
      showStudentList.clear();
      var attendance = result.data!;

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          String className =
              box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!;
          showClassList.add(SelectedListItem(name: className));

          classList[className] = [];
          for (var section in grade.sections!) {
            for (var sectionSubject in section.sectionSubjects!) {
              // Add subjects to subject list
              String subjectName = box.read('langCode') == 'ar'
                  ? sectionSubject.subject!.name?.ar ?? ''
                  : sectionSubject.subject!.name?.en ?? '';
              if (!subjectList.containsKey(className)) {
                subjectList[className] = [];
              }
              if (!subjectList[className]!
                  .map((e) => e.id)
                  .contains(sectionSubject.subject!.id)) {
                subjectList[className]!.add(sectionSubject.subject!);
              }

              if (!showSubjectList
                  .map((e) => e.value)
                  .contains(sectionSubject.subject!.id.toString())) {
                showSubjectList.add(SelectedListItem(
                    name: subjectName,
                    value: sectionSubject.subject!.id.toString()));
              }

              subjectToIdMap[subjectName] =
                  sectionSubject.subject!.id.toString();
            }
            for (var student in section.students!) {
              String studentName = student.name!;
              showStudentList.add(SelectedListItem(name: studentName));
              studentToIdMap[studentName] = student.id.toString();
              if (!studentList.containsKey(className)) {
                studentList[className] = [];
              }
              studentList[className]!.add(student);
            }
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

  void updateSelectedStudent(String studentName) {
    selectedStudents.value = [studentName];
    if (studentToIdMap.containsKey(studentName)) {
      selectedStudentId.value = studentToIdMap[studentName]!;
    }
  }

  void updateSelectedSubject(String subjectName) {
    selectedSubject.value = [subjectName];
    if (subjectToIdMap.containsKey(subjectName)) {
      selectedSubjectId.value = subjectToIdMap[subjectName]!;
    }
  }

  Future<void> getContinuousRating() async {
    isLoadingGetCon.value = true;
    final DataState result = await continuousRatingRepo.getContinuousRating(
        continuousRating: ContinuousRating());
    isLoadingGetCon.value = false;
    ratingList.clear();
    if (result is DataSuccess) {
      ratingList.addAll(result.data!.data!);
    } else if (result is DataFailed) {
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

  Future<void> addRate() async {
    isLoadingAddCon.value = true;
    final addContinuousRating = AddContinuousRating(
      name: rateController.text,
      xp: pointController.text,
    );
    final DataState result = await continuousRatingRepo.addContinuousRate(
        addContinuousRating: addContinuousRating);
    isLoadingAddCon.value = false;
    if (result is DataSuccess) {
      rateController.clear();
      pointController.clear();
      CustomToast.showToast(
        message: 'Rate added successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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

  Future<void> getContinuousRatingStudent(String rateId) async {
    isLoadnigGetRateStudent.value = true;
    final DataState result =
        await continuousRatingRepo.getContinuousRateStudent(
            getContinuousRateStudent: GetContinuousRateStudent(),
            rateId: rateId);
    ratingStudentList.clear();
    isLoadnigGetRateStudent.value = false;
    if (result is DataSuccess) {
      ratingStudentList.addAll(result.data!.data!);
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

  Future<void> addRateStudent(String reinforcementXpId) async {
    isLoadnigAddRateStudent.value = true;
    final addContinuousRatingStudent = AddContinuousRateStudent(
      reinforcementXpId: reinforcementXpId,
      studentId: selectedStudentId.value,
      subjectId: selectedSubjectId.value,
    );

    final DataState result =
        await continuousRatingRepo.addContinuousRateStudent(
            addContinuousRateStudent: addContinuousRatingStudent);
    isLoadnigAddRateStudent.value = false;
    if (result is DataSuccess) {
      rateController.clear();
      pointController.clear();
      CustomToast.showToast(
        message: 'Rate added successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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

  Future<void> updateRate(int id) async {
    isLoadingAddCon.value = true;
    final updateContinuousRate = UpdateContinuousRate(
      name: rateController.text,
      xp: pointController.text,
    );
    final DataState result =
        await continuousRatingRepo.updateContinuousRateStudent(
            updateContinuousRate: updateContinuousRate, id: id);
    isLoadingAddCon.value = false;
    if (result is DataSuccess) {
      rateController.clear();
      pointController.clear();
      CustomToast.showToast(
        message: 'Rate updated successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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

  Future<void> deleteRate(int id) async {
    final result = await continuousRatingRepo.deleteContinuousRate(id: id);
    if (result is DataSuccess) {
      ratingList.removeWhere((rate) => rate.id == id);
      CustomToast.showToast(
        message: 'Rate deleted successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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

  Future<void> deleteRateStudent(int id) async {
    final result =
        await continuousRatingRepo.deleteContinuousRateStudent(id: id);
    if (result is DataSuccess) {
      ratingStudentList.removeWhere((rate) => rate.id == id);
      CustomToast.showToast(
        message: 'Rate deleted successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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
  void onInit() {
    box.read('userType') == 'teacher' ? getClassSubjectStudent() : null;
    getContinuousRating();
    rateController = TextEditingController();
    pointController = TextEditingController();
    super.onInit();
  }
}
