class UpdateAdvertisementModel {
  String? descriptionEn;
  String? descriptionAr;
  String? id;

  UpdateAdvertisementModel({
    this.descriptionAr,
    this.descriptionEn,
    this.id,
  });

  UpdateAdvertisementModel.fromJson(Map<String, dynamic> json) {

    descriptionAr = json['description[ar]'];
    descriptionEn = json['description[en]'];
    id = json['advertisement_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['description[en]'] = descriptionEn;
    data['description[ar]'] = descriptionAr;
    data['advertisement_id'] = id;
    return data;
  }
}
