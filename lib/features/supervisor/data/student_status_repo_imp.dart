import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/supervisor/data/student_status_repo.dart';
import 'package:lms/features/supervisor/model/student_attendance_status.dart';

class StudentStatusRepoImp implements StudentStatusRepo {
  final DataService _dataService;
  StudentStatusRepoImp(this._dataService);

  @override
  Future<DataState> getStudentStatus(
      {required StudentAttendanceStatus studentAttendanceStatus,
      required int sectoinId,
      required int subjectId}) {
    final response = _dataService.getData(
        endPoint: 'supervisor/studentAttendance/index/$subjectId/$sectoinId',
        baseUrl: baseUrl,
        fromJson: (Map<String, dynamic> json) =>
            StudentAttendanceStatus.fromJson(json));
    return response;
  }

  @override
  Future<DataState> getSectionSubject(
      StudentAttendance studentAttendance) async {
    final response = await _dataService.getData(
      endPoint: 'stages',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => StudentAttendance.fromJson(json),
    );
    return response;
  }
}
