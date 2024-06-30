import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/data/activity_repo.dart';
import 'package:lms/features/teacher/model/activity.dart';
import 'package:lms/features/teacher/model/update_activity.dart';

class ActivityRepoImp implements ActivityRepo {
  final DataService _dataService;

  ActivityRepoImp(this._dataService);
  @override
  Future<DataState> addActivity(
      {required CreateActivityModel createActivityModel}) async {
    final response = await _dataService.postData(
      endPoint: 'teacher/activity/store',
      data: createActivityModel.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => Activity.fromJson(json),
    );

    return response;
  }

  @override
  Future<DataState> getSections(
      {required StudentAttendance studentAttendance}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/studentAttendance/create',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => StudentAttendance.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getActivity(
      {required GetActivity getActivity, String? sectionId}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/activity/index/$sectionId'
          : box.read('userType') == 'supervisor'
              ? 'supervisor/activity/index'
              : box.read('userType') == 'student'
                  ? 'student/activity/index'
                  : '',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => GetActivity.fromJson(json),
    );
    return response;
  }

   @override
  Future<DataState> getActivitySuper({
    required GetActivity getActivity,
  }) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'supervisor'
          ? 'supervisor/activity/index'
          : 'student/activity/index',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => GetActivity.fromJson(json),
    );

    return response;
  }

  @override
  Future<DataState> updateActivity(
      {required UpdateActivityModel createActivityModel}) async {
    final response = await _dataService.postData(
      endPoint: 'teacher/activity/update',
      data: createActivityModel.toJson(),
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => UpdateActivity.fromJson(json),
    );

    return response;
  }

  @override
  Future<DataState> deleteActivity({required int activityId}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/activity/delete/$activityId',
      baseUrl: baseUrl,
      fromJson: (json) => GetActivity.fromJson(json),
    );
    return response;
  }
}
