import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/honor_board/model/honor_board.dart';
import 'package:lms/features/teacher/model/student_honor_board.dart';

abstract class HonorBoardRepo {
  Future<DataState> addHonorBoard(
      {required CreateHonorBoardModel createHonorBoardModel});
  Future<DataState> getClassSubjectStudent(
      {required StudentAttendance studentAttendance});
  Future<DataState> getHonorBoard(
      {required GetHonorBoardModel getHonorBoardModel});

  Future<DataState> deleteHonorBoard({required int honorBoardId});

  Future<DataState> getStudentHonorBoard(
      {required GetStudentHonorBoardModel getStudentHonorBoardModel ,required int subjectId});
}
