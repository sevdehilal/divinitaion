import 'dart:convert';
import 'dart:io';
import 'package:divinitaion/Models/fortune_categories_entity.dart';
import 'package:divinitaion/Models/fortune_entity.dart';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Models/fortune_list.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/login.dart';

class ApiService {
  final String apiUrl = "https://fallinfal.com/api/Auth/login";

  Future<LoginResponse?> login(Login loginModel) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginModel.toJson()),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        print('Login successful');
        print(response.body);
        final Map<String, dynamic> data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);
        await prefs.setInt('id', loginResponse.userId);
        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
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
        return true;
      } else {
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
        return true;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<List<FortuneTeller>> FetchFortuneTeller() async {
    final response = await http
        .get(Uri.parse("http://fallinfal.com/api/Client/GetAllFortuneTeller"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FortuneTeller.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<FortuneCategory>> fetchFortuneCategories() async {
    final response = await http
        .get(Uri.parse("http://fallinfal.com/api/Category/GetAllCategory"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FortuneCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<FortuneListt>> fetchPendingFortunes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int? clientId = prefs.getInt('id');

    if (clientId == null) {
      throw Exception('No fortune teller ID found in SharedPreferences');
    }

    final response = await http
        .get(Uri.parse("http://fallinfal.com/api/Application/GetApplicationByClientIdIsAnsweredFalse?id=$clientId"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FortuneListt.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load fortunes');
    }
  }

  Future<List<FortuneListt>> fetchAnsweredFortunes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int? clientId = prefs.getInt('id');

    if (clientId == null) {
      throw Exception('No fortune teller ID found in SharedPreferences');
    }

    final response = await http
        .get(Uri.parse("http://fallinfal.com/api/Application/GetApplicationByClientIdIsAnsweredTrue?id=$clientId"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FortuneListt.fromJson(json)).toList();
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
      // Prepare the request URL
      var url =
          Uri.parse("http://fallinfal.com/api/Application/AddApplication");

      // Convert photos to base64
      String base64Photo1 = kIsWeb
          ? base64Encode(photo1.bytes!)
          : base64Encode(File(photo1.path!).readAsBytesSync());

      String base64Photo2 = kIsWeb
          ? base64Encode(photo2.bytes!)
          : base64Encode(File(photo2.path!).readAsBytesSync());

      String base64Photo3 = kIsWeb
          ? base64Encode(photo3.bytes!)
          : base64Encode(File(photo3.path!).readAsBytesSync());

      var requestBody = {
        'ClientId': clientId,
        'FortunetellerId': fortunetellerId,
        'CategoryIds': categoryIds,
        'Photo1': base64Photo1,
        'Photo2': base64Photo2,
        'Photo3': base64Photo3,
      };

      print(base64Photo2.length);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

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

  Future<List<FortuneForFortuneTeller>> FetchPendingFortunesByFortuneTellerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int? fortuneTellerId = prefs.getInt('id');

    if (fortuneTellerId == null) {
      throw Exception('No fortune teller ID found in SharedPreferences');
    }

    final response = await http.get(
      Uri.parse("http://fallinfal.com/api/Application/GetApplicationByFortuneTeller?id=$fortuneTellerId"),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      print(response.body);
      return jsonList.map((json) => FortuneForFortuneTeller.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load fortunes');
    }
  }

  Future<bool> sendAnswer({
    required int? fortuneId,
    required String? answer,
  }) async {
    try {
      var url = Uri.parse(
        "http://fallinfal.com/api/Application/AnswerApplication?id=$fortuneId&answer=$answer"
      );

      var requestBody = {
        'Answers': answer,
        'ApplicationsId': fortuneId,
      };

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

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

  
  Future<List<FortuneForFortuneTeller>> FetchAnsweredFortunesByFortuneTellerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int? fortuneTellerId = prefs.getInt('id');

    if (fortuneTellerId == null) {
      throw Exception('No fortune teller ID found in SharedPreferences');
    }

    final response = await http.get(
      Uri.parse("http://fallinfal.com/api/Application/GetApplicationByFortuneTellerIsAnsweredTrue?id=$fortuneTellerId"),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      print(response.body);
      return jsonList.map((json) => FortuneForFortuneTeller.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load fortunes');
    }
  }

  Future<int> fetchClientCreditByClientId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? clientId = prefs.getInt('id');

    if (clientId == null) {
      throw Exception('No client ID found in SharedPreferences');
    }

    final response = await http.get(
      Uri.parse("http://fallinfal.com/api/Client/GetCredit?clientId=$clientId"),
    );

    if (response.statusCode == 200) {
      try {
        int credit = int.parse(response.body);
        return credit;
      } catch (e) {
        throw Exception('Failed to parse response as integer: ${response.body}');
      }
    } else {
      throw Exception('Failed to fetch client credit, status code: ${response.statusCode}');
    }
  }
}
