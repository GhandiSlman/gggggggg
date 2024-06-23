import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/model/activity.dart';
import 'package:lms/features/teacher/model/test_activity.dart';
import 'package:lms/features/teacher/model/update_activity.dart';

abstract class ActivityRepo {
  Future<DataState> addActivity(
      {required CreateActivityModel createActivityModel});
  Future<DataState> getSections({required StudentAttendance studentAttendance});
  Future<DataState> getActivity({required GetActivity getActivity,  String sectionId });
   Future<DataState> updateActivity(
      {required UpdateActivityModel createActivityModel});
      Future<DataState> deleteActivity({required int activityId});
Future<DataState> getActivitySuper({required GetActivityIndex getActivity});
}
