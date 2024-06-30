class AddContinuousRateStudent {
  String? reinforcementXpId;
  String? studentId;
  String? subjectId;

  AddContinuousRateStudent(
      {this.reinforcementXpId, this.studentId, this.subjectId});

  AddContinuousRateStudent.fromJson(Map<String, dynamic> json) {
    reinforcementXpId = json['reinforcement_xp_id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reinforcement_xp_id'] = reinforcementXpId;
    data['student_id'] = studentId;
    data['subject_id'] = subjectId;
    return data;
  }
}

class GetAddContinuousRateStudent {
  String? reinforcementXpId;
  String? studentId;
  String? subjectId;
  String? updatedAt;
  String? createdAt;
  int? id;

  GetAddContinuousRateStudent(
      {this.reinforcementXpId,
      this.studentId,
      this.subjectId,
      this.updatedAt,
      this.createdAt,
      this.id});

  GetAddContinuousRateStudent.fromJson(Map<String, dynamic> json) {
    reinforcementXpId = json['reinforcement_xp_id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reinforcement_xp_id'] = reinforcementXpId;
    data['student_id'] = studentId;
    data['subject_id'] = subjectId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}