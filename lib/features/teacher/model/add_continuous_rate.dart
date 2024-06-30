class AddContinuousRating {
  String? name;
  String? xp;

  AddContinuousRating({this.name, this.xp});

  AddContinuousRating.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    xp = json['xp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['xp'] = xp;
    return data;
  }
}

class AddContinuousRatingData {
  String? name;
  String? xp;
  int? teacherId;
  String? updatedAt;
  String? createdAt;
  int? id;

  AddContinuousRatingData(
      {this.name,
      this.xp,
      this.teacherId,
      this.updatedAt,
      this.createdAt,
      this.id});

  AddContinuousRatingData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    xp = json['xp'];
    teacherId = json['teacher_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['xp'] = xp;
    data['teacher_id'] = teacherId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}