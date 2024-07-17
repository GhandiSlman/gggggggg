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
import 'package:lms/features/supervisor/controller/student_status_controller.dart';
import 'package:lms/features/honor_board/data/honor_board_repo.dart';
import 'package:lms/features/honor_board/model/honor_board.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';
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
  StudentStatusController studentStatusController = Get.find();

  RxList<HonorBoard> honorBoardList = <HonorBoard>[].obs;
  RxList<GetHonorBoardModel> filteredHonorBoardList = <GetHonorBoardModel>[].obs;

  // Class
  var showClassList = <SelectedListItem>[].obs;
  Map<String, List<Students>> classList = <String, List<Students>>{};
  RxList<String> selectedClass = <String>[].obs;

  // Subject
  var showSubjectList = <SelectedListItem>[].obs;
  RxList<Subjects> selectedSubjects = <Subjects>[].obs;
  RxString selectedSubjectId = ''.obs;
  var subjectToIdMap = <String, String>{}.obs;

  // Students
  var showStudentList = <SelectedListItem>[].obs;
  Map<String, List<Students>> studentList = <String, List<Students>>{};
  RxList<String> selectedStudents = <String>[].obs;
  RxString selectedStudentIdRate = ''.obs;
  RxList<TextEditingController> studentDropDownControllers = <TextEditingController>[].obs;
  var studentToIdMap = <String, String>{}.obs;

  // Honor board
  RxList<HonorBoardStudent> honorBoardStudentList = <HonorBoardStudent>[].obs;

  void updateSelectedSubjectId(String subjectId) {
    selectedSubjectId.value = subjectId;
  }

  void updateSelectedStudentRateId(String studentId) {
    selectedStudentIdRate.value = studentId;
  }

  void updateSelectedStudentRate(String studentName) {
    selectedStudents.value = [studentName];
    if (studentToIdMap.containsKey(studentName)) {
      updateSelectedSubjectId(studentToIdMap[studentName]!);
    }
  }

  void updateSelectedClass(String className) {
    selectedClass.value = [className];
    selectedSubjects.clear();
    final selectedGrade = honorBoardList.firstWhere((grade) {
      return (box.read('langCode') == 'ar' ? grade.name!.ar! : grade.name!.en!) == className;
    }, );

    if (selectedGrade.subjects != null) {
      selectedSubjects.addAll(selectedGrade.subjects!);
    }
     filterStudentsByClass(className);
  }

  void updateSelectedSubject(String subjectName) {
    selectedClass.value = [subjectName];
    if (subjectToIdMap.containsKey(subjectName)) {
      updateSelectedSubjectId(subjectToIdMap[subjectName]!);
    }
  }

  void filterStudentsByClass(String className) {
    showStudentList.value = studentList[className]?.map((student) {
      return SelectedListItem(name: student.name!);
    }).toList() ?? [];
  }

  void updateSelectedStudent(String studentName, int index) {
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

  Future<void> getHonorBoardByClass() async {
    isGetHonor.value = true;
    final result = await honorBoardRepo.getHonorBoard(getHonorBoardModel: GetHonorBoardModel());
    isGetHonor.value = false;
    if (result is DataSuccess) {
      honorBoardList.clear();
      honorBoardList.addAll(result.data!.data!);
      showClassList.clear();
      for (var honorBoard in honorBoardList) {
        showClassList.add(
          SelectedListItem(name: box.read('langCode') == 'ar' ? honorBoard.name!.ar! : honorBoard.name!.en!),
        );
      }
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
    final result = await honorBoardRepo.getStudentHonorBoard(getStudentHonorBoardModel: GetStudentHonorBoardModel(), subjectId: subjectId);
    isLoadingStudentH.value = false;
    if (result is DataSuccess) {
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
    final result = await honorBoardRepo.deleteHonorBoard(honorBoardId: honorBoardId);
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

    getHonorBoardByClass();

    super.onInit();
  }
}
