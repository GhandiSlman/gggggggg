class UpdateActivityModel {
  String? activityId;
  String? sectionId;
  String? title;
  String? description;
  String? date;

  UpdateActivityModel(
      {this.activityId,
      this.sectionId,
      this.title,
      this.description,
      this.date});

  UpdateActivityModel.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    sectionId = json['section_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['section_id'] = sectionId;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}

class GetUpdateActivityModel {
  bool? status;
  String? message;
  UpdateActivity? activity;

  GetUpdateActivityModel({this.status, this.message, this.activity});

  GetUpdateActivityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    activity = json['activity'] != null
        ? UpdateActivity.fromJson(json['activity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (activity != null) {
      data['activity'] = activity!.toJson();
    }
    return data;
  }
}

class UpdateActivity {
  int? id;
  int? teacherId;
  int? sectionId;
  String? title;
  String? description;
  String? date;
  String? createdAt;
  String? updatedAt;

  UpdateActivity(
      {this.id,
      this.teacherId,
      this.sectionId,
      this.title,
      this.description,
      this.date,
      this.createdAt,
      this.updatedAt});

  UpdateActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}