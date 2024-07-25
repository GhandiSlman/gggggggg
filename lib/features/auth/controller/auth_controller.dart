import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Add this import
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/auth/models/forget_password_model.dart';
import 'package:lms/features/auth/models/login_model.dart';
import 'package:lms/features/auth/data/auth_repo.dart';
import 'package:lms/core/data/data_state.dart';

class AuthController extends GetxController {
  late final TextEditingController code;
  late final TextEditingController email;
  late final TextEditingController password;

  RxBool isLoading = false.obs;
  RxnString loginErrorMessage = RxnString();

  final AuthRepo authRepo;

  final formKey = GlobalKey<FormState>();

  AuthController(this.authRepo);

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    code = TextEditingController();
    super.onInit();
  }

  Future<void> login() async {
    isLoading.value = true;
    loginErrorMessage.value = null;
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    final loginModel = LoginModel(
      email: email.text.trim(),
      password: password.text.trim(),
      deviceToken: deviceToken,
    );

    final DataState loginResult = await authRepo.logIn(loginModel: loginModel);
    isLoading.value = false;
    if (loginResult is DataSuccess) {
      await box.write('token', loginResult.data!.accessToken);
      await box.write('userType', loginResult.data!.user!.role);
      await box.write('id', loginResult.data!.user!.id);
      await box.write('name', loginResult.data.user!.name);
      await box.write('email', loginResult.data.user!.email);
      email.clear();
      password.clear();
      Get.offAllNamed(AppRouter.homeScreen);
    } else if (loginResult is DataFailed) {
      CustomToast.showToast(
        message: "Invalid login credentials",
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }

  Future<void> forgetPassword() async {
    isLoading.value = true;
    final DataState dataState = await authRepo.forgetPassword(
        endPoint: 'forgetPassword',
        forgetPasswordModel: ForgetPasswordModel(email: email.text.trim()));
    isLoading.value = false;
    if (dataState is DataSuccess) {
      Get.offNamed(AppRouter.forgetCodePasswordScreen);
    } else if (dataState is DataFailed) {
      CustomToast.customErrorToast("Somthing went wrong !");
    }
  }

  Future<void> forgetCodePassword() async {
    isLoading.value = true;
    final DataState dataState = await authRepo.forgetPassword(
        endPoint: 'checkResetPasswordCode',
        forgetPasswordModel: ForgetPasswordModel(
          email: email.text.trim(),
          code: code.text.trim(),
        ));
    isLoading.value = false;
    if (dataState is DataSuccess) {
      Get.offNamed(AppRouter.resetPasswordScreen);
    } else if (dataState is DataFailed) {
      CustomToast.customErrorToast("Somthing went wrong !");
    }
  }

  Future<void> resetPassword() async {
    isLoading.value = true;
    final DataState dataState = await authRepo.forgetPassword(
        endPoint: 'resetPassword',
        forgetPasswordModel: ForgetPasswordModel(
          email: email.text.trim(),
          code: code.text.trim(),
          password: password.text.trim(),
        ));
    isLoading.value = false;
    if (dataState is DataSuccess) {
      CustomToast.customSuccessToast("Done");
      Get.offAllNamed(AppRouter.loginScreen);
      code.clear();
      password.clear();
      email.clear();
    } else if (dataState is DataFailed) {
      CustomToast.customErrorToast("Somthing went wrong !");
    }
  }

  Future<void> logOut() async {
    final DataState logoutResult = await authRepo.logOut();
    if (logoutResult is DataSuccess) {
      await box.remove('token');
      Get.offAllNamed(AppRouter.loginScreen);
    } else if (logoutResult is DataFailed) {}
  }
}
