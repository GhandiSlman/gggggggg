import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/parent/data/parent_repo.dart';
import 'package:lms/features/parent/model/my_children.dart';

class ParentRepoImp implements ParentRepo {
  final DataService _dataService;
  ParentRepoImp(this._dataService);

  @override
  Future<DataState> getMyChildren() async {
    final response = await _dataService.getData(
        endPoint: 'parent/children/index',
        baseUrl: baseUrl,
        fromJson: (Map<String, dynamic> json) => MyChildren.fromJson(json));
    return response;
  }

  @override
  Future<DataState> getSonSubjectAttendence(
      {required int studentId, required int subjectId}) async {
    final response = await _dataService.getData(
        endPoint: 'parent/children/index/$subjectId/$studentId',
        baseUrl: baseUrl,
        fromJson: (Map<String, dynamic> json) => MyChildren.fromJson(json));
    return response;
  }
}
