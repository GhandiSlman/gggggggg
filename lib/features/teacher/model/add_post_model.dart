class AddPostModel {
  bool? status;
  String? message;
  Homework? homework;

  AddPostModel({this.status, this.message, this.homework});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    homework = json['homework'] != null
        ? Homework.fromJson(json['homework'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (homework != null) {
      data['homework'] = homework!.toJson();
    }
    return data;
  }
}

class Homework {
  int? teacherId;
  String? gradeId;
  String? images;
  String? description;
  String? updatedAt;
  String? createdAt;
  int? id;
  bool? isFavorite;
  int? likesCount;
  int? commentsCount;

  Homework(
      {this.teacherId,
      this.gradeId,
      this.images,
      this.description,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.isFavorite,
      this.likesCount,
      this.commentsCount});

  Homework.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    gradeId = json['grade_id'];
    images = json['images'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    isFavorite = json['is_favorite'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacher_id'] = teacherId;
    data['grade_id'] = gradeId;
    data['images'] = images;
    data['description'] = description;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['is_favorite'] = isFavorite;
    data['likes_count'] = likesCount;
    data['comments_count'] = commentsCount;
    return data;
  }
}