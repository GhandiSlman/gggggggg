import 'package:lms/features/chat/models/contact_model.dart';

class TeacherContactsModel {
  final List<ContactModel> supervisors;
  final List<ContactModel> guardians;

  TeacherContactsModel({
    required this.supervisors,
    required this.guardians,
  });

  factory TeacherContactsModel.fromJson(json) {
    TeacherContactsModel model = TeacherContactsModel(
      supervisors: (json['chatted supervisor'] as List)
          .map((i) => ContactModel.fromJson(i))
          .toList(),
      guardians: (json['chatted guardian'] as List)
          .map((i) => ContactModel.fromJson(i))
          .toList(),
    );
    model.supervisors.addAll((json['supervisor'] as List)
        .map((i) => ContactModel.fromJson(i))
        .toList());
    model.guardians.addAll((json['guardian'] as List)
        .map((i) => ContactModel.fromJson(i))
        .toList());
    return model;
  }
}
