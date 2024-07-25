// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/custom_text_field.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/auth/controller/auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController loginController =
        Get.put(AuthController(Get.find()), permanent: true);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.3.sh,
                padding: EdgeInsets.all(20.w),
                child: SvgPicture.asset('assets/white-logo.svg'),
              ),
              Container(
                height: 0.8.sh,
                decoration: BoxDecoration(
                  color: AppColor.amber2Color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.r),
                    topLeft: Radius.circular(50.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        32.verticalSpace,
                        CustomText(
                          text: 'Forget Password'.tr,
                          color: AppColor.primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          controller: loginController.email,
                          hint: 'Enter Email'.tr,
                          filled: true,
                          filledColor: AppColor.whiteColor,
                          validator: ValidationBuilder().email().build(),
                        ),
                        30.verticalSpace,
                        Obx(
                          () => loginController.isLoading.value
                              ? const LoadingWidget()
                              : CustomButton(
                                  text: 'Send'.tr,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      loginController.forgetPassword();
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
            ],
          ),
        ),
      ),
    );
  }
}
