import 'package:divinitaion/Models/base_model.dart';

class Login {
  String userName;
  String password;

  Login({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}

class LoginResponse extends BaseModel {
  final String token;
  final int userId;
  final String email;
  final bool emailConfirmed;
  final List<String> roles;

  LoginResponse({
    required bool success,
    required String message,
    required this.token,
    required this.userId,
    required this.email,
    required this.emailConfirmed,
    required this.roles,
  }) : super(success: success, message: message);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      token: json['data']['token'],
      userId: json['data']['id'],
      email: json['data']['email'],
      emailConfirmed: json['data']['emailConfirmed'],
      roles: List<String>.from(json['data']['roles'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {
        'token': token,
        'userId': userId,
        'email': email,
        'emailConfirmed': emailConfirmed,
        'roles': roles,
      },
    };
  }
}
