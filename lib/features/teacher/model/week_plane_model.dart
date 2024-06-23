class AddWeekPlaneModel {
  String? sectionId;
  String? subjectId;
  String? title;
  String? description;
  String? date;
  AddWeekPlaneModel(
      {this.sectionId,
      this.subjectId,
      this.title,
      this.description,
      this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_id'] = sectionId;
    data['subject_id'] = sectionId;
    data['lesson_title'] = title;
    data['lesson_description'] = description;
    data['lesson_date'] = date;
    return data;
  }
}

class WeekPlaneModel {
  bool? status;
  GetWeekPlane? data;

  WeekPlaneModel({this.status, this.data});

  WeekPlaneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? GetWeekPlane.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetWeekPlane {
  int? currentPage;
  List<WeekPlaneDetails>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  GetWeekPlane({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  GetWeekPlane.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <WeekPlaneDetails>[];
      json['data'].forEach((v) {
        data!.add(WeekPlaneDetails.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class UpdateWeekPlaneModel {
  bool? status;
  String? message;
  WeekPlan? weekPlan;

  UpdateWeekPlaneModel({this.status, this.message, this.weekPlan});

  UpdateWeekPlaneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    weekPlan = json['weekPlan'] != null
        ? WeekPlan.fromJson(json['weekPlan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (weekPlan != null) {
      data['weekPlan'] = weekPlan!.toJson();
    }
    return data;
  }
}

class WeekPlan {
  int? id;
  int? sectionId;
  int? subjectId;
  String? lessonTitle;
  String? lessonDescription;
  String? lessonDate;
  String? createdAt;
  String? updatedAt;

  WeekPlan(
      {this.id,
      this.sectionId,
      this.subjectId,
      this.lessonTitle,
      this.lessonDescription,
      this.lessonDate,
      this.createdAt,
      this.updatedAt});

  WeekPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    lessonTitle = json['lesson_title'];
    lessonDescription = json['lesson_description'];
    lessonDate = json['lesson_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weekPlan_id'] = id;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['lesson_title'] = lessonTitle;
    data['lesson_description'] = lessonDescription;
    data['lesson_date'] = lessonDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class WeekPlaneDetails {
  int? id;
  int? teacherId;
  int? sectionId;
  int? subjectId;
  String? lessonTitle;
  String? lessonDescription;
  String? lessonDate;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  SectionWeekPlane? section;
  WeekPlaneSubject? subject;

  WeekPlaneDetails({
    this.id,
    this.teacherId,
    this.sectionId,
    this.subjectId,
    this.lessonTitle,
    this.lessonDescription,
    this.lessonDate,
    this.createdAt,
    this.updatedAt,
    this.teacher,
    this.section,
    this.subject,
  });

  WeekPlaneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    lessonTitle = json['lesson_title'];
    lessonDescription = json['lesson_description'];
    lessonDate = json['lesson_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    section = json['section'] != null
        ? SectionWeekPlane.fromJson(json['section'])
        : null;
    subject = json['subject'] != null
        ? WeekPlaneSubject.fromJson(json['subject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['lesson_title'] = lessonTitle;
    data['lesson_description'] = lessonDescription;
    data['lesson_date'] = lessonDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
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

class SectionWeekPlane {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;

  SectionWeekPlane({
    this.id,
    this.gradeId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  SectionWeekPlane.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grade_id'] = gradeId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class WeekPlaneSubject {
  int? id;
  int? gradeId;
  Name? name;
  String? createdAt;
  String? updatedAt;

  WeekPlaneSubject({
    this.id,
    this.gradeId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  WeekPlaneSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['grade_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grade_id'] = gradeId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
