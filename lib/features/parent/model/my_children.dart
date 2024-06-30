class MyChildren {
  bool? status;
  MyChildrenData? data;

  MyChildren({this.status, this.data});

  MyChildren.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? MyChildrenData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyChildrenData {
  int? id;
  String? name;
  String? email;
  String? role;
  List<Children>? children;

  MyChildrenData({this.id, this.name, this.email, this.role, this.children});

  MyChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  String? email;
  String? role;
  Pivot? pivot;
  List<Section>? section;

  Children(
      {this.id, this.name, this.email, this.role, this.pivot, this.section});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
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
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (section != null) {
      data['section'] = section!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? guardianId;
  int? studentId;

  Pivot({this.guardianId, this.studentId});

  Pivot.fromJson(Map<String, dynamic> json) {
    guardianId = json['guardian_id'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['guardian_id'] = guardianId;
    data['student_id'] = studentId;
    return data;
  }
}

class Section {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  Grade? grade;

  Section(
      {this.id,
      this.gradeId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.grade});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
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
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
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