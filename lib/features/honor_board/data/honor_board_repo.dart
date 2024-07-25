import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/honor_board/model/honor_model.dart';
import 'package:lms/features/honor_board/model/students_model.dart';

abstract class HonorBoardRepo {
  Future<DataState> deleteHonorBoard({required int honorBoardId});
  Future<DataState> getHonorBoardByGrade({required int gradeId});
  Future<DataState> addHonor({required Honor honor});
  Future<DataState> updateHonor({required Honor honor});
  Future<DataState<StudentsModel>> getStudentsBySubject(
      {required int subjectId});
}
