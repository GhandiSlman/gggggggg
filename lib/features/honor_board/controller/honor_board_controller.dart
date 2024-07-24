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
import 'package:lms/features/students/data/student_repo.dart';
import 'package:lms/features/students/model/student_attendance.dart';

class HonorBoardController extends GetxController {
  HonorBoardRepo honorBoardRepo;

  HonorBoardController(this.honorBoardRepo);

  RxList<SelectedListItem> gradesDropList = <SelectedListItem>[].obs;
  RxList<SelectedListItem> subjectDropList = <SelectedListItem>[].obs;
  RxList<SelectedListItem> studentDropList = <SelectedListItem>[].obs;
  RxBool isGradesLoading = false.obs;
  RxString selectedGradesId = ''.obs;
  RxString selectedSubjectId = ''.obs;
  RxList<int> selectedStudentsIds = <int>[].obs;
  TextEditingController honorNameTextEditingController =
      TextEditingController();

  Future<void> getGrades() async {
    isGradesLoading.value = true;
    final DataState result =
        await Get.find<StudentRepo>().getClasses(StudentAttendance());

    if (result is DataSuccess) {
      var createSubject = result.data!;
      for (var res in createSubject.result!) {
        for (var grade in res.grades!) {
          String gradeName =
              box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!;
          gradesDropList.add(
              SelectedListItem(name: gradeName, value: grade.id.toString()));
          for (var section in grade.sections!) {
            for (var subject in section.sectionSubjects!) {
              String subjectName = box.read('langCode') == 'ar'
                  ? subject.subject!.name!.ar
                  : subject.subject!.name!.en!;
              subjectDropList.add(SelectedListItem(
                  name: subjectName, value: subject.subject!.id.toString()));
            }
            for (var student in section.students!) {
              studentDropList.add(SelectedListItem(
                  name: student.name!, value: student.id.toString()));
            }
          }
        }
      }
      subjectDropList.value = subjectDropList.toSet().toList();
      studentDropList.value = studentDropList.toSet().toList();
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

  Future<void> deleteHonorBoard(int honorBoardId) async {
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
  }
}
