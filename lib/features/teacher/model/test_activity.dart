class GetActivityIndex {
  bool? status;
  List<ActivityIndex>? activity;

  GetActivityIndex({this.status, this.activity});

  
  GetActivityIndex.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['activity'] != null) {
      activity = <ActivityIndex>[];
      json['activity'].forEach((v) {
        activity!.add(ActivityIndex.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (activity != null) {
      data['activity'] = activity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityIndex {
  int? id;
  int? teacherId;
  int? sectionId;
  String? title;
  String? description;
  String? date;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  Section? section;

  ActivityIndex(
      {this.id,
      this.teacherId,
      this.sectionId,
      this.title,
      this.description,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.section});

  ActivityIndex.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['section_id'] = sectionId;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
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

class Section {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  Grade? grade;

  Section(
      {this.id,
      this.gradeId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.grade});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    grade = json['grade'] != null ? Grade.fromJson(json['grade']) : null;
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
    if (grade != null) {
      data['grade'] = grade!.toJson();
    }
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

class Grade {
  int? id;
  int? stageId;
  Name? name;
  String? createdAt;
  String? updatedAt;

  Grade({this.id, this.stageId, this.name, this.createdAt, this.updatedAt});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stageId = json['stage_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stage_id'] = stageId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}