class StudentInfo {
  List<SubjectsInfo>? subjects;

  StudentInfo({this.subjects});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <SubjectsInfo>[];
      json['subjects'].forEach((v) {
        subjects!.add(SubjectsInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectsInfo {
  int? id;
  String? name;

  SubjectsInfo({this.id, this.name});

  SubjectsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}