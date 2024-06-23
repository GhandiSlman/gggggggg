import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/features/parent/presentation/widgets/choose_subject_card.dart';
import 'package:lms/features/parent/presentation/widgets/number_dayes_card.dart';
import 'package:lms/features/parent/presentation/widgets/son_rate_card.dart';

class SonAchievementScreen extends StatelessWidget {
  const SonAchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Son Achievement'.tr),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            const SonRateCard(),
            SizedBox(
              height: 10.h
            ),
            const ChooseSubjectCard(),
            SizedBox(
              height: 10.h
            ),
            const NumberDaysCard()
          ],
        ),
      ),
    );
  }
}

