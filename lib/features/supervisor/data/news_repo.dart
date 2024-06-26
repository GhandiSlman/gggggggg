import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/supervisor/model/news_model.dart';

abstract class NewsRepo{
   Future<DataState> getNews({required NewsModel newsModel});
}