// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/comments/model/get_comment_model.dart';

class CommentCard extends StatelessWidget {
  final Comments comments;
  const CommentCard({
    required this.comments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(AppImages.personImage),
            ),
            SizedBox(
              width: 7.2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: comments.user?.name ?? "",
                  fontSize: 18.sp,
                  color: AppColor.primaryColor,
                ),
                CustomText(
                  text: comments.user?.role ?? '',
                  fontSize: 15.sp,
                  color: AppColor.greyColor2,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 36.w, top: 10.h),
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                border: Border.all(color: AppColor.greyColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              child: Text(
                comments.comment!,
                style: TextStyle(fontSize: 16.sp, color: AppColor.blackColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
