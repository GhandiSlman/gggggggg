import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/teacher/controller/continuous_rating_controller.dart';
import 'package:lms/features/teacher/presentation/widgets/continuos_rating_card.dart';

class ContinousRatingScreen extends StatelessWidget {
  const ContinousRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContinuousRatingController continuousRatingController = Get.find();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          Get.toNamed(
            AppRouter.addRate,
            arguments: {
              'isUpdate' : continuousRatingController.isUpdate == false,
            }
          );
        },
        child: Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'Continuous Rating'.tr),
      body: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Obx(
            () => continuousRatingController.isLoadingGetCon.value
                ? ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10.h),
                        child: ShimmerWidget(height: 75.h),
                      );
                    })
                    :continuousRatingController.ratingList.isEmpty?Center(
                      child:CustomText(
                        text:'No ratings'.tr,
                         fontSize: 20.sp,
                         color: AppColor.primaryColor,
                      ),
                    )
                : ListView.builder(
                    itemCount: continuousRatingController.ratingList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10.h),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRouter.assignRatescreen,
                              arguments: {
                                'id' : continuousRatingController.ratingList[index].id.toString(),
                              }
                            );
                            continuousRatingController
                                .getContinuousRatingStudent(
                                    continuousRatingController
                                        .ratingList[index].id!,
                                        
                                        );
                          },
                          child: ContinuousRatingCard(
                            continuousRatingData: continuousRatingController.ratingList[index],
                            name: continuousRatingController
                                .ratingList[index].name!,
                            rate: continuousRatingController
                                .ratingList[index].xp
                                .toString(),
                          ),
                        ),
                      );
                    }),
          )),
    );
  }
}
