import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/shimmer.dart';

import 'package:lms/features/supervisor/controller/news_controller.dart';
import 'package:lms/features/supervisor/presentation/widgets/news_card.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put<NewsController>(Get.find());
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(
        title: 'News'.tr,
      ),
      body: Obx(() => newsController.isLoadingGetNews.value
          ? ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.h),
                  child: ShimmerWidget(height: 250.h),
                );
              })
          : ListView.builder(
              itemCount: newsController.newsList.length,
              itemBuilder: (context, index) {
                final news = newsController.newsList[index];
                return Padding(
                  padding: EdgeInsets.all(10.h),
                  child: NewsCard(
                    newsData: news,
                  ),
                );
              },
            )),
    );
  }
}
