import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/models/message_model.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/features/auth/models/forget_password_model.dart';
import 'package:lms/features/auth/models/login_model.dart';
import 'package:lms/features/auth/data/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final DataService _dataService;

  AuthRepoImpl(this._dataService);

  @override
  Future<DataState> logIn({required LoginModel loginModel}) async {
    final response = await _dataService.postData(
        endPoint: 'login',
        data: loginModel,
        fromJson: GetLoginModel.fromJson,
        baseUrl: baseUrl);
    return response;
  }

  @override
  Future<DataState> logOut() async {
    final response = await _dataService.getData(
      endPoint: 'logout',
      baseUrl: baseUrl,
      fromJson: (Map<String, dynamic> json) => GetLoginModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<DataState> forgetPassword(
      {required String endPoint,
      required ForgetPasswordModel forgetPasswordModel}) async {
    return await _dataService.postData(
      endPoint: endPoint,
      data: forgetPasswordModel,
      fromJson: MessageModel.fromJson,
    );
  }
}
