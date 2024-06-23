// import 'package:dartz/dartz.dart';
// import 'package:lms/features/auth/data/local_repo/local_repo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalRepoImp implements LocalRepo {
//   SharedPreferences? sharedPreferences;
//   LocalRepoImp({this.sharedPreferences});

//   @override
//   Future<Unit> storeToken(String token) async {
//     await sharedPreferences!.setString('stored token', token);
//     return unit;
//   }

//   @override
//   Future<Unit> storeUserType(String userType) async {
//     await sharedPreferences!.setString('stored user type', userType);
//     return unit;
//   }

//   @override
//   Future<String> getToken() async {
//     return sharedPreferences!.getString('stored token') ?? '';
//   }

//   @override
//   Future<String> getUserType() async {
//     return sharedPreferences!.getString('stored user type') ?? '';
//   }

//   @override
//   Future<Unit> removeToken() async {
//     await sharedPreferences!.remove('signup');
//     return unit;
//   }
// }
