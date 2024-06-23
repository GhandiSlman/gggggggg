class GetStudentHonorBoardModel {
  bool? status;
  List<HonorBoardStudent>? honorBoard;

  GetStudentHonorBoardModel({this.status, this.honorBoard});

  GetStudentHonorBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['honor_board'] != null) {
      honorBoard = <HonorBoardStudent>[];
      json['honor_board'].forEach((v) {
        honorBoard!.add(HonorBoardStudent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (honorBoard != null) {
      data['honor_board'] = honorBoard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HonorBoardStudent {
  int? id;
  int? teacherId;
  int? subjectId;
  String? title;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  List<StudentsHonorBoard>? students;

  HonorBoardStudent(
      {this.id,
      this.teacherId,
      this.subjectId,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.students});

  HonorBoardStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    subjectId = json['subject_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    if (json['students'] != null) {
      students = <StudentsHonorBoard>[];
      json['students'].forEach((v) {
        students!.add(StudentsHonorBoard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['subject_id'] = subjectId;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? name;
  String? email;
  String? role;

  Teacher({this.id, this.name, this.email, this.role});

  Teacher.fromJson(Map<String, dynamic> json) {
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

class StudentsHonorBoard {
  int? id;
  String? name;
  String? email;
  String? role;
  Pivot? pivot;

  StudentsHonorBoard({this.id, this.name, this.email, this.role, this.pivot});

  StudentsHonorBoard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? honorBoardId;
  int? studentId;

  Pivot({this.honorBoardId, this.studentId});

  Pivot.fromJson(Map<String, dynamic> json) {
    honorBoardId = json['honor_board_id'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['honor_board_id'] = honorBoardId;
    data['student_id'] = studentId;
    return data;
  }
}