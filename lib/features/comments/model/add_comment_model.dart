class AddCommentModel {
  bool? status;
  AddCommentData? result;

  AddCommentModel({this.status, this.result});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? AddCommentData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class AddCommentData {
  int? userId;
  String? comment;
  int? dailyUpdatePostId;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddCommentData(
      {this.userId,
      this.comment,
      this.dailyUpdatePostId,
      this.updatedAt,
      this.createdAt,
      this.id});

  AddCommentData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    comment = json['comment'];
    dailyUpdatePostId = json['daily_update_post_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['comment'] = comment;
    data['post_id'] = dailyUpdatePostId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class AddCommentWeekPlane {
 int? teacherId;
  String? comment;
  int? weekPlanId;
  String? updatedAt;
  String? createdAt;
  int? id;
  AddCommentWeekPlane({
    this.teacherId,
    this.comment,
    this.weekPlanId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['weekPlan_id'] = weekPlanId;
    data['comment'] = comment;
    return data;
  }

 AddCommentWeekPlane.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    comment = json['comment'];
    weekPlanId = json['week_plan_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
