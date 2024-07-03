// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/auth/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController loginController =
        Get.put(AuthController(Get.find()), permanent: true);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColor.primaryColor,
          ),
          Positioned(
            top: 250.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.amber2Color,
                // borderRadius: BorderRadius.only(
                //   topRight: Radius.circular(50.r),
                //   topLeft: Radius.circular(50.r),
                // ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: Form(
                    key: loginController.formKey,
                    child: Column(
                      children: [
                        20.verticalSpace,
                        CustomText(
                          text: 'Login'.tr,
                          color: AppColor.primaryColor,
                          fontSize: 20.sp,
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          controller: loginController.email,
                          hint: 'Enter Email'.tr,
                          filled: true,
                          filledColor: AppColor.whiteColor,
                          suffix: SvgPicture.asset(AppImages.userImage),
                          validator: ValidationBuilder().email().build(),
                        ),
                        10.verticalSpace,
                        CustomTextField(
                          controller: loginController.password,
                          hint: 'Enter Password'.tr,
                          filled: true,
                          filledColor: AppColor.whiteColor,
                          suffix: SvgPicture.asset(AppImages.passwordImage),
                          validator: ValidationBuilder().minLength(8).build(),
                        ),
                        30.verticalSpace,
                        Obx(
                          () => loginController.isLoading.value
                              ? const LoadingWidget()
                              : CustomButton(
                                  text: 'Login'.tr,
                                  onTap: () {
                                    if (loginController.formKey.currentState!.validate()) {
                                      loginController.login();
                                    }
                                  },
                                  color: AppColor.green2Color,
                                  textColor: AppColor.whiteColor,
                                  width: double.infinity,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
