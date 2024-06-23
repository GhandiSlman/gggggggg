import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/auth/data/models/login_model.dart';
import 'package:lms/features/auth/data/remote_repo/auth_repo.dart';
import 'package:lms/core/data/data_state.dart';

class AuthController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;

  RxBool isLoading = false.obs;
  var userType = ''.obs;
  RxnString loginErrorMessage = RxnString();

  final AuthRepo authRepo;

  AuthController(this.authRepo);

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  Future<void> login() async {
    isLoading.value = true;
    loginErrorMessage.value = null;
    final loginModel = LoginModel(
      email: email.text,
      password: password.text,
    );

    final DataState loginResult = await authRepo.logIn(loginModel: loginModel);
    if (loginResult is DataSuccess<GetLoginModel>) {
      await box.write('token', loginResult.data!.accessToken);
      await box.write('userType', loginResult.data!.user!.role);
      print(box.write('userType', loginResult.data!.user!.role));
      isLoading.value = false;
      Get.toNamed(AppRouter.homeScreen);
    } else if (loginResult is DataFailed) {
      isLoading.value = false;
      loginErrorMessage.value =
          loginResult.errorMessage ?? 'An unknown error occurred';
    }
  }

  Future<void> logOut() async {
    isLoading.value = true;
    final DataState logoutResult = await authRepo.logOut();
    // print('======================');
    // print(logoutResult.statusCode);
    // print('======================');
    if (logoutResult is DataSuccess) {
      //   print(logoutResult.statusCode);
      await box.remove('token');
      isLoading.value = false;
      Get.toNamed(AppRouter.loginScreen);
    } else if (logoutResult is DataFailed) {
      isLoading.value = false;
      logoutResult.errorMessage ?? 'An unknown error occurred';
    }
  }
}
