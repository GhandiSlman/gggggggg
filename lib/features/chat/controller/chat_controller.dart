import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/chat/data/chat_repo.dart';
import 'package:lms/features/chat/models/teacher_contacts_model.dart';

class ChatController extends GetxController {
  final ChatRepo chatRepo;
  ChatController(this.chatRepo);

  TeacherContactsModel? teacherContactsModel;
  RxBool getContactsIsLoading = false.obs;
  Future<void> getContacts() async {
    getContactsIsLoading.value = true;
    final dataState = await chatRepo.getContacts();
    if (dataState is DataSuccess<TeacherContactsModel>) {
      teacherContactsModel = dataState.data;
    } else {
      CustomToast.customErrorToast(dataState.errorMessage.toString());
    }
    getContactsIsLoading.value = false;
  }
}
