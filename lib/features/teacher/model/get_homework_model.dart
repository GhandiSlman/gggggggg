class GetHomeWorkModel {
  bool? status;
  List<GetHomeWorkData>? data;

  GetHomeWorkModel({this.status, this.data});

  GetHomeWorkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetHomeWorkData>[];
      json['data'].forEach((v) {
        data!.add(new GetHomeWorkData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
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
        json['section'] != null ? new Section.fromJson(json['section']) : null;
    subject =
        json['subject'] != null ? new Section.fromJson(json['subject']) : null;
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_id'] = this.teacherId;
    data['section_id'] = this.sectionId;
    data['subject_id'] = this.subjectId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
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
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grade_id'] = this.gradeId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}