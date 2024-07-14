import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/chat/data/chat_repo.dart';
import 'package:lms/features/chat/models/conversation_model.dart';
import 'package:lms/features/chat/models/send_message_model.dart';
import 'package:lms/features/chat/models/teacher_contacts_model.dart';

class ChatController extends GetxController {
  final ChatRepo chatRepo;
  ChatController(this.chatRepo);

  @override
  onInit() {
    getContacts();
    super.onInit();
  }

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

  RxList<Message> messages = RxList.empty(growable: true);
  RxBool getConversationsIsLoading = false.obs;
  Future<void> getConversations(int receiverId) async {
    getConversationsIsLoading.value = true;
    final dataState = await chatRepo.getConversations(receiverId);
    if (dataState is DataSuccess<ConversationModel>) {
      messages.value = dataState.data!.messages;
    } else {
      CustomToast.customErrorToast(dataState.errorMessage.toString());
    }
    getConversationsIsLoading.value = false;
  }

  TextEditingController textController = TextEditingController();
  Future<void> sendMessage(SendMessageModel sendMessageModel) async {
    messages.add(Message(
        receiverId: sendMessageModel.receiverId,
        message: sendMessageModel.message));
    textController.clear();
    final dataState = await chatRepo.sendMessage(sendMessageModel);
    if (dataState is DataSuccess<Message>) {
    } else {
      CustomToast.customErrorToast(dataState.errorMessage.toString());
    }
  }
}
