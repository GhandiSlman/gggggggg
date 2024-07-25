import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/parent/model/my_children.dart';

abstract class ParentRepo {
  Future<DataState> getMyChildren();
  Future<DataState> getSonSubjectAttendence(
      {required int studentId, required int subjectId});
}
