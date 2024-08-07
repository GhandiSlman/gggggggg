import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/supervisor/data/news_repo.dart';
import 'package:lms/features/supervisor/model/news_model.dart';

class NewsRepImp implements NewsRepo {
  final DataService _dataService;
  NewsRepImp(this._dataService);
  @override
  Future<DataState> getNews({required NewsModel newsModel}) async {
    String endPoint = "";
    switch (box.read("userType")) {
      case 'supervisor':
        endPoint = 'supervisor/news/index';
      case 'student':
        endPoint = 'student/news/index';
      case 'teacher':
        endPoint = 'teacher/news/index';
      case 'parent':
        endPoint = 'parent/news/index';
    }

    final response = await _dataService.getData<NewsModel>(
      endPoint: endPoint,
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => NewsModel.fromJson(json),
    );
    return response;
  }
}
