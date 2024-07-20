// Main Response Model
class SectionsAndSubjectsModel {
  bool status;
  List<Stage> result;

  SectionsAndSubjectsModel({
    required this.status,
    required this.result,
  });

  factory SectionsAndSubjectsModel.fromJson(Map<String, dynamic> json) =>
      SectionsAndSubjectsModel(
        status: json["status"],
        result: List<Stage>.from(json["result"].map((x) => Stage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

// Stage Model
class Stage {
  int id;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;
  List<Grade> grades;

  Stage({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.grades,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: Name.fromJson(json["name"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        grades: json["grades"] != null
            ? List<Grade>.from(json["grades"].map((x) => Grade.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "grades": List<dynamic>.from(grades.map((x) => x.toJson())),
      };
}

// Grade Model
class Grade {
  int id;
  int stageId;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;
  List<Section> sections;

  Grade({
    required this.id,
    required this.stageId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.sections,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["id"],
        stageId: json["stage_id"],
        name: Name.fromJson(json["name"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sections: json["sections"] != null
            ? List<Section>.from(
                json["sections"].map((x) => Section.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stage_id": stageId,
        "name": name.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
      };
}

// Section Model
class Section {
  int id;
  int gradeId;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;
  List<Subject> subjects;

  Section({
    required this.id,
    required this.gradeId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.subjects,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        gradeId: json["grade_id"],
        name: Name.fromJson(json["name"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subjects: json["subjects"] != null
            ? List<Subject>.from(
                json["subjects"].map((x) => Subject.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_id": gradeId,
        "name": name.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

// Subject Model
class Subject {
  int id;
  Name? name;
  int gradeId;
  DateTime createdAt;
  DateTime updatedAt;

  Subject({
    required this.id,
   this.name,
    required this.gradeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: Name.fromJson(json["name"]),
        gradeId: json["grade_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "grade_id": gradeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// Name Model
class Name {
  String ar;
  String? en;

  Name({
    required this.ar,
    this.en,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        ar: json["ar"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "ar": ar,
        "en": en,
      };
}

// Pivot Model
