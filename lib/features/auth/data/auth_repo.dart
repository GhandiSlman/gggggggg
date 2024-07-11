import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/auth/models/login_model.dart';

abstract class AuthRepo {
  Future<DataState> logIn({required LoginModel loginModel});
  Future<DataState> logOut();
 // Future<DataState> getInfo({required GetLoginModel getLoginModel});
}
