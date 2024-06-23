class StudentAttendance {
  bool? status;
  List<Result>? result;

  StudentAttendance({this.status, this.result});

  StudentAttendance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<Grades>? grades;

  Result({this.id, this.name, this.createdAt, this.updatedAt, this.grades});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['grades'] != null) {
      grades = <Grades>[];
      json['grades'].forEach((v) {
        grades!.add(Grades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (grades != null) {
      data['grades'] = grades!.map((v) => v.toJson()).toList();
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

class Grades {
  int? id;
  int? stageId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<Sections>? sections;

  Grades(
      {this.id,
      this.stageId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.sections});

  Grades.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stageId = json['stage_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<SectionSubjects>? sectionSubjects;
  List<Students>? students;

  Sections(
      {this.id,
      this.gradeId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.sectionSubjects,
      this.students});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['section_subjects'] != null) {
      sectionSubjects = <SectionSubjects>[];
      json['section_subjects'].forEach((v) {
        sectionSubjects!.add(SectionSubjects.fromJson(v));
      });
    }
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(Students.fromJson(v));
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
    if (sectionSubjects != null) {
      data['section_subjects'] =
          sectionSubjects!.map((v) => v.toJson()).toList();
    }
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionSubjects {
  int? id;
  String? day;
  String? time;
  int? sectionId;
  int? subjectId;
  int? teacherId;
  String? createdAt;
  String? updatedAt;
  Subject? subject;

  SectionSubjects(
      {this.id,
      this.day,
      this.time,
      this.sectionId,
      this.subjectId,
      this.teacherId,
      this.createdAt,
      this.updatedAt,
      this.subject});

  SectionSubjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    time = json['time'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['time'] = time;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['teacher_id'] = teacherId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    return data;
  }
}

class Subject {
  int? id;
  Name? name;
  int? gradeId;
  String? createdAt;
  String? updatedAt;

  Subject({this.id, this.name, this.gradeId, this.createdAt, this.updatedAt});

  Subject.fromJson(Map<String, dynamic> json) {
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
class Students {
  int? id;
  String? name;
  String? email;
  String? role;
  Pivot? pivot;

  Students({this.id, this.name, this.email, this.role, this.pivot});

  Students.fromJson(Map<String, dynamic> json) {
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
