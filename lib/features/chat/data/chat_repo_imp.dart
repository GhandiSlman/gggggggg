import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/chat/models/teacher_contacts_model.dart';
import 'chat_repo.dart';

class ChatRepoImp implements ChatRepo {
  final DataService _dataService;

  ChatRepoImp(this._dataService);

  @override
  Future<DataState<TeacherContactsModel>> getContacts() async {
    return await _dataService.getData(
      endPoint: 'chat/users',
      baseUrl: baseUrl,
      fromJson: TeacherContactsModel.fromJson,
    );
  }
}
