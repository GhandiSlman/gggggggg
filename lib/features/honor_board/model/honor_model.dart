import 'package:lms/features/teacher/model/coninuous_rating_student.dart';
import 'package:lms/features/teacher/model/section_and_subjects.dart';

class HonorsModel {
  List<Honor> honors;
  HonorsModel({required this.honors});

  factory HonorsModel.fromJson(Map<String, dynamic> json) => HonorsModel(
      honors:
          (json['honor_board'] as List).map((x) => Honor.fromJson(x)).toList());
}

class Honor {
  final int id;
  final int teacherId;
  final int subjectId;
  final String title;
  final Subject subject;
  final List<Student>? students;
  Honor({
    required this.id,
    required this.teacherId,
    required this.subjectId,
    required this.title,
    required this.subject,
    required this.students,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'teacherId': teacherId,
      'subjectId': subjectId,
      'title': title,
      'subject': subject.toJson(),
      'students': students?.map((x) => x.toJson()).toList(),
    };
  }

  factory Honor.fromJson(Map<String, dynamic> json, {bool isResonse = false}) {
    Map<String, dynamic> map;
    if (isResonse) {
      map = json['honor_board'];
    } else {
      map = json;
    }
    return Honor(
      id: map['id'] as int,
      teacherId: map['teacher_id'] as int,
      subjectId: map['subject_id'] as int,
      title: map['title'] as String,
      subject: Subject.fromJson(map['subject'] as Map<String, dynamic>),
      students: List<Student>.from(
        (map['students'] as List<dynamic>).map(
          (x) => Student.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
