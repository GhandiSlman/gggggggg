class CreateDetailsHomeWork {
  bool? status;
  List<HomeworkData>? data;

  CreateDetailsHomeWork({this.status, this.data});

  CreateDetailsHomeWork.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <HomeworkData>[];
      json['data'].forEach((v) {
        data!.add(HomeworkData.fromJson(v));
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

class HomeworkData {
  int? id;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<Grades>? grades;

  HomeworkData({this.id, this.name, this.createdAt, this.updatedAt, this.grades});

  HomeworkData.fromJson(Map<String, dynamic> json) {
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

class Grades {
  int? id;
  int? stageId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  List<SectionsHomeWork>? sections;
  List<SubjectsHomeWork>? subjects;

  Grades({this.id, this.stageId, this.name, this.createdAt, this.updatedAt, this.sections, this.subjects});

  Grades.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stageId = json['stage_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sections'] != null) {
      sections = <SectionsHomeWork>[];
      json['sections'].forEach((v) {
        sections!.add(SectionsHomeWork.fromJson(v));
      });
    }
    if (json['subjects'] != null) {
      subjects = <SubjectsHomeWork>[];
      json['subjects'].forEach((v) {
        subjects!.add(SubjectsHomeWork.fromJson(v));
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
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionsHomeWork {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;

  SectionsHomeWork({this.id, this.gradeId, this.name, this.createdAt, this.updatedAt});

  SectionsHomeWork.fromJson(Map<String, dynamic> json) {
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

class SubjectsHomeWork {
  int? id;
  Name? name;
  int? gradeId;
  String? createdAt;
  String? updatedAt;

  SubjectsHomeWork({this.id, this.name, this.gradeId, this.createdAt, this.updatedAt});

  SubjectsHomeWork.fromJson(Map<String, dynamic> json) {
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
