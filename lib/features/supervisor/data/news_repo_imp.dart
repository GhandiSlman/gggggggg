import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/supervisor/data/news_repo.dart';
import 'package:lms/features/supervisor/model/news_model.dart';

class NewsRepImp implements NewsRepo{
  final DataService _dataService;
  NewsRepImp(this._dataService);
@override
  Future<DataState> getNews({required NewsModel newsModel})async{
     final response = await _dataService.getData<NewsModel>(
      endPoint: 'supervisor/news/index', 
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => NewsModel.fromJson(json),
    );
    return response;
  }
}