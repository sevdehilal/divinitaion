import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _apiResponse = "";

  Future<void> signInWithGoogle() async {
    try {
      // Google Sign-In işlemi
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() {
          _apiResponse = "Kullanıcı giriş işlemini iptal etti.";
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Firebase Authentication'a yetkilendirme bilgileri ile giriş
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Firebase'den kullanıcı bilgilerini al
        final String userId = user.uid;
        final String email = user.email ?? "No Email";
        final String fullName = user.displayName ?? "No Name";

        // Ad ve soyadı ayır
        final List<String> nameParts = fullName.split(" ");
        final String name = nameParts.first; // İlk parça: Ad
        final String surname = nameParts.length > 1
            ? nameParts.last
            : "No Surname"; // Son parça: Soyad

        // API'ye gönderilecek veri
        final Map<String, dynamic> apiData = {
          "id": userId,
          "email": email,
          "name": name,
          "surname": surname,
        };

        // API isteği
        final response = await http.post(
          Uri.parse(
              "https://your-api-endpoint.com/login"), // API URL'sini buraya ekleyin
          headers: {"Content-Type": "application/json"},
          body: json.encode(apiData),
        );

        // API yanıtını işleme
        if (response.statusCode == 200) {
          setState(() {
            _apiResponse = "Başarılı giriş: ${response.body}";
          });
        } else {
          setState(() {
            _apiResponse = "API Hatası: ${response.body}";
          });
        }
      }
    } catch (e) {
      setState(() {
        _apiResponse = "Google ile giriş hatası: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sign-In"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: signInWithGoogle,
              child: Text("Google ile Giriş Yap"),
            ),
            SizedBox(height: 20),
            Text(
              _apiResponse,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
