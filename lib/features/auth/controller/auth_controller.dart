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
//  var userType = ''.obs;
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
     isLoading.value = false;
    if (loginResult is DataSuccess<GetLoginModel>) {
      await box.write('token', loginResult.data!.accessToken);
      await box.write('userType', loginResult.data!.user!.role);
     
      Get.offAllNamed(AppRouter.homeScreen);
    } else if (loginResult is DataFailed) {
      
    }
  }

  Future<void> logOut() async {
    final DataState logoutResult = await authRepo.logOut();
    if (logoutResult is DataSuccess<GetLoginModel>) {
      await box.remove('token');
      Get.offAllNamed(AppRouter.loginScreen);
    } else if (logoutResult is DataFailed) {
    }
  }
}
