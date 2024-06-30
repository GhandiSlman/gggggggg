class ClassSchedule {
  bool? status;
  Map<String, List<ScheduleData>>? classScheduleByDay;

  ClassSchedule({ this.status,  this.classScheduleByDay});

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      status: json['status'],
      classScheduleByDay: (json['classScheduleByDay'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((i) => ScheduleData.fromJson(i)).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'classScheduleByDay': classScheduleByDay!.map(
        (key, value) => MapEntry(
          key,
          value.map((i) => i.toJson()).toList(),
        ),
      ),
    };
  }
}

class ScheduleData {
  String time;
  Subject subject;

  ScheduleData({required this.time, required this.subject});

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      time: json['time'],
      subject: Subject.fromJson(json['subject']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'subject': subject.toJson(),
    };
  }
}

class Subject {
  String name;

  Subject({required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
