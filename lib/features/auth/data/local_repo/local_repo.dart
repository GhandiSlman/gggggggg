import 'package:dartz/dartz.dart';

abstract class LocalRepo {
  Future<Unit> storeToken(String token);
  Future<Unit> storeUserType(String userType);
  Future<String> getToken();
  Future<String> getUserType();
  Future<Unit> removeToken();
}
