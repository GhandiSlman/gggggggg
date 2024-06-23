import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/teacher/model/get_class_schedule.dart';

abstract class ClassScheduleRepo{
  Future<DataState> getClassSchedule({required GetClassSchedule classSchedule});
}