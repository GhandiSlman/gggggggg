import 'package:lms/features/teacher/model/coninuous_rating_student.dart';

class StudentAttendanceStatus {
  bool? status;
  List<StudentAttendanceStatusData>? data;

  StudentAttendanceStatus({this.status, this.data});

  StudentAttendanceStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StudentAttendanceStatusData>[];
      json['data'].forEach((v) {
        data!.add(StudentAttendanceStatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentAttendanceStatusData {
  int? id;
  int? studentId;
  Student? student;
  int? subjectId;
  String? status;
  String? date;
  String? createdAt;
  String? updatedAt;

  StudentAttendanceStatusData(
      {this.id,
      this.studentId,
      this.subjectId,
      this.status,
      this.date,
      this.createdAt,
      this.student,
      this.updatedAt});

  StudentAttendanceStatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    student = Student.fromJson(json['student']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['subject_id'] = subjectId;
    data['status'] = status;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
