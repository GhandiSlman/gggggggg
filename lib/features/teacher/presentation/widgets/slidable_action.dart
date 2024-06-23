// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlidableActionTecherWidget extends StatelessWidget {
  final String? label;
  final Color? color;
  final String? imagePath;
  void Function()? onTap;
  SlidableActionTecherWidget({
    this.label,
    this.color,
    this.imagePath,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,
        color: color,
        width: 80.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('$imagePath'),
              CustomText(text: label!, color: AppColor.whiteColor),
            ],
          ),
        ),
      ),
    );
  }
}
