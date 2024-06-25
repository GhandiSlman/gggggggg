import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';
import 'package:lms/features/supervisor/presentation/widgets/advertisement_card.dart';

class AdvertisementsScreen extends StatelessWidget {
  const AdvertisementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AdvertisementsController advertisementsController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRouter.addUpdateAdvScreen, arguments: {
            'isUpdate': advertisementsController.isUpdate == true,
          });
        },
        backgroundColor: AppColor.primaryColor,
        child: Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
      appBar: CustomAppBar(
        title: 'Advertisements'.tr,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Obx(() {
            return advertisementsController.myTabs.isNotEmpty
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      indicatorColor: AppColor.primaryColor,
                      labelColor: AppColor.primaryColor,
                      controller: advertisementsController.controller,
                      tabs: advertisementsController.myTabs,
                    ),
                  )
                : Container();
          }),
        ),
      ),
      body: Obx(() => TabBarView(
            controller: advertisementsController.controller,
            children: advertisementsController.myTabs.map((Tab tab) {
              if (tab.text == 'Advertisements'.tr) {
                return advertisementsController.isLoadingGetAd.value
                    ? ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.h),
                            child: ShimmerWidget(height: 250.h),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount:
                            advertisementsController.advertisementsList.length,
                        itemBuilder: (context, index) {
                          final advertisement = advertisementsController
                              .advertisementsList[index];
                          return Padding(
                            padding: EdgeInsets.all(10.h),
                            child: AdvertisementsCard(
                              isAdvertisement: false,
                              advertisementsData: advertisement,
                            ),
                          );
                        },
                      );
              } else {
                return advertisementsController.isLoadingGetMyAd.value
                    ? ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.h),
                            child: ShimmerWidget(height: 250.h),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: advertisementsController
                            .myAdvertisementsList.length,
                        itemBuilder: (context, index) {
                          final advertisement = advertisementsController
                              .myAdvertisementsList[index];
                          return Padding(
                            padding: EdgeInsets.all(10.h),
                            child: AdvertisementsCard(
                              isAdvertisement: true,
                              advertisementsData: advertisement,
                            ),
                          );
                        },
                      );
              }
            }).toList(),
          )),
    );
  }
}
