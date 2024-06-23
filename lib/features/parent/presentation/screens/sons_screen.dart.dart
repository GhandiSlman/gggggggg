import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/features/parent/presentation/widgets/son_card.dart';

class SonsScreen extends StatelessWidget {
  const SonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: const CustomAppBar(title: 'My sons'),
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(8.h),
                child: const SonCard())),
      ),
    );
  }
}
