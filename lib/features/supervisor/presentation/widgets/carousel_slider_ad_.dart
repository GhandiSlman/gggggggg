import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';
import 'package:lms/features/supervisor/presentation/widgets/ad_video.dart';

String cleanImagePath(String path) {
  return path.replaceAll(RegExp(r"[\[\]']"), '').replaceAll('"', '');
}

class CarouselSliderAd extends StatelessWidget {
  final String concatenatedImages;
  final String concatenatedVideos;

  CarouselSliderAd({
    super.key,
    required this.concatenatedImages,
    required this.concatenatedVideos,
  });

  final AdvertisementsController advertisementsController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<String> images = concatenatedImages
        .split(',')
        .map((e) => cleanImagePath(e.trim()))
        .toList();
    List<String> videos = concatenatedVideos
        .split(',')
        .map((e) => cleanImagePath(e.trim()))
        .toList();

    // Combine images and videos into a unified list
    var carouselItems = [];
    for (var i = 0; i < images.length; i++) {
      carouselItems.add({'type': 'image', 'url': '$imageBaseUrl${images[i]}'});
    }
    for (var i = 0; i < videos.length; i++) {
      carouselItems.add({'type': 'video', 'url': imageBaseUrl + videos[i]});
    }

    return CarouselSlider.builder(
      itemCount: carouselItems.length,
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlayAnimationDuration: const Duration(seconds: 2),
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) =>
            advertisementsController.currentIndexCarousel.value = index,
      ),
      itemBuilder: (context, index, realIndex) {
        var item = carouselItems[index];
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: item['type'] == 'image'
                  ? Image.network(item['url'], fit: BoxFit.fill)
                  : VideoPlayerWidget(url: item['url']),
            ),
          ),
        );
      },
    );
  }
}
