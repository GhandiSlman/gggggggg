class ForgetPasswordModel {
  String email;
  String? password;
  String? code;

  ForgetPasswordModel({required this.email, this.password, this.code});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': password,
      'code': code,
    };
  }
}
