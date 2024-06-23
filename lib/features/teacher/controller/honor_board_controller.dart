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
import 'package:lms/features/teacher/data/honor_board_repo.dart';
import 'package:lms/features/teacher/model/honor_board.dart';
import 'package:lms/features/teacher/model/student_honor_board.dart';

class HonorBoardController extends GetxController {
  HonorBoardRepo honorBoardRepo;

  HonorBoardController(this.honorBoardRepo);

  bool isUpdateHonorBoard = false;
  RxBool isLoading = false.obs;
  RxBool isAdding = false.obs;
  RxBool isGetHonor = false.obs;
  RxBool isLoadingStudentH = false.obs;
  late final TextEditingController titleController;
  late final TextEditingController classController;
  late final TextEditingController classControllerAdd;
  late final TextEditingController subjectController;

  RxList<GetHonorBoardModel> honorBoardList = <GetHonorBoardModel>[].obs;
  RxList<GetHonorBoardModel> filteredHonorBoardList =
      <GetHonorBoardModel>[].obs;

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
  var showStudentList = <SelectedListItem>[].obs;
  Map<String, List<Students>> studentList = <String, List<Students>>{};
  RxList<String> selectedStudents = <String>[].obs;
  RxList<TextEditingController> studentDropDownControllers =
      <TextEditingController>[].obs;

  //honor board
  RxList<HonorBoardStudent> honorBoardStudentList = <HonorBoardStudent>[].obs;
  Future<void> addHonorBoard() async {
    isAdding.value = true;
    List<String> studentIds = selectedStudents
        .map((name) {
          var student = studentList[selectedClass.first]?.firstWhere(
            (student) => student.name == name,
          );
          return student?.id.toString() ?? '';
        })
        .where((id) => id.isNotEmpty)
        .toList();

    final createHonorBoardModel = CreateHonorBoardModel(
      title: titleController.text,
      subjectId: selectedSubjectId.value,
      studentIds: studentIds,
    );
    final DataState result = await honorBoardRepo.addHonorBoard(
        createHonorBoardModel: createHonorBoardModel);
    isAdding.value = false;
    if (result is DataSuccess) {
      titleController.clear();
      CustomToast.showToast(
        message: 'Honor board added successfully',
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    } else if (result is DataFailed) {
      isAdding.value = false;
      CustomToast.showToast(
        message: 'Failed to add honor board',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  void updateSelectedSubjectId(String subjectId) {
    selectedSubjectId.value = subjectId;
  }

  Future<void> getClassSubjectStudent() async {
    isLoading.value = true;

    final result = await honorBoardRepo.getClassSubjectStudent(
        studentAttendance: StudentAttendance());

    isLoading.value = false;

    if (result is DataSuccess<StudentAttendance>) {
      var attendance = result.data!;
      classList.clear();
      showClassList.clear();
      subjectList.clear();
      showSubjectList.clear();
      studentList.clear();
      showStudentList.clear();

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          String className =
              box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!;
          showClassList.add(SelectedListItem(name: className));

          classList[className] = [];
          for (var section in grade.sections!) {
            classList[className]!.addAll(section.students!);
            for (var sectionSubject in section.sectionSubjects!) {
              String subjectName = box.read('langCode') == 'ar'
                  ? sectionSubject.subject!.name!.ar!
                  : sectionSubject.subject!.name!.en!;
              showSubjectList.add(SelectedListItem(name: subjectName));
              subjectToIdMap[subjectName] =
                  sectionSubject.subject!.id!.toString();
              for (var student in section.students!) {
                if (!studentList.containsKey(className)) {
                  studentList[className] = [];
                }
                studentList[className]!.add(student);
              }
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

  void updateSelectedClass(String className) {
    selectedClass.value = [className];
    filterStudentsByClass(className);
    getHonorBoardByClass();
  }

  void updateSelectedSubject(String subjectName) {
    selectedSubject.value = [subjectName];
    if (subjectToIdMap.containsKey(subjectName)) {
      updateSelectedSubjectId(subjectToIdMap[subjectName]!);
    }
  }

  void filterStudentsByClass(String className) {
    showStudentList.value = studentList[className]?.map((student) {
          return SelectedListItem(name: student.name!);
        }).toList() ??
        [];
  }

  void updateSelectedStudent(String studentName, int index) {
    // Ensure the student is added to the selected list
    if (selectedStudents.length > index) {
      selectedStudents[index] = studentName;
    } else {
      selectedStudents.add(studentName);
    }
    studentDropDownControllers[index].text = studentName;
  }

  void addStudentDropDown() {
    if (selectedStudents.length < showStudentList.length) {
      studentDropDownControllers.add(TextEditingController());
    } else {
      CustomToast.showToast(
        message: 'All students are already selected',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  void filterHonorBoardsByClass(String className) {
    filteredHonorBoardList.value = honorBoardList.where((honorBoard) {
      return honorBoard.data!.any((honorBoardData) {
        return honorBoardData.name!.ar! == className ||
            honorBoardData.name!.en! == className;
      });
    }).toList();
  }

  Future<void> getHonorBoardByClass() async {
    if (selectedClass.isEmpty) {
      return;
    }

    isGetHonor.value = true;
    final result = await honorBoardRepo.getHonorBoard(
        getHonorBoardModel: GetHonorBoardModel());
    isGetHonor.value = false;
    if (result is DataSuccess) {
      honorBoardList.clear();
      honorBoardList.add(result.data);
      filterHonorBoardsByClass(selectedClass.first);
    } else {
      CustomToast.showToast(
        message: 'Failed to load honor boards',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  Future<void> getStudentHonorBoard(int subjectId) async {
    isLoadingStudentH.value = true;
    final result = await honorBoardRepo.getStudentHonorBoard(
        getStudentHonorBoardModel: GetStudentHonorBoardModel(),
        subjectId: subjectId);
    isLoadingStudentH.value = false;
    if (result is DataSuccess<GetStudentHonorBoardModel>) {
      honorBoardStudentList.clear();
      honorBoardStudentList.addAll(result.data!.honorBoard!);
    } else if (result is DataFailed) {
      isLoadingStudentH.value = false;
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

  @override
  void onInit() {
    titleController = TextEditingController();
    classController = TextEditingController();
    subjectController = TextEditingController();
    classControllerAdd = TextEditingController();
    getClassSubjectStudent();
    // getStudentHonorBoard(1);
    super.onInit();
  }
}
