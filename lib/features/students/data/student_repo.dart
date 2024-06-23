import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/students/model/student_status.dart';

abstract class StudentRepo {
  Future<DataState> getClasses(StudentAttendance studentAttendance);
  Future<DataState> studentStatusSend({required StudentStatus studentAttendance});
}
