import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_text.dart';

class ChooseSubjectCard extends StatelessWidget {
  const ChooseSubjectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColor.whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomText(
              text: 'Subject'.tr,
              fontSize: 20.sp,
              color: AppColor.primaryColor,
            ),
            Container(
              width: 125.w,
              height: 30.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColor.offsetPrimary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 75.w,
                    child: FittedBox(
                      child: CustomText(
                        text: 'Tajweed subject',
                        color: AppColor.primaryColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColor.primaryColor,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
