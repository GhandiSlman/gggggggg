import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/auth/models/forget_password_model.dart';
import 'package:lms/features/auth/models/login_model.dart';

abstract class AuthRepo {
  Future<DataState> logIn({required LoginModel loginModel});
  Future<DataState> forgetPassword(
      {required String endPoint,
      required ForgetPasswordModel forgetPasswordModel});
  Future<DataState> logOut();
}
