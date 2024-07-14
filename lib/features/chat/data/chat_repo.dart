import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/chat/models/conversation_model.dart';
import 'package:lms/features/chat/models/send_message_model.dart';
import 'package:lms/features/chat/models/teacher_contacts_model.dart';

abstract class ChatRepo {
  ChatRepo(find);

  Future<DataState<TeacherContactsModel>> getContacts();

  Future<DataState<ConversationModel>> getConversations(int receiverId);

  Future<DataState<Message>> sendMessage(SendMessageModel sendMessageModel);
}
