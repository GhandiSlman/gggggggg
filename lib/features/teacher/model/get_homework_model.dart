class GetHomeWorkModel {
  bool? status;
  List<GetHomeWorkData>? data;

  GetHomeWorkModel({this.status, this.data});

  GetHomeWorkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetHomeWorkData>[];
      json['data'].forEach((v) {
        data!.add(GetHomeWorkData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = 
    <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetHomeWorkData {
  int? id;
  int? teacherId;
  int? sectionId;
  int? subjectId;
  String? title;
  String? description;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  Section? section;
  Section? subject;
  Teacher? teacher;

  GetHomeWorkData(
      {this.id,
      this.teacherId,
      this.sectionId,
      this.subjectId,
      this.title,
      this.description,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.section,
      this.subject,
      this.teacher});

  GetHomeWorkData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    title = json['title'];
    description = json['description'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
    subject =
        json['subject'] != null ? Section.fromJson(json['subject']) : null;
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['title'] = title;
    data['description'] = description;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    return data;
  }
}

class Section {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;

  Section({this.id, this.gradeId, this.name, this.createdAt, this.updatedAt});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grade_id'] = gradeId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Name {
  String? ar;
  String? en;

  Name({this.ar, this.en});

  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }
}

class Teacher {
  int? id;
  String? name;
  String? email;
  String? role;

  Teacher({this.id, this.name, this.email, this.role});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}