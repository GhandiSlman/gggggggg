class AddHomeWorkModel {
  bool? status;
  String? message;
  Homework? homework;

  AddHomeWorkModel({this.status, this.message, this.homework});

  AddHomeWorkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    homework = json['homework'] != null
        ? Homework.fromJson(json['homework'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (homework != null) {
      data['homework'] = homework!.toJson();
    }
    return data;
  }
}

class Homework {
  int? teacherId;
  int? sectionId;
  int? subjectId;
  String? title;
  String? description;
  String? endDate;
  String? updatedAt;
  String? createdAt;
  int? homeworkId;

  Homework(
      {this.teacherId,
      this.sectionId,
      this.subjectId,
      this.title,
      this.description,
      this.endDate,
      this.updatedAt,
      this.createdAt,
      this.homeworkId});

  Homework.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    title = json['title'];
    description = json['description'];
    endDate = json['end_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    homeworkId = json['homework_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacher_id'] = teacherId;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['title'] = title;
    data['description'] = description;
    data['end_date'] = endDate;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['homework_id'] = homeworkId;
    return data;
  }
}