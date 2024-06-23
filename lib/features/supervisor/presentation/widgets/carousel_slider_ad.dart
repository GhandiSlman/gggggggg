import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';

String cleanImagePath(String path) {
  return path.replaceAll(RegExp(r"[\[\]']"), '').replaceAll('"', '');
}
class CarouselSliderAd extends StatelessWidget {
    final String concatenatedImages;

  CarouselSliderAd({super.key, required this.concatenatedImages});
  
  final AdvertisementsController advertisementsController = Get.find();

  @override
  Widget build(BuildContext context) {
      List<String> images = concatenatedImages
        .split(',')
        .map((e) => cleanImagePath(e.trim()))
        .toList();
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            viewportFraction: 1.0,
            aspectRatio: 8 / 5,
            onPageChanged: (index, reason) =>
                advertisementsController.currentIndexCarousel.value = index,
          ),
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('$imageBaseUrl${images[index]}'),
                  fit: BoxFit.fill,
                 
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
