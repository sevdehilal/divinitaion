import 'dart:convert'; // JSON işlemleri için
import 'package:divinitaion/Models/fortune_categories_entity.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:http/http.dart' as http; // HTTP istekleri için
import '../Models/login.dart'; // Login modeliniz

class ApiService {
  final String apiUrl = "https://fallinfal.com/api/Auth/login"; // API URL

  Future<LoginResponse?> login(Login loginModel) async {
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
        print('Login successful');
        print(response.body);
        final Map<String, dynamic> data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);
        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
      // İstek sırasında bir hata olursa
      print('Error during login: $e');
      return null;
    }
  }

  Future<void> verifyId(int id) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://fallinfal.com/api/Auth/SendEmailConfirmation?id=$id"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        print('ID başarıyla doğrulandı!');
      } else {
        print('Doğrulama hatası: ${response.body}');
      }
    } catch (e) {
      print('Bir hata oluştu: $e');
    }
  }

  Future<bool> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse("https://fallinfal.com/api/Auth/RegisterClient"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        // Başarılı kayıt
        return true;
      } else {
        // Kayıt başarısız
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<bool> registerFortuneTeller(FortuneTeller fortuneTeller) async {
    try {
      final response = await http.post(
        Uri.parse("https://fallinfal.com/api/Auth/RegisterFortuneTeller"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(fortuneTeller.toJson()),
      );

      if (response.statusCode == 200) {
        // Başarılı kayıt
        return true;
      } else {
        // Kayıt başarısız
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<List<FortuneTeller>> FetchFortuneTeller() async {
    final response = await http.get(Uri.parse(
        "http://fallinfal.com/api/Client/GetAllFortuneTeller"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FortuneTeller.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<FortuneCategories>> fetchFortuneCategories() async {
    final response = await http.get(Uri.parse(
        "http://fallinfal.com/api/Client/GetAllFortuneTeller")); // api hazır olmadığından şuanlık falcıları çekiyor dropdown içine

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FortuneCategories.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
