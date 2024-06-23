import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/widgets/shimmer.dart';

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 365.h,
      width: double.infinity,
      padding: EdgeInsets.all(10.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              const ShimmerWidget.circular(width: 40, height: 40),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(
                    width: 200.w,
                    height: 20.h,
                  ),
                  SizedBox(height: 5.h),
                  ShimmerWidget.rectangular(
                    width: 100.w,
                    height: 15.h,
                  ),
                ],
              ),
            ],
          ),
         10.verticalSpace,
          ShimmerWidget.rectangular(
            width: double.infinity,
            height: 15.h,
          ),
          10.verticalSpace,
          Expanded(
            child: ShimmerWidget.rectangular(
              width: double.infinity,
              height: 15.h,
            ),
          ),
        ],
      ),
    );
  }
}
