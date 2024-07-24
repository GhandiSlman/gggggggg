import 'package:lms/features/chat/models/contact_model.dart';

class ContactsListModel {
  final List<ContactModel>? supervisors;
  final List<ContactModel>? guardians;
  final List<ContactModel>? students;
  final List<ContactModel>? teachers;

  ContactsListModel({
    required this.supervisors,
    required this.students,
    required this.teachers,
    required this.guardians,
  });

  factory ContactsListModel.fromJson(json) {
    ContactsListModel model = ContactsListModel(
      supervisors: (json['chatted supervisor'] as List?)
          ?.map((i) => ContactModel.fromJson(i))
          .toList(),
      guardians: (json['chatted guardian'] as List?)
          ?.map((i) => ContactModel.fromJson(i))
          .toList(),
      students: (json['chatted student'] as List?)
          ?.map((i) => ContactModel.fromJson(i))
          .toList(),
      teachers: (json['chatted teacher'] as List?)
          ?.map((i) => ContactModel.fromJson(i))
          .toList(),
    );

    model.supervisors?.addAll(((json['supervisor'] as List?) ?? [])
        .map((i) => ContactModel.fromJson(i))
        .toList());

    model.guardians?.addAll(((json['guardian'] as List?) ?? [])
        .map((i) => ContactModel.fromJson(i))
        .toList());
    model.students?.addAll(((json['student'] as List?) ?? [])
        .map((i) => ContactModel.fromJson(i))
        .toList());
    model.teachers?.addAll(((json['teacher'] as List?) ?? [])
        .map((i) => ContactModel.fromJson(i))
        .toList());
    return model;
  }
}
