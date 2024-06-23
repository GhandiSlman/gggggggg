import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double height;
  // final ShapeBorder? shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    //this.shapeBorder = const RoundedRectangleBorder(),
  });

  const ShimmerWidget.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    // this.shapeBorder = const CircleBorder(),
  });

  const ShimmerWidget({
    super.key,
    required this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[400]!,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
