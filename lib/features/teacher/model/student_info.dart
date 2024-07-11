class StudentInfo {
  List<SubjectInfo>? subjects;

  StudentInfo({this.subjects});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <SubjectInfo>[];
      json['subjects'].forEach((v) {
        subjects!.add(SubjectInfo.fromJson(v['subjects']));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => subjects.toString();
}

class SubjectInfo {
  int? id;
  Name? name;
  int? gradeId;
  String? createdAt;
  String? updatedAt;

  SubjectInfo(
      {this.id, this.name, this.gradeId, this.createdAt, this.updatedAt});

  SubjectInfo.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() => "$name";
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

  @override
  String toString() => "$ar $en";
}
