import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';

class PrepareTajweedSugjectScreen extends StatelessWidget {
  const PrepareTajweedSugjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: CustomText(
                text: '06/05/2024',
                fontSize: 20.sp,
                color: AppColor.greyColor2,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(10.h),
                      child:  const ListTile())),
            ),
          ],
        ));
  }
}
