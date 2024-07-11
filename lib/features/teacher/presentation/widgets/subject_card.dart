import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/teacher/controller/homework_controller.dart';
import 'package:lms/features/teacher/model/get_homework_model.dart';
import 'package:lms/features/teacher/presentation/widgets/slidable_action.dart';

class SubjectCard extends StatelessWidget {
  final GetHomeWorkData homeWorkData;
  final String name;
  final String date;
  final int id;
  const SubjectCard({
    super.key,
    required this.name,
    required this.date,
    required this.homeWorkData,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    HomeWorkController homeWorkController = Get.find();
    return Slidable(
      startActionPane:
          ActionPane(extentRatio: 0.5, motion: const ScrollMotion(), children: [
        SlidableActionTecherWidget(
          color: AppColor.redColor,
          label: 'Delete'.tr,
          imagePath: AppImages.deleteImage,
          onTap: () {
            homeWorkController.deleteHomeWork(id);
          },
        ),
        SlidableActionTecherWidget(
          color: AppColor.primaryColor,
          label: 'Edit'.tr,
          imagePath: AppImages.editImage,
          onTap: () {
            Get.toNamed(
              AppRouter.addHomeWork,
              arguments: {
                'isUpdate': homeWorkController.isUpdateHomeWork == false,
                'homeWorkId': id,
                'titleCon': homeWorkController.titleHomeWorkController.text =
                    homeWorkData.title!,
                'detailCon': homeWorkController.detailsHomeWorkController.text =
                    homeWorkData.description!,
                'dateCon': homeWorkController.dateController.text =
                    homeWorkData.endDate!,
              },
            );
          },
        ),
      ]),
      child: Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10.r)),
          height: 80.h,
          child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 7.h,
              ),
              child: ListTile(
                leading: SvgPicture.asset(AppImages.date2Image),
                title: CustomText(
                  text: name,
                  fontSize: 20.sp,
                  color: AppColor.primaryColor,
                ),
                subtitle: Row(
                  children: [
                    SvgPicture.asset(AppImages.dateImage),
                    SizedBox(width: 5.w),
                    CustomText(text: date)
                  ],
                ),
              ))),
    );
  }
}
