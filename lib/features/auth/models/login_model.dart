class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class GetLoginModel {
  User? user;
  String? accessToken;
  String? tokenType;

  GetLoginModel({this.user, this.accessToken, this.tokenType});

  factory GetLoginModel.fromJson(Map<String, dynamic> json) {
    return GetLoginModel(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? role;

  User({this.id, this.name, this.email, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}

