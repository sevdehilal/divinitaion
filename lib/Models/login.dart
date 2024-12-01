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
  final List<String> roles; // Yeni eklenen roles alanı

  LoginResponse({
    required bool success,
    required String message,
    required this.token,
    required this.userId,
    required this.email,
    required this.emailConfirmed,
    required this.roles,
  }) : super(success: success, message: message);

  // JSON'dan dönüşüm işlemi
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      token: json['data']['token'], // JSON'dan 'data' objesinden token alıyoruz
      userId: json['data']['id'],   // 'data' objesinden userId alıyoruz
      email: json['data']['email'], // 'data' objesinden email alıyoruz
      emailConfirmed: json['data']['emailConfirmed'], // 'data' objesinden emailConfirmed alıyoruz
      roles: List<String>.from(json['data']['roles'] ?? []), // 'data' objesinden roles alıyoruz
    );
  }

  // Modelden JSON'a dönüşüm işlemi
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': { // Burada verileri 'data' objesine yerleştiriyoruz
        'token': token,
        'userId': userId,
        'email': email,
        'emailConfirmed': emailConfirmed,
        'roles': roles,
      },
    };
  }
}
