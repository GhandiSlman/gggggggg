class GetClassSchedule {
  final bool? status;
  final Map<String, List<Schedule>>? classScheduleByDay;

  GetClassSchedule({this.status, this.classScheduleByDay});

  factory GetClassSchedule.fromJson(Map<String, dynamic> json) {
    Map<String, List<Schedule>>? scheduleByDay;

    if (json['classScheduleByDay'] != null) {
      scheduleByDay = (json['classScheduleByDay'] as Map<String, dynamic>).map((key, value) =>
        MapEntry(key, (value as List).map((item) => Schedule.fromJson(item)).toList()));
    }

    return GetClassSchedule(
      status: json['status'],
      classScheduleByDay: scheduleByDay,
    );
  }
}

class Schedule {
  final int? id;
  final String? time;
  final int? sectionId;
  final int? subjectId;
  final int? teacherId;
  final String? createdAt;
  final String? updatedAt;
  final Section? section;
  final Subject? subject;

  Schedule({
    this.id,
    this.time,
    this.sectionId,
    this.subjectId,
    this.teacherId,
    this.createdAt,
    this.updatedAt,
    this.section,
    this.subject,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      time: json['time'],
      sectionId: json['section_id'],
      subjectId: json['subject_id'],
      teacherId: json['teacher_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      section: Section.fromJson(json['section']),
      subject: Subject.fromJson(json['subject']),
    );
  }
}

class Section {
  final int? id;
  final int? gradeId;
  final String? name;
  final Grade? grade;

  Section({
    this.id,
    this.gradeId,
    this.name,
    this.grade,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      gradeId: json['grade_id'],
      name: json['name'],
      grade: Grade.fromJson(json['grade']),
    );
  }
}

class Grade {
  final int? id;
  final int? stageId;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Grade({
    this.id,
    this.stageId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      stageId: json['stage_id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Subject {
  final int? id;
  final String? name;
  final int? gradeId;
  final String? createdAt;
  final String? updatedAt;

  Subject({
    this.id,
    this.name,
    this.gradeId,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      gradeId: json['grade_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
