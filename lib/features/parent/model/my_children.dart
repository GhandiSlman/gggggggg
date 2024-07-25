import 'package:lms/features/students/model/student_attendance.dart';

class MyChildren {
  final bool status;
  final ParentDataModel data;

  MyChildren({
    required this.status,
    required this.data,
  });

  factory MyChildren.fromJson(Map<String, dynamic> json) {
    return MyChildren(
      status: json['status'],
      data: ParentDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class ParentDataModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final List<SonModel> children;

  ParentDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.children,
  });

  factory ParentDataModel.fromJson(Map<String, dynamic> json) {
    return ParentDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      children: (json['children'] as List)
          .map((child) => SonModel.fromJson(child))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }
}

class SonModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final int totalXp;
  final List<Subject> subjects;

  SonModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.totalXp,
    required this.subjects,
  });

  factory SonModel.fromJson(Map<String, dynamic> json) {
    return SonModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      totalXp: int.parse(json['total_xp'].toString()),
      subjects: (json['subjects'] as List)
          .map((subject) => Subject.fromJson(subject))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'total_xp': totalXp,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }
}

class Subject {
  final int id;
  final Name name;
  final int gradeId;

  Subject({
    required this.id,
    required this.name,
    required this.gradeId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: Name.fromJson(json['name']),
      gradeId: json['grade_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'grade_id': gradeId,
    };
  }
}
