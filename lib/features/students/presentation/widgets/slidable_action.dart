import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';

class SlidableActionWidget extends StatelessWidget {
  final String? label;
  final Color? color;
  final SlidableController? controller;
  final void Function()? onTap;
  const SlidableActionWidget({
    this.label,
    this.color,
    this.controller,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 75.h,
        color: color,
        width: 55.w,
        child: Center(
          child: CustomText(text: label!, color: AppColor.whiteColor),
        ),
      ),
    );
  }
}
