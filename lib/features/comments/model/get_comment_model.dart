class GetCommentModel {
  bool? status;
  GetCommentData? result;

  GetCommentModel({this.status, this.result});

  GetCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? GetCommentData.fromJson(json['result']) : null;
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

class GetCommentData {
  int? id;
  int? teacherId;
  int? gradeId;
  String? images;
  String? description;
  String? createdAt;
  String? updatedAt;
  bool? isFavorite;
  int? likesCount;
  int? commentsCount;
  List<Comments>? comments;

  GetCommentData(
      {this.id,
      this.teacherId,
      this.gradeId,
      this.images,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.isFavorite,
      this.likesCount,
      this.commentsCount,
      this.comments});

  GetCommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    gradeId = json['grade_id'];
    images = json['images'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFavorite = json['is_favorite'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['grade_id'] = gradeId;
    data['images'] = images;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_favorite'] = isFavorite;
    data['likes_count'] = likesCount;
    data['comments_count'] = commentsCount;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  int? dailyUpdatePostId;
  int? userId;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
      this.dailyUpdatePostId,
      this.userId,
      this.comment,
      this.createdAt,
      this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dailyUpdatePostId = json['daily_update_post_id'];
    userId = json['user_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['daily_update_post_id'] = dailyUpdatePostId;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class GetCommentWeekPlane {
  bool? status;
  Result? result;

  GetCommentWeekPlane({this.status, this.result});

  GetCommentWeekPlane.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
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

class Result {
  int? id;
  int? teacherId;
  int? sectionId;
  int? subjectId;
  String? lessonTitle;
  String? lessonDescription;
  String? lessonDate;
  String? createdAt;
  String? updatedAt;
  List<CommentsWeekPlane>? comments;

  Result(
      {this.id,
      this.teacherId,
      this.sectionId,
      this.subjectId,
      this.lessonTitle,
      this.lessonDescription,
      this.lessonDate,
      this.createdAt,
      this.updatedAt,
      this.comments});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    lessonTitle = json['lesson_title'];
    lessonDescription = json['lesson_description'];
    lessonDate = json['lesson_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['comments'] != null) {
      comments = <CommentsWeekPlane>[];
      json['comments'].forEach((v) {
        comments!.add(CommentsWeekPlane.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['lesson_title'] = lessonTitle;
    data['lesson_description'] = lessonDescription;
    data['lesson_date'] = lessonDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentsWeekPlane {
  int? id;
  int? teacherId;
 // Null? guardianId;
  int? weekPlanId;
  String? comment;
  String? createdAt;
  String? updatedAt;

  CommentsWeekPlane(
      {this.id,
      this.teacherId,
     // this.guardianId,
      this.weekPlanId,
      this.comment,
      this.createdAt,
      this.updatedAt});

  CommentsWeekPlane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
   // guardianId = json['guardian_id'];
    weekPlanId = json['week_plan_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    //data['guardian_id'] = guardianId;
    data['week_plan_id'] = weekPlanId;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}