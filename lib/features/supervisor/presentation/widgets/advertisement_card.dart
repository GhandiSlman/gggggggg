import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';
import 'package:lms/features/supervisor/presentation/widgets/carousel_slider_ad.dart';

class AdvertisementsCard extends StatelessWidget {
  final AdvertisementsData advertisementsData;

  const AdvertisementsCard({required this.advertisementsData, super.key});

  @override
  Widget build(BuildContext context) {
    // Convert the list of images to a single concatenated string if necessary
    Object concatenatedImages = advertisementsData.images is List
        ? (advertisementsData.images as List).join(',')
        : advertisementsData.images ?? '';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.whiteColor,
      ),
      height: 250.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h, right: 10.h, left: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CarouselSliderAd(
                  concatenatedImages:concatenatedImages.toString(),
                ),
              ),
            ),
            10.verticalSpace,
            FittedBox(
              child: CustomText(
                text: advertisementsData.subAdmin?.name ?? '',
                color: AppColor.primaryColor,
                fontSize: 20.sp,
              ),
            ),
            10.verticalSpace,
            FittedBox(
              child: CustomText(
                text: advertisementsData.createdAt ?? '',
                color: AppColor.greyColor,
                fontSize: 15.sp,
              ),
            ),
            10.verticalSpace,
            AutoSizeText(
              maxLines: 4,
               box.read('langCode') == 'ar'
                  ? advertisementsData.description?.ar ?? ''
                  : advertisementsData.description?.en ?? '',
              style: TextStyle(
                color: AppColor.greyColor,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
