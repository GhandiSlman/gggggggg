class StudentInfo {
  List<SubjectsWrapper>? subjects;
  Info? info;

  StudentInfo({this.subjects, this.info});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <SubjectsWrapper>[];
      json['subjects'].forEach((v) {
        subjects!.add(SubjectsWrapper.fromJson(v));
      });
    }
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    return data;
  }
}

class SubjectsWrapper {
  Subject? subjects;

  SubjectsWrapper({this.subjects});

  SubjectsWrapper.fromJson(Map<String, dynamic> json) {
    subjects = json['subjects'] != null ? Subject.fromJson(json['subjects']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
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

class Info {
  int? id;
  String? name;
  String? email;
  String? role;
  List<Section>? section;

  Info({this.id, this.name, this.email, this.role, this.section});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    if (json['section'] != null) {
      section = <Section>[];
      json['section'].forEach((v) {
        section!.add(Section.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    if (section != null) {
      data['section'] = section!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Section {
  int? id;
  Name? name;
  int? gradeId;
  Pivot? pivot;
  Grade? grade;

  Section({this.id, this.name, this.gradeId, this.pivot, this.grade});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    gradeId = json['grade_id'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    grade = json['grade'] != null ? Grade.fromJson(json['grade']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['grade_id'] = gradeId;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (grade != null) {
      data['grade'] = grade!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? studentId;
  int? sectionId;

  Pivot({this.studentId, this.sectionId});

  Pivot.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    sectionId = json['section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['section_id'] = sectionId;
    return data;
  }
}

class Grade {
  int? id;
  Name? name;

  Grade({this.id, this.name});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}
