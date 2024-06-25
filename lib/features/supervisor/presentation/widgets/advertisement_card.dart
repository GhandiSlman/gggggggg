import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';
import 'package:lms/features/supervisor/presentation/widgets/carousel_slider_ad.dart';

class AdvertisementsCard extends StatelessWidget {
  final AdvertisementsData advertisementsData;
  //final NewsData? newsData;
  final bool isAdvertisement;

  const AdvertisementsCard(
      {required this.advertisementsData, required this.isAdvertisement, super.key});

  @override
  Widget build(BuildContext context) {
    AdvertisementsController advertisementsController = Get.find();
    Object concatenatedImages = advertisementsData.images is List
        ? (advertisementsData.images as List).join(',')
        : advertisementsData.images ?? '';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.whiteColor,
      ),
      height: 250.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 75.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CarouselSliderAd(
                  concatenatedImages: concatenatedImages.toString(),
                ),
              ),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: FittedBox(
                    child: CustomText(
                      text: advertisementsData.subAdmin?.name ?? '',
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                isAdvertisement == true
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Obx(() => advertisementsController
                                      .isLoadingDelete.value
                                  ? const LoadingWidget()
                                  : SimpleDialog(
                                      children: [
                                        ListTile(
                                          title: CustomText(text: 'Update'.tr),
                                          leading: SvgPicture.asset(
                                              AppImages.updateImage),
                                          onTap: () {
                                            Get.toNamed(
                                                AppRouter.addUpdateAdvScreen,
                                                arguments: {
                                                  'AdId':
                                                      advertisementsData.id,
                                                  'isUpdate':
                                                      advertisementsController
                                                              .isUpdate ==
                                                          false,
                                                  'desConAr':
                                                      advertisementsController
                                                              .descControllerAr
                                                              .text =
                                                          advertisementsData
                                                              .description!.ar!,
                                                  'desConEn':
                                                      advertisementsController
                                                              .descControllerEn
                                                              .text =
                                                          advertisementsData
                                                              .description!.en!,
                                                });
                                          },
                                        ),
                                        ListTile(
                                          title: CustomText(text: 'Delete'.tr),
                                          leading: SvgPicture.asset(
                                              AppImages.delete2Image),
                                          onTap: () {
                                            advertisementsController.deleteAd(
                                                advertisementsData.id!);
                                          },
                                        ),
                                      ],
                                    ));
                            },
                          );
                        },
                        icon: const Icon(Icons.more_horiz_outlined))
                    : const SizedBox(),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: FittedBox(
                child: CustomText(
                  text: advertisementsData.createdAt!,
                  color: AppColor.greyColor,
                  fontSize: 15.sp,
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AutoSizeText(
                maxLines: 4,
                box.read('langCode') == 'ar'
                    ? advertisementsData.description?.ar ?? ''
                    : advertisementsData.description?.en ?? '',
                style: TextStyle(
                  color: AppColor.greyColor,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
