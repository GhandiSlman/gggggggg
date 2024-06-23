import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userType = box.read('userType');
    final isTeacher = userType == 'teacher';

    final postController = isTeacher ? Get.find<PostController>() : null;
    final advertisementsController =
        isTeacher ? null : Get.find<AdvertisementsController>();

    return InkWell(
      onTap: () {
        Get.bottomSheet(Container(
          height: 100.h,
          color: AppColor.whiteColor,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  if (isTeacher) {
                    postController?.getImage(ImageSource.camera);
                  } else {
                    advertisementsController?.getImage(ImageSource.camera);
                  }
                  Get.back(); // Close the bottom sheet after selection
                },
                leading: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColor.primaryColor,
                ),
                title: CustomText(
                  text: 'Camera'.tr,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () {
                  if (isTeacher) {
                    postController?.getImage(ImageSource.gallery);
                  } else {
                    advertisementsController?.getImage(ImageSource.gallery);
                  }
                  Get.back(); // Close the bottom sheet after selection
                },
                leading: Icon(Icons.image, color: AppColor.primaryColor),
                title: CustomText(
                  text: 'Gallery'.tr,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ));
      },
      child: Container(
        width: 100.w,
        height: 80.h,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            border: Border.all(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.cameraBlueImage),
              SizedBox(
                height: 5.h,
              ),
              CustomText(
                text: isTeacher ? 'Add image/video'.tr : 'Add image'.tr,
                fontSize: 10.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
