import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/teacher/model/add_home_work.dart';
import 'package:lms/features/teacher/model/create_details_homework.dart';
import 'package:lms/features/teacher/model/get_homework_model.dart';

abstract class HomeWorkRepo {
  Future<DataState> getSubjects(
      {required CreateDetailsHomeWork createDetailsHomeWork});
  //  Future<DataState> getSectionSubject({required CreateDetailsHomeWork createDetailsHomeWork});
  Future<DataState> addHomeWork({required Homework sectionSubjects});

  Future<DataState> getHomeWork(
      {required GetHomeWorkModel getHomeWorkModel,
      required int sectionId,
      required int subjectId});

  Future<DataState> updateHomeWork({required Homework homework});

  Future<DataState> deleteHomeWork({required int homeWorkId});
}
