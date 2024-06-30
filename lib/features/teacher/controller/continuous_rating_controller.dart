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
import 'package:lms/features/teacher/model/create_details_homework.dart';
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
  RxBool isLoadingSubject = false.obs;
  bool isUpdate = false;
  RxList<ContinuousRatingData> ratingList = <ContinuousRatingData>[].obs;
  RxList<GetContinuousRateStudentData> ratingStudentList =
      <GetContinuousRateStudentData>[].obs;

  var showStudentList = <SelectedListItem>[].obs;

  var showSubjectList = <SelectedListItem>[].obs;

  // RxList<Subject> subjectList = <Subject>[].obs;

  Future<void> getSubjects() async {
    isLoadingSubject.value = true;
    final DataState result = await continuousRatingRepo.getSubjects(
        studentAttendance: StudentAttendance());
    isLoadingSubject.value = false;
    if (result is DataSuccess<StudentAttendance>) {
      var createSubject = result.data!;
      showStudentList.clear();
      //subjectList.clear();

      for (var res in createSubject.result!) {
        for (var grade in res.grades!) {
          for (var section in grade.sections!) {
            for (var sectionSubject in section.sectionSubjects!) {
              for (var student in section.students!) {
                String studentName = student.name!;

                showStudentList.add(SelectedListItem(name: studentName));
              }

              String subjectName = box.read('langCode') == 'ar'
                  ? sectionSubject.subject!.name!.ar!
                  : sectionSubject.subject!.name!.en!;
              showSubjectList.add(SelectedListItem(name: subjectName));
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

  Future<void> getContinuousRating() async {
    isLoadingGetCon.value = true;
    final DataState result = await continuousRatingRepo.getContinuousRating(
        continuousRating: ContinuousRating());
    isLoadingGetCon.value = false;
    ratingList.clear();
    if (result is DataSuccess<ContinuousRating>) {
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
    if (result is DataSuccess<AddContinuousRatingData>) {
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

  Future<void> getContinuousRatingStudent(int rateId) async {
    isLoadnigGetRateStudent.value = true;
    final DataState result =
        await continuousRatingRepo.getContinuousRateStudent(
            getContinuousRateStudent: GetContinuousRateStudent(),
            rateId: rateId);
    ratingStudentList.clear();
    isLoadnigGetRateStudent.value = false;
    if (result is DataSuccess<GetContinuousRateStudent>) {
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
      studentId: '1',
      subjectId: honorBoardController.selectedSubjectId.value,
    );
    print('mkkkkkkkkkkkkk');
    print(honorBoardController.selectedSubjectId.value);
    print('mkkkkkkkkkkkkk');
    final DataState result =
        await continuousRatingRepo.addContinuousRateStudent(
            addContinuousRateStudent: addContinuousRatingStudent);
    isLoadnigAddRateStudent.value = false;
    if (result is DataSuccess<GetAddContinuousRateStudent>) {
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
    if (result is DataSuccess<UpdateContinuousRateData>) {
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
    if (result is DataSuccess<ContinuousRating>) {
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
    if (result is DataSuccess<GetContinuousRateStudent>) {
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
    //honorBoardController.getClassSubjectStudent();
    getSubjects();
    getContinuousRating();
    rateController = TextEditingController();
    pointController = TextEditingController();
    super.onInit();
  }
}
