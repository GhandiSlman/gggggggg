import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/supervisor/data/news_repo.dart';
import 'package:lms/features/supervisor/model/news_model.dart';

class NewsController extends GetxController {
  NewsRepo newsRepo;
  NewsController(this.newsRepo);

  RxList<NewsData> newsList = <NewsData>[].obs;
  RxBool isLoadingGetNews = false.obs;
  Future<void> getNews() async {
    isLoadingGetNews.value = true;
    final DataState result = await newsRepo.getNews(newsModel: NewsModel());
    isLoadingGetNews.value = false;
    newsList.clear();
    if (result is DataSuccess) {
      for (var news in result.data!.news!) {
        if (news.createdAt != null) {
          final DateTime dateTime = DateTime.parse(news.createdAt!);
          news.createdAt = DateFormat('yyyy-MM-dd').format(dateTime);
        }
        newsList.add(news);
      }
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  @override
  void onInit() {
    getNews();
    super.onInit();
  }
}
