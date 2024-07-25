import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/features/parent/controller/son_archeivments_controller.dart';
import 'package:lms/features/parent/presentation/widgets/choose_subject_card.dart';
import 'package:lms/features/parent/presentation/widgets/number_dayes_card.dart';
import 'package:lms/features/parent/presentation/widgets/son_rate_card.dart';

class SonAchievementScreen extends GetView<SonArcheivementController> {
  const SonAchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SonArcheivementController());
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Son Achievement'.tr),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            SonRateCard(
              name: controller.son!.name,
              xp: controller.son?.totalXp ?? 0,
            ),
            SizedBox(height: 10.h),
            // const ChooseSubjectCard(),
            // DropdownButton(items: controller.son.subjects.map((e){
            //   DropdownMenuItem(v)
            // }), onChanged: onChanged)

            SizedBox(height: 10.h),
            const NumberDaysCard()
          ],
        ),
      ),
    );
  }
}
