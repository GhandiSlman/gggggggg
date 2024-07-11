import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/data/week_plane_repo.dart';
import 'package:lms/features/teacher/model/student_info.dart';
import 'package:lms/features/teacher/model/week_plane_model.dart';

class WeekPlaneRepoImp implements WeekPlaneRepo {
  final DataService _dataService;

  WeekPlaneRepoImp(this._dataService);
  @override
  Future<DataState> getWeekPlane(
      {required WeekPlaneModel weekPlaneModel,
      required int sectionId,
      required int subjectId,
      required int pageId}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/weekPlan/index/$sectionId/$subjectId/?page=$pageId'
          : 'student/weekPlan/index/$subjectId/?page=$pageId',
      baseUrl: baseUrl,
      queryParameters: {'page ': '$pageId'},
      fromJson: (json) => WeekPlaneModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getSections(
      {required StudentAttendance studentAttendance}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/studentAttendance/create'
          : 'stages',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => StudentAttendance.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> addWeekPlane(
      {required AddWeekPlaneModel addWeekPlaneModel}) async {
    final response = await _dataService.postData(
        endPoint: 'teacher/weekPlan/store',
        data: addWeekPlaneModel.toJson(),
        baseUrl: baseUrl,
        fromJson: (Map<String, dynamic> json) =>
            WeekPlaneDetails.fromJson(json));
    return response;
  }

  @override
  Future<DataState> deleteWeekPlane({required int weekPlaneId}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/weekPlan/delete/$weekPlaneId',
      baseUrl: baseUrl,
      fromJson: (json) => WeekPlaneModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> updateWeekPlane(
      {required WeekPlan updateWeekPlaneModel}) async {
    final response = await _dataService.postData(
      endPoint: 'teacher/weekPlan/update',
      data: updateWeekPlaneModel.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => WeekPlan.fromJson(json),
    );

    return response;
  }

  @override
  Future<DataState> getStudentInfo({required StudentInfo studentInfo}) async {
    final response = await _dataService.getData(
      endPoint: 'student/info',
      baseUrl: baseUrl,
      fromJson: StudentInfo.fromJson,
    );
    return response;
  }
}
