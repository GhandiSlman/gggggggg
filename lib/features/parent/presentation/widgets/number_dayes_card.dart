import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';

class NumberDaysCard extends StatelessWidget {
  const NumberDaysCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                text: "Number of attendance's days".tr,
                color: AppColor.greenColor,
                fontSize: 15.sp,
              ),
              Container(
                width: 100.w,
                height: 35.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.offsetGreenColor),
                child: Center(
                    child: FittedBox(
                  child: CustomText(
                    text: '200',
                    color: AppColor.greenColor,
                    fontSize: 15.sp,
                  ),
                )),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                text: "Number of absence's days".tr,
                color: AppColor.redColor,
                fontSize: 15.sp,
              ),
              Container(
                    width: 100.w,
                height: 35.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.offsetRedColor),
                child: Center(
                    child: FittedBox(
                  child: CustomText(
                    text: '500',
                    color: AppColor.redColor,
                    fontSize: 15.sp,
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
