import 'dart:convert'; // JSON işlemleri için
import 'package:divinitaion/Models/fortune_categories_entity.dart';
import 'package:divinitaion/Models/fortune_entity.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:http/http.dart' as http; // HTTP istekleri için
import '../Models/login.dart'; // Login modeliniz
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';

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

   Future<List<Fortune>> FetchFortunes() async {
    final response = await http.get(Uri.parse(
        "http://fallinfal.com/api/Client/GetAllFortune"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Fortune.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load fortunes');
    }
  }

  Future<bool> saveFortune({
    required int? clientId,
    required int? fortunetellerId,
    required List<int> categoryIds,
    required PlatformFile photo1,
    required PlatformFile photo2,
    required PlatformFile photo3,
  }) async {
    try {
      // Prepare the multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://fallinfal.com/api/Application/AddApplication"),
      );

      // Add form fields
      request.fields['ClientId'] = jsonEncode(clientId);
      request.fields['FortunetellerId'] = jsonEncode(fortunetellerId);
      request.fields['CategoryIds'] = jsonEncode(categoryIds);

      // Add photo1
      var multipartFile1 = kIsWeb
          ? http.MultipartFile.fromBytes('Photo1', photo1.bytes!, filename: photo1.name)
          : await http.MultipartFile.fromPath('Photo1', photo1.path!);
      request.files.add(multipartFile1);

      // Add photo2
      var multipartFile2 = kIsWeb
          ? http.MultipartFile.fromBytes('Photo2', photo2.bytes!, filename: photo2.name)
          : await http.MultipartFile.fromPath('Photo2', photo2.path!);
      request.files.add(multipartFile2);

      // Add photo3
      var multipartFile3 = kIsWeb
          ? http.MultipartFile.fromBytes('Photo3', photo3.bytes!, filename: photo3.name)
          : await http.MultipartFile.fromPath('Photo3', photo3.path!);
      request.files.add(multipartFile3);

      // Send the request
      var response = await request.send();

      // Check if the request was successful
      if (response.statusCode == 200) {
        print('Fortune successfully saved!');
        return true;
      } else {
        print('Failed to save fortune. Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception while saving fortune: $e');
      return false;
    }
  }
}
