class GetContinuousRateStudent {
  bool? status;
  List<GetContinuousRateStudentData>? data;

  GetContinuousRateStudent({this.status, this.data});

  GetContinuousRateStudent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetContinuousRateStudentData>[];
      json['data'].forEach((v) {
        data!.add(GetContinuousRateStudentData.fromJson(v));
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

class GetContinuousRateStudentData {
  int? id;
  int? reinforcementXpId;
  int? studentId;
  int? subjectId;
  String? createdAt;
  String? updatedAt;
  ReinforcementXp? reinforcementXp;
  Student? student;
  SubjectStudent? subject;

  GetContinuousRateStudentData(
      {this.id,
      this.reinforcementXpId,
      this.studentId,
      this.subjectId,
      this.createdAt,
      this.updatedAt,
      this.reinforcementXp,
      this.student,
      this.subject});

  GetContinuousRateStudentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reinforcementXpId = json['reinforcement_xp_id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reinforcementXp = json['reinforcement_xp'] != null
        ? ReinforcementXp.fromJson(json['reinforcement_xp'])
        : null;
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
    subject =
        json['subject'] != null ? SubjectStudent.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reinforcement_xp_id'] = reinforcementXpId;
    data['student_id'] = studentId;
    data['subject_id'] = subjectId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (reinforcementXp != null) {
      data['reinforcement_xp'] = reinforcementXp!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    return data;
  }
}

class ReinforcementXp {
  int? id;
  int? teacherId;
  String? name;
  int? xp;
  String? createdAt;
  String? updatedAt;

  ReinforcementXp(
      {this.id,
      this.teacherId,
      this.name,
      this.xp,
      this.createdAt,
      this.updatedAt});

  ReinforcementXp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    name = json['name'];
    xp = json['xp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['name'] = name;
    data['xp'] = xp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Student {
  int? id;
  String? name;
  String? email;
  String? role;

  Student({this.id, this.name, this.email, this.role});

  Student.fromJson(Map<String, dynamic> json) {
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

class SubjectStudent {
  int? id;
  Name? name;
  int? gradeId;
  String? createdAt;
  String? updatedAt;

  SubjectStudent({this.id, this.name, this.gradeId, this.createdAt, this.updatedAt});

  SubjectStudent.fromJson(Map<String, dynamic> json) {
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