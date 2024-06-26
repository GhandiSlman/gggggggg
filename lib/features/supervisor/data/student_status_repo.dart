import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/supervisor/model/student_attendance_status.dart';

abstract class StudentStatusRepo {
  Future<DataState> getSectionSubject(StudentAttendance studentAttendance);
  Future<DataState> getStudentStatus({required StudentAttendanceStatus studentAttendanceStatus ,required int sectoinId,required int subjectId});
}
