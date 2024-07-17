import 'package:lms/features/chat/models/contact_model.dart';

class TeacherContactsModel {
  final List<ContactModel> chattedSupervisors;
  final List<ContactModel> supervisors;
  final List<ContactModel> chattedGuardians;
  final List<ContactModel> guardians;

  TeacherContactsModel({
    required this.chattedSupervisors,
    required this.supervisors,
    required this.chattedGuardians,
    required this.guardians,
  });

  factory TeacherContactsModel.fromJson(json) {
    return TeacherContactsModel(
      chattedSupervisors: (json['chatted supervisor'] as List)
          .map((i) => ContactModel.fromJson(i))
          .toList(),
      supervisors: (json['supervisor'] as List)
          .map((i) => ContactModel.fromJson(i))
          .toList(),
      chattedGuardians: (json['chatted guardian'] as List)
          .map((i) => ContactModel.fromJson(i))
          .toList(),
      guardians: (json['guardian'] as List)
          .map((i) => ContactModel.fromJson(i))
          .toList(),
    );
  }
}
