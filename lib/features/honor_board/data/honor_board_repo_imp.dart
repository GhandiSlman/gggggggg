import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/models/message_model.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/honor_board/data/honor_board_repo.dart';
import 'package:lms/features/honor_board/model/honor_model.dart';

class HonorBoardRepoImp implements HonorBoardRepo {
  final DataService _dataService;
  HonorBoardRepoImp(this._dataService);

  @override
  Future<DataState> deleteHonorBoard({required int honorBoardId}) async {
    return await _dataService.getData(
      endPoint: 'teacher/honorBoard/delete/$honorBoardId',
      baseUrl: baseUrl,
      fromJson: MessageModel.fromJson,
    );
  }

  @override
  Future<DataState> getHonorBoardByGrade({required int gradeId}) async {
    String role = box.read('userType') == 'guardian'
        ? 'parent'
        : box.read('userType') ?? '';
    return await _dataService.getData(
      endPoint: '$role/honorBoard/index/$gradeId',
      fromJson: HonorsModel.fromJson,
    );
  }

  @override
  Future<DataState> addHonor({required Honor honor}) async {
    String role = box.read('userType') == 'guardian'
        ? 'parent'
        : box.read('userType') ?? '';
    return await _dataService.getData(
      endPoint: '$role/honorBoard/index/store',
      fromJson: (json) => Honor.fromJson(json, isResonse: true),
    );
  }

  @override
  Future<DataState> updateHonor({required Honor honor}) async {
    String role = box.read('userType') == 'guardian'
        ? 'parent'
        : box.read('userType') ?? '';
    return await _dataService.getData(
      endPoint: '$role/honorBoard/index/update',
      fromJson: (json) => Honor.fromJson(json, isResonse: true),
    );
  }
}
