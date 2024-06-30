import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/students/model/class_schedual.dart';
import 'package:lms/features/teacher/data/class_schedule_repo.dart';
import 'package:lms/features/teacher/model/get_class_schedule.dart';

class ClassScheduleRepoImp implements ClassScheduleRepo {
  final DataService _dataService;

  ClassScheduleRepoImp(this._dataService);
  @override
  Future<DataState> getClassSchedule(
      {required GetClassSchedule classSchedule}) {
    final response = _dataService.getData(
      endPoint:'teacher/getClassSchedule' ,
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => GetClassSchedule.fromJson(json),
    );
    return response;
  }
  @override
  Future<DataState> getClassSchedualStudent(
      {required ClassSchedule classSchedule}) async {
    final response = await _dataService.getData(
        endPoint: 'student/getClassSchedule', baseUrl: baseUrl,
        fromJson: (Map<String, dynamic> json) => ClassSchedule.fromJson(json),
        );
        
    return response;
  }
}
