import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/data/student_repo.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/students/model/student_status.dart';

class StudentRepoImp implements StudentRepo {
  final DataService _dataService;

  StudentRepoImp(this._dataService);
  @override
  Future<DataState> getClasses(StudentAttendance studentAttendance) async {
    final response = await _dataService.getData(
      endPoint:  box.read('teacher') == 'teacher' ?'teacher/studentAttendance/create'  :'stages',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => StudentAttendance.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> studentStatusSend(
      {required StudentStatus studentAttendance}) async {
    try {
      final response = await _dataService.postData(
          endPoint: 'teacher/studentAttendance/store',
          data: studentAttendance.toJson(),
          baseUrl: baseUrl,
          fromJson: (Map<String, dynamic> json) =>
              GetStudentStatus.fromJson(json));
      return response;
    } catch (e) {
      final response = await _dataService.postData(
          endPoint: 'teacher/studentAttendance/store',
          data: studentAttendance.toJson(),
          baseUrl: baseUrl,
          fromJson: (Map<String, dynamic> json) =>
              StudentStatus.fromJson(json));
      return response;
    }
  }
}
