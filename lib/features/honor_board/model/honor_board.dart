class CreateHonorBoardModel {
  String? subjectId;
  String? title;
  List<String>? studentIds;

  CreateHonorBoardModel({this.subjectId, this.title, this.studentIds});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['title'] = title;
    data['student_ids'] = studentIds;
    return data;
  }
}

class GetHonorBoardModel {
  bool? status;
  List<HonorBoard>? data;

  GetHonorBoardModel({this.status, this.data});

  GetHonorBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HonorBoard>[];
      json['data'].forEach((v) {
        data!.add(HonorBoard.fromJson(v));
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

class HonorBoard {
  int? id;
  int? stageId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<Subjects>? subjects;
  List<Sections>? sections;

  HonorBoard(
      {this.id,
      this.stageId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.subjects,
      this.sections});

  HonorBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stageId = json['stage_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
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
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class Subjects {
  int? id;
  Name? name;
  int? gradeId;
  String? createdAt;
  String? updatedAt;

  Subjects({this.id, this.name, this.gradeId, this.createdAt, this.updatedAt});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    gradeId = json['grade_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['grade_id'] = gradeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Sections {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<StudentsHonorBoard>? students;

  Sections(
      {this.id,
      this.gradeId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.students});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['students'] != null) {
      students = <StudentsHonorBoard>[];
      json['students'].forEach((v) {
        students!.add(StudentsHonorBoard.fromJson(v));
      });
    }
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
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentsHonorBoard {
  int? id;
  String? name;
  String? email;
  String? role;
  Pivot? pivot;

  StudentsHonorBoard({this.id, this.name, this.email, this.role, this.pivot});

  StudentsHonorBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? sectionId;
  int? studentId;

  Pivot({this.sectionId, this.studentId});

  Pivot.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_id'] = sectionId;
    data['student_id'] = studentId;
    return data;
  }
}