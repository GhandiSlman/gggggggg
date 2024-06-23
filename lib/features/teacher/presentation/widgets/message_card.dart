import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.all(5.w),
              margin: EdgeInsets.symmetric(
                //  horizontal: 10.w, 
                  vertical: 10.h),
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  )),
              child: Padding( 
                padding:  EdgeInsets.all(10.h),
                child: const CustomText(
                  text: 'kja nvkjvjkdddddddddddddddd dksvnov ao vjkja colann',
                  color: Colors.black87,
                  //  size: 15,
                ),
              )),
        ),
      ],
    );
  }
}
