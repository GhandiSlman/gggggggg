import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/students/model/class_schedual.dart';
import 'package:lms/features/teacher/data/class_schedule_repo.dart';
import 'package:lms/features/teacher/model/get_class_schedule.dart';

class ClassScheduleController extends GetxController {
  RxBool isLoading = false.obs;
  ClassScheduleRepo classScheduleRepo;

  ClassScheduleController(this.classScheduleRepo);

  RxList<Schedule> schedule = <Schedule>[].obs;
  RxMap<String, List<Schedule>> scheduleByDay = <String, List<Schedule>>{}.obs;
  RxList<Schedule> filteredSchedule = <Schedule>[].obs;
  RxString selectedDay = ''.obs;

  Future<void> getClassSchedule() async {
    isLoading.value = true;
    final DataState result = await classScheduleRepo.getClassSchedule(
        classSchedule: GetClassSchedule());

    if (result is DataSuccess) {
      isLoading.value = false;
      if (result.data?.classScheduleByDay != null) {
        scheduleByDay.addAll(result.data!.classScheduleByDay!);
      } else {
        isLoading.value = false;
        CustomToast.showToast(
          message: 'No class schedule found.',
          backgroundColor: AppColor.redColor,
          fontSize: 15.sp,
          gravity: ToastGravity.BOTTOM,
          isLongDuration: false,
          textColor: AppColor.whiteColor,
        );
      }
    } else if (result is DataFailed<GetClassSchedule>) {
      isLoading.value = false;
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

  void filterScheduleByDay(String day) {
    selectedDay.value = day;
    filteredSchedule.value = scheduleByDay[day] ?? [];
  }

  RxList<ScheduleData> scheduleStudent = <ScheduleData>[].obs;
  RxMap<String, List<ScheduleData>> scheduleByDayStudent =
      <String, List<ScheduleData>>{}.obs;
  RxList<ScheduleData> filteredScheduleStudent = <ScheduleData>[].obs;
  RxString selectedDayStudent = ''.obs;

  Future<void> getClassScheduleStudent() async {
    isLoading.value = true;
    final DataState result = await classScheduleRepo.getClassSchedualStudent(
        classSchedule: ClassSchedule());

    if (result is DataSuccess) {
      isLoading.value = false;
      if (result.data?.classScheduleByDay != null) {
        scheduleByDayStudent.addAll(result.data!.classScheduleByDay!);
      } else {
        isLoading.value = false;
        CustomToast.showToast(
          message: 'No class schedule found.',
          backgroundColor: AppColor.redColor,
          fontSize: 15.sp,
          gravity: ToastGravity.BOTTOM,
          isLongDuration: false,
          textColor: AppColor.whiteColor,
        );
      }
    } else if (result is DataFailed<GetClassSchedule>) {
      isLoading.value = false;
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

  void filterScheduleByDayStudent(String day) {
    selectedDayStudent.value = day;
    filteredScheduleStudent.value = scheduleByDayStudent[day] ?? [];
  }

  @override
  void onInit() {
    box.read('userType') == 'teacher'
        ? getClassSchedule()
        : getClassScheduleStudent();
    super.onInit();
  }
}
