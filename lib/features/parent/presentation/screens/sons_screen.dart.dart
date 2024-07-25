import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/features/parent/controller/parent_controller.dart';
import 'package:lms/features/parent/presentation/widgets/son_card.dart';

class SonsScreen extends StatelessWidget {
  const SonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ParentController parentController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: CustomAppBar(title: 'My sons'.tr),
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Obx(
          () => parentController.isLoadingGetChild.value
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10.h),
                      child: ShimmerWidget(height: 75.h),
                    );
                  })
              : ListView.builder(
                  itemCount: parentController.myChildren!.data.children.length,
                  itemBuilder: (context, index) {
                    var child =
                        parentController.myChildren!.data.children[index];
                    return Padding(
                      padding: EdgeInsets.all(10.h),
                      child: SonCard(son: child
                          //  box.read('langCode') == 'ar'
                          //     ? child
                          //     : child.section![0].grade!.name!.en!
                          ),
                    );
                    // }
                    // }
                  },
                ),
        ),
      ),
    );
  }
}
