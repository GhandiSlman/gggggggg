import 'package:lms/features/teacher/model/coninuous_rating_student.dart';

class StudentsModel {
  List<Student> students;
  StudentsModel({required this.students});

  factory StudentsModel.fromJson(Map<String, dynamic> json) => StudentsModel(
      students:
          (json['students'] as List).map((x) => Student.fromJson(x)).toList());
}
