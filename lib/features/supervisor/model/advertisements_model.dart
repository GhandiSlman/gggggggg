class Advertisements {
  bool? status;
  List<AdvertisementsData>? advertisements;

  Advertisements({this.status, this.advertisements});

  Advertisements.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['advertisements'] != null) {
      advertisements = <AdvertisementsData>[];
      json['advertisements'].forEach((v) {
        advertisements!.add(AdvertisementsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (advertisements != null) {
      data['advertisements'] =
          advertisements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvertisementsData {
  int? id;
  List<String>? images;
  Description? description;
  int? subAdminId;
  String? createdAt;
  String? updatedAt;
  SubAdmin? subAdmin;

  AdvertisementsData(
      {this.id,
      this.images, 
      this.description,
      this.subAdminId,
      this.createdAt,
      this.updatedAt,
      this.subAdmin});

  AdvertisementsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    subAdminId = json['sub_admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subAdmin = json['sub_admin'] != null
        ? SubAdmin.fromJson(json['sub_admin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (images != null) {
      data['images'] = images;
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['sub_admin_id'] = subAdminId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subAdmin != null) {
      data['sub_admin'] = subAdmin!.toJson();
    }
    return data;
  }
}


class Description {
  String? en;
  String? ar;

  Description({this.en, this.ar});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
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
