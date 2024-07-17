import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/chat/models/teacher_contacts_model.dart';

abstract class ChatRepo {
  Future<DataState<TeacherContactsModel>> getContacts();
}
