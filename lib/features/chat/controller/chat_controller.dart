import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/chat/data/chat_repo.dart';
import 'package:lms/features/chat/models/conversation_model.dart';
import 'package:lms/features/chat/models/send_message_model.dart';
import 'package:lms/features/chat/models/contacts_list_model.dart';
import 'package:lms/features/teacher/controller/teacher_controller.dart';

class ChatController extends GetxController {
  final ChatRepo chatRepo;
  ChatController(this.chatRepo);
  final ScrollController scrollController = ScrollController();

  ContactsListModel? contactsModel;
  RxBool getContactsIsLoading = false.obs;
  Future<void> getContacts() async {
    getContactsIsLoading.value = true;
    final dataState = await chatRepo.getContacts();
    if (dataState is DataSuccess) {
      contactsModel = dataState.data;
    } else {
      CustomToast.customErrorToast(dataState.errorMessage.toString());
    }
    getContactsIsLoading.value = false;
  }

  int currentRecieverId = -1;
  RxList<Message> messages = RxList.empty(growable: true);
  RxBool getConversationsIsLoading = false.obs;
  Future<void> getConversations(int receiverId) async {
    currentRecieverId = receiverId;
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
      message: sendMessageModel.message,
      isSending: true,
    ));
    textController.clear();
    Get.find<TeacherController>().isTyping.value = false;
    final dataState = await chatRepo.sendMessage(sendMessageModel);
    if (dataState is DataSuccess<Message>) {
      Message message = messages.removeLast();
      message.image = dataState.data!.image;
      message.isSending = false;
      messages.add(message);
    } else {
      messages.removeLast();
      CustomToast.customErrorToast(dataState.errorMessage.toString());
    }
  }

  void receiveMessage(RemoteMessage message) {
    Map<String, dynamic> map = jsonDecode(message.notification?.body ?? '');
    if (currentRecieverId == map['sender_id']) {
      messages.add(Message.fromJson(map));
    } else {
      Get.snackbar(message.notification?.title ?? '', map['message']);
    }
  }
}
