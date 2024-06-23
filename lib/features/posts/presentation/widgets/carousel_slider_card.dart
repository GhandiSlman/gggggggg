import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/posts/controller/post_controller.dart';

String cleanImagePath(String path) {
  return path.replaceAll(RegExp(r"[\[\]']"), '').replaceAll('"', '');
}

class CarouselSliderItems extends StatelessWidget {
  final String concatenatedImages;

  CarouselSliderItems({super.key, required this.concatenatedImages});

  final PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Split the concatenated image string into a list
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
                postController.currentIndexCarousel.value = index,
          ),
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('$imageBaseUrl${images[index]}'),
                  fit: BoxFit.fill,
                 // Ensure you have a placeholder image in your assets
                
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
