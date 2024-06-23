import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms/core/utils/app_color.dart';

import 'package:lms/core/widgets/custom_text.dart';

class StudentStatusCard extends StatelessWidget {
  const StudentStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.whiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(7.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  height: 103.h,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height:10.h,
                ),
                CustomText(
                  text: 'Ghandi',
                  color: AppColor.primaryColor,
                  fontSize: 18.sp,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          Container(
            height: 23.5.h,
            decoration: BoxDecoration(
                color: AppColor.redColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                )),
            child: Center(
              child: CustomText(
                text: 'Asbent',
                color: AppColor.whiteColor,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
