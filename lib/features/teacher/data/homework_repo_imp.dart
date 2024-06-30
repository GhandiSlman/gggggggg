import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/teacher/data/homework_repo.dart';
import 'package:lms/features/teacher/model/add_home_work.dart';
import 'package:lms/features/teacher/model/create_details_homework.dart';
import 'package:lms/features/teacher/model/get_homework_model.dart';

class HomeWorkRepoImp implements HomeWorkRepo {
  final DataService _dataService;

  HomeWorkRepoImp(this._dataService);

  @override
  Future<DataState> getSubjects(
      {required CreateDetailsHomeWork createDetailsHomeWork}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') =='teacher' ? 'teacher/homework/create' : 'stages',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) =>
          CreateDetailsHomeWork.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> addHomeWork({required Homework sectionSubjects}) async {
    final response = await _dataService.postData(
        endPoint: 'teacher/homework/store',
        data: sectionSubjects,
        baseUrl: baseUrl,
        fromJson: SectionSubjects.fromJson);
    return response;
  }

  @override
  Future<DataState> updateHomeWork({required Homework homework}) async {
    final response = await _dataService.postData(
        endPoint: 'teacher/homework/update',
        data: homework,
        baseUrl: baseUrl,
        fromJson: SectionSubjects.fromJson);
    return response;
  }

  @override
  Future<DataState> getHomeWork(
      {required GetHomeWorkModel getHomeWorkModel,
      required int sectionId,
      required int subjectId}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'
          ? 'teacher/homework/index/$sectionId/$subjectId'
          : 'student/homework/index/$subjectId',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => GetHomeWorkModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> deleteHomeWork({required int homeWorkId}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/homework/delete/$homeWorkId',
      baseUrl: baseUrl,
      fromJson: (json) => GetHomeWorkModel.fromJson(json),
    );
    return response;
  }
}
