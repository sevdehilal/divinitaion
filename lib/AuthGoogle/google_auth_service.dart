import 'dart:convert';
import 'package:divinitaion/Models/google_user.dart';
import 'package:divinitaion/Models/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<LoginResponse> signInWithGoogle() async {
    try {
      // Google Sign-In işlemi
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google giriş iptal edildi.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase ile giriş
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Kullanıcı bilgisi alınamadı.');
      }

      // GoogleUser modelini oluştur
      final googleUserModel = GoogleUser(
        googleId: user.uid,
        email: user.email!,
        firstName: user.displayName?.split(' ').first ?? '',
        lastName: user.displayName?.split(' ').last ?? '',
      );

      // Backend isteği
      final response = await http.post(
        Uri.parse('https://fallinfal.com/api/Auth/SigninGoogleFlutter'),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode(googleUserModel.toJson()), // Burada modeli kullanıyoruz
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        await prefs.setInt('id', loginResponse.userId);
        await prefs.setString('token', loginResponse.token);
        return loginResponse;
      } else {
        throw Exception('Backend hatası: ${response.body}');
      }
    } catch (e) {
      throw Exception('Google giriş sırasında hata: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
