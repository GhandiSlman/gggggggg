class ContinuousRating {
  bool? status;
  List<ContinuousRatingData>? data;

  ContinuousRating({this.status, this.data});

  ContinuousRating.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ContinuousRatingData>[];
      json['data'].forEach((v) {
        data!.add(ContinuousRatingData.fromJson(v));
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

class ContinuousRatingData {
  int? id;
  int? teacherId;
  String? name;
  int? xp;
  String? createdAt;
  String? updatedAt;

  ContinuousRatingData(
      {this.id,
      this.teacherId,
      this.name,
      this.xp,
      this.createdAt,
      this.updatedAt});

  ContinuousRatingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    name = json['name'];
    xp = json['xp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['name'] = name;
    data['xp'] = xp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}