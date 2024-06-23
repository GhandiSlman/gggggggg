import 'package:lms/core/data/data_state.dart';
import 'package:lms/features/auth/data/models/login_model.dart';

abstract class AuthRepo {
  Future<DataState> logIn({required LoginModel loginModel});
  Future<DataState> logOut();
}
