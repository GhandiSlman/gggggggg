class StudentStatus {
  int? studentId;
  int? subjectId;
  String? status;
  String? date;

  StudentStatus({this.studentId, this.subjectId, this.status, this.date});

  StudentStatus.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    status = json['status'];
    date = json['date'];
  }

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
  bool? status;
  Data? data;

  GetStudentStatus({this.status, this.data});

  GetStudentStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? studentId;
  int? subjectId;
  String? status;
  String? date;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.studentId,
      this.subjectId,
      this.status,
      this.date,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    status = json['status'];
    date = json['date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['subject_id'] = subjectId;
    data['status'] = status;
    data['date'] = date;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

