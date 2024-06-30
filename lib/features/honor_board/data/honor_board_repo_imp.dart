import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/model/student_attendance.dart';
import 'package:lms/features/honor_board/data/honor_board_repo.dart';
import 'package:lms/features/honor_board/model/honor_board.dart';
import 'package:lms/features/teacher/model/student_honor_board.dart';

class HonorBoardRepoImp implements HonorBoardRepo {
  final DataService _dataService;
  HonorBoardRepoImp(this._dataService);

  @override
  Future<DataState> addHonorBoard(
      {required CreateHonorBoardModel createHonorBoardModel}) async {
    final DataState response = await _dataService.postData(
        endPoint: 'teacher/honorBoard/store',
        data: createHonorBoardModel.toJson(),
        baseUrl: baseUrl,
        fromJson: (Map<String, dynamic> json) =>
            GetHonorBoardModel.fromJson(json));

    return response;
  }

  @override
  Future<DataState> getClassSubjectStudent(
      {required StudentAttendance studentAttendance}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher '  ? 'teacher/studentAttendance/create' : 'stages' ,
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => StudentAttendance.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getHonorBoard(
      {required GetHonorBoardModel getHonorBoardModel}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'? 'teacher/honorBoard/create' : box.read('userType') =='guardian'? 'parent/honorBoard/create' : box.read('userType')=='student'? 'student/honorBoard/create' : '',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) =>
          GetHonorBoardModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> deleteHonorBoard({required int honorBoardId}) async {
    final response = await _dataService.getData(
      endPoint: 'teacher/honorBoard/delete/$honorBoardId',
      baseUrl: baseUrl,
      fromJson: (json) => HonorBoard.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> getStudentHonorBoard(
      {required GetStudentHonorBoardModel getStudentHonorBoardModel,
      required int subjectId}) async {
    final response = await _dataService.getData(
      endPoint: box.read('userType') == 'teacher'
          ?  'teacher/honorBoard/index/$subjectId'
          : box.read('userType') == 'guardian'? 'parent/honorBoard/index/$subjectId'  :'student/honorBoard/index/$subjectId',
      baseUrl: baseUrl,
      fromJson: (json) => GetStudentHonorBoardModel.fromJson(json),
    );
    return response;
  }
}
