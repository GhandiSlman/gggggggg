import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/chat/models/conversation_model.dart';
import 'package:lms/features/chat/models/send_message_model.dart';
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

  @override
  Future<DataState<ConversationModel>> getConversations(int receiverId) async {
    return await _dataService.getData(
      endPoint: 'chat/$receiverId',
      baseUrl: baseUrl,
      fromJson: ConversationModel.fromJson,
    );
  }

  @override
  Future<DataState<Message>> sendMessage(
      SendMessageModel sendMessageModel) async {
    return await _dataService.postData(
        endPoint: 'chat/send',
        baseUrl: baseUrl,
        fromJson: Message.sendFromJson,
        data: sendMessageModel.toJson());
  }
}
