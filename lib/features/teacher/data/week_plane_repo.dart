import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/teacher/model/student_info.dart';
import 'package:lms/features/teacher/model/week_plane_model.dart';

abstract class WeekPlaneRepo {
  Future<DataState> getWeekPlane(
      {required WeekPlaneModel weekPlaneModel,
      required int sectionId,
      required int subjectId,
      required int pageId});
  Future<DataState> getSections({required StudentAttendance studentAttendance});
  Future<DataState> addWeekPlane(
      {required AddWeekPlaneModel addWeekPlaneModel});
  Future<DataState> deleteWeekPlane({required int weekPlaneId});

  Future<DataState> updateWeekPlane({required WeekPlan updateWeekPlaneModel});

  Future<DataState> getSectionsAndSubjects();

  Future<DataState> getStudentInfo({required StudentInfo studentInfo});
}
