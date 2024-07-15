import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/data/continuous_rating_repo.dart';
import 'package:lms/features/teacher/model/add_continuous_rate.dart';
import 'package:lms/features/teacher/model/add_continuous_rate_student.dart';
import 'package:lms/features/teacher/model/coninuous_rating_student.dart';
import 'package:lms/features/teacher/model/continuous_rating.dart';
import 'package:lms/features/teacher/model/update_continuous_rate.dart';

class ContinuousRatingRepoImp implements ContinuousRatingRepo {
  final DataService _dataService;
  ContinuousRatingRepoImp(this._dataService);
  @override
  Future<DataState> getContinuousRating(
      {required ContinuousRating continuousRating}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/reinforcement-xp/index',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => ContinuousRating.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> addContinuousRate(
      {required AddContinuousRating addContinuousRating}) async {
    final response = await _dataService.postData(
        endPoint: 'teacher/reinforcement-xp/store',
        data: addContinuousRating,
        baseUrl: baseUrl,
        fromJson: AddContinuousRatingData.fromJson);
    return response;
  }

  @override
  Future<DataState> getContinuousRateStudent(
      {required GetContinuousRateStudent getContinuousRateStudent,
      required int rateId}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/reinforcement-xp-student/index/$rateId',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) =>
          GetContinuousRateStudent.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> addContinuousRateStudent(
      {required AddContinuousRateStudent addContinuousRateStudent}) async {
    final response = await _dataService.postData(
        endPoint: 'teacher/reinforcement-xp-student/store',
        data: addContinuousRateStudent,
        baseUrl: baseUrl,
        fromJson: GetAddContinuousRateStudent.fromJson);
    return response;
  }

  @override
  Future<DataState> updateContinuousRateStudent(
      {required UpdateContinuousRate updateContinuousRate,
      required int id}) async {
    final response = await _dataService.postData(
        endPoint: 'teacher/reinforcement-xp/update/$id',
        data: updateContinuousRate,
        baseUrl: baseUrl,
        fromJson: UpdateContinuousRateData.fromJson);
    return response;
  }

  @override
  Future<DataState> deleteContinuousRate({required int id}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/reinforcement-xp/delete/$id',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => ContinuousRating.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> deleteContinuousRateStudent({required int id}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/reinforcement-xp/delete/$id',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) =>
          GetContinuousRateStudent.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState<StudentAttendance>> getSubjects(
      {required StudentAttendance studentAttendance}) async {
    final DataState<StudentAttendance> response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/studentAttendance/create'
          : 'stages',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => StudentAttendance.fromJson(json),
    );
    return response;
  }
}
