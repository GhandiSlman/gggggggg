import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/honor_board/model/honor_model.dart';
import 'package:lms/features/honor_board/data/honor_board_repo.dart';
import 'package:lms/features/honor_board/model/students_model.dart';
import 'package:lms/features/teacher/data/week_plane_repo.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';

class HonorBoardController extends GetxController {
  HonorBoardRepo honorBoardRepo;

  HonorBoardController(this.honorBoardRepo);

  RxList<SelectedListItem> gradesDropList = <SelectedListItem>[].obs;
  // RxList<SelectedListItem> subjectDropList = <SelectedListItem>[].obs;
  RxList<SelectedListItem> studentDropList = <SelectedListItem>[].obs;
  RxList<Subject> allSubjects = <Subject>[].obs;

  RxBool isGradesLoading = false.obs;
  RxString selectedGradesId = ''.obs;
  RxString selectedSubjectId = ''.obs;
  TextEditingController honorNameTextEditingController =
      TextEditingController();

  Future<void> getGrades() async {
    allSubjects.clear();
    isGradesLoading.value = true;
    final DataState result =
        await Get.find<WeekPlaneRepo>().getSectionsAndSubjects();
    if (result is DataSuccess) {
      var createSubject = result.data!;
      for (var res in createSubject.result) {
        for (var grade in res.grades) {
          String gradeName =
              box.read('langCode') == 'ar' ? grade.name.ar : grade.name.en!;
          gradesDropList.add(
              SelectedListItem(name: gradeName, value: grade.id.toString()));
          for (var section in grade.sections) {
            allSubjects.addAll(section.subjects);
          }
        }
      }
      print(allSubjects.map((e) => e.toJson()));
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
    isGradesLoading.value = false;
  }

  RxInt studentsTotalLength = 0.obs;
  RxList<Student> studentsTextFeilds = <Student>[Student()].obs;
  RxBool isGetStudentsBySubjectLoading = false.obs;
  Future<void> getStudentsBySubject({required int subjectId}) async {
    isGetStudentsBySubjectLoading.value = true;
    studentsTextFeilds.value = [Student()];
    final result =
        await honorBoardRepo.getStudentsBySubject(subjectId: subjectId);
    if (result is DataSuccess<StudentsModel>) {
      studentsTotalLength.value = result.data!.students.length;
      studentDropList.value = result.data!.students
          .map((e) =>
              SelectedListItem(name: e.name.toString(), value: e.id.toString()))
          .toList();
    } else {
      CustomToast.customErrorToast('Failed to load students');
    }
    isGetStudentsBySubjectLoading.value = false;
  }

  RxList<Honor> honors = <Honor>[].obs;
  RxBool isGetHonorsLoading = false.obs;

  Future<void> getHonotBoardByGrade({required int gradeId}) async {
    isGetHonorsLoading.value = true;
    final result = await honorBoardRepo.getHonorBoardByGrade(gradeId: gradeId);
    if (result is DataSuccess) {
      honors.value = result.data!.honors;
    } else {
      CustomToast.customErrorToast('Failed to load honor boards');
    }
    isGetHonorsLoading.value = false;
  }

  RxBool isDeleteHonorLoading = false.obs;

  Future<void> deleteHonorBoard(int honorBoardId) async {
    isDeleteHonorLoading.value = true;
    final result =
        await honorBoardRepo.deleteHonorBoard(honorBoardId: honorBoardId);
    if (result is DataSuccess) {
      CustomToast.showToast(
        message: 'Honor board deleted successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
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
    isDeleteHonorLoading.value = false;
  }

  RxBool isAddHonorLoading = false.obs;
  Future<void> addHonorBoard() async {
    isAddHonorLoading.value = true;
    final result = await honorBoardRepo.addHonor(
        honor: Honor(
            subjectId: int.parse(selectedSubjectId.value),
            title: honorNameTextEditingController.text,
            students: studentsTextFeilds));
    if (result is DataSuccess) {
      CustomToast.showToast(
        message: 'Honor board Added successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
      isGradesLoading = false.obs;
      selectedGradesId = ''.obs;
      selectedSubjectId = ''.obs;
      honorNameTextEditingController = TextEditingController();
      studentsTotalLength = 0.obs;
      studentsTextFeilds = <Student>[Student()].obs;
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
    isAddHonorLoading.value = false;
  }

  RxBool isUpdateHonorLoading = false.obs;
  Future<void> updateHonorBoard(int honorId) async {
    isUpdateHonorLoading.value = true;
    final result = await honorBoardRepo.updateHonor(
        honor: Honor(
            id: honorId,
            subjectId: int.parse(selectedSubjectId.value),
            title: honorNameTextEditingController.text,
            students: studentsTextFeilds));
    if (result is DataSuccess) {
      CustomToast.showToast(
        message: 'Honor board Updated successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    } else if (result is DataFailed) {
      CustomToast.customErrorToast(result.errorMessage!);
    }
    isUpdateHonorLoading.value = false;
  }
}
