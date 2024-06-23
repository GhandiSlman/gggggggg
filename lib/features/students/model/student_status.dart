class StudentStatus {

  int? studentId;
  int? subjectId;
  String? status;
  String? date;

  StudentStatus({ this.studentId, this.subjectId, this.status, this.date});

  // StudentStatus.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   data = json['data'] != null ? SendingData.fromJson(json['data']) : null;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['subject_id'] = subjectId;
    data['status'] = status;
    data['date'] = date;
    return data;
}
}

class GetStudentStatus {
  int? studentId;
  int? subjectId;
  String? status;
  String? date;
  String? updatedAt;
  String? createdAt;
  int? id;

  GetStudentStatus(
      {this.studentId,
      this.subjectId,
      this.status,
      this.date,
      this.updatedAt,
      this.createdAt,
      this.id});

  GetStudentStatus.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    status = json['status'];
    date = json['date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['student_id'] = studentId;
  //   data['subject_id'] = subjectId;
  //   data['status'] = status;
  //   data['date'] = date;
  //   data['updated_at'] = updatedAt;
  //   data['created_at'] = createdAt;
  //   data['id'] = id;
  //   return data;
  // }
}