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

class LoginResponse {
  final String token;
  final int userId;
  final String email;
  final bool emailConfirmed;
  final List<String> roles; // Yeni eklenen roles alanı

  LoginResponse({
    required this.token,
    required this.userId,
    required this.email,
    required this.emailConfirmed,
    required this.roles,
  });

  // JSON'dan dönüştürme işlemi
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      userId: json['id'],
      email: json['email'],
      emailConfirmed: json['emailConfirmed'],
      roles: List<String>.from(json['roles']), // roles alanı için dönüşüm
    );
  }
}
