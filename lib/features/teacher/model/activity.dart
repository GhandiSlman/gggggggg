class CreateActivityModel {
  String? sectionId;
  String? title;
  String? description;
  String? date;

  CreateActivityModel(
      {this.sectionId, this.title, this.description, this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_id'] = sectionId;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}

class GetActivity {
  bool? status;
  List<Activity>? activity;

  GetActivity({this.status, this.activity});

  GetActivity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(Activity.fromJson(v));
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

class Activity {
  int ? id;
  int? teacherId;
  int? sectionId;
  String? title;
  String? description;
  String? date;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;

  Activity(
      {this.id,
      this.teacherId,
      this.sectionId,
      this.title,
      this.description,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.teacher});

  Activity.fromJson(Map<String, dynamic> json) {
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