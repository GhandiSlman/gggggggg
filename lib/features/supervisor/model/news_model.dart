class NewsModel {
  bool? status;
  List<NewsData>? news;

  NewsModel({this.status, this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['news'] != null) {
      news = <NewsData>[];
      json['news'].forEach((v) {
        news!.add(NewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsData {
  int? id;
  List<String>? images;
  List<String>? videos;
  Description? description;
  int? subAdminId;
  String? type;
  String? createdAt;
  String? updatedAt;
  SubAdmin? subAdmin;

  NewsData(
      {this.id,
      this.images,
      this.videos,
      this.description,
      this.subAdminId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.subAdmin});

  NewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    videos = json['videos'] != null ? List<String>.from(json['videos']) : [];
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    subAdminId = json['sub_admin_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subAdmin = json['sub_admin'] != null
        ? SubAdmin.fromJson(json['sub_admin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images;
    data['videos'] = videos;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['sub_admin_id'] = subAdminId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subAdmin != null) {
      data['sub_admin'] = subAdmin!.toJson();
    }
    return data;
  }
}


class Description {
  String? ar;
  String? en;

  Description({this.ar, this.en});

  Description.fromJson(Map<String, dynamic> json) {
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

class SubAdmin {
  int? id;
  String? name;
  String? email;
  String? role;

  SubAdmin({this.id, this.name, this.email, this.role});

  SubAdmin.fromJson(Map<String, dynamic> json) {
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