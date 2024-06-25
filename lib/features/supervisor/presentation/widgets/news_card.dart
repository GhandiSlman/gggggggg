import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';

import 'package:lms/core/widgets/custom_text.dart';


import 'package:lms/features/supervisor/model/news_model.dart';
import 'package:lms/features/supervisor/presentation/widgets/carousel_slider_ad.dart';

class NewsCard extends StatelessWidget {

  final NewsData newsData;


  const NewsCard(
      {required this.newsData, super.key});

  @override
  Widget build(BuildContext context) {
    Object concatenatedImages = newsData.images is List
        ? (newsData.images as List).join(',')
        : newsData.images ?? '';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.whiteColor,
      ),
      height: 250.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 75.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CarouselSliderAd(
                  concatenatedImages: concatenatedImages.toString(),
                ),
              ),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: FittedBox(
                    child: CustomText(
                      text: newsData.subAdmin?.name ?? '',
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: FittedBox(
                child: CustomText(
                  text: newsData.createdAt!,
                  color: AppColor.greyColor,
                  fontSize: 15.sp,
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AutoSizeText(
                maxLines: 4,
                box.read('langCode') == 'ar'
                    ? newsData.description?.ar ?? ''
                    : newsData.description?.en ?? '',
                style: TextStyle(
                  color: AppColor.greyColor,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
