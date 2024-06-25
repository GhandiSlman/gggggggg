class AddAdvertisementModel {
  String? descriptionEn;
  String? descriptionAr;
  List<String>? images;
  String? type;

  AddAdvertisementModel({
    this.descriptionAr,
    this.descriptionEn,
    this.images,
    this.type,
  });

  AddAdvertisementModel.fromJson(Map<String, dynamic> json) {
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    descriptionAr = json['description[ar]'];
    descriptionEn = json['description[en]'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['description[en]'] = descriptionEn;
    data['description[ar]'] = descriptionAr;
    data['images'] = images;
    data['type'] = type;
    return data;
  }
}
