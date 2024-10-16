import 'dart:convert'; // JSON işlemleri için
import 'package:divinitaion/Models/login.dart';
import 'package:http/http.dart' as http; // HTTP istekleri için

class LoginService {
  final String apiUrl = "https://fallinfal.com/api/Auth/login"; // API URL

  Future<bool> login(Login loginModel) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginModel.toJson()), // loginModel'i JSON'a çevirme
      );

      if (response.statusCode == 200) {
        // Giriş başarılı
        print('Login successful');
        print(response.body);
        return true;
      } else {
        // Hata mesajını yazdır
        print('Login failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      // İstek sırasında bir hata olursa
      print('Error during login: $e');
      return false;
    }
  }
}
