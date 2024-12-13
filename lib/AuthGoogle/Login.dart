import 'package:divinitaion/Models/login.dart';
import 'package:flutter/material.dart';
import 'google_auth_service.dart';

class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  LoginResponse? _loginResponse;

  Future<void> _handleSignIn() async {
    try {
      final loginResponse = await _googleAuthService.signInWithGoogle();
      setState(() {
        _loginResponse = loginResponse;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı: ${loginResponse.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  // Çıkış işlemi
  Future<void> _handleSignOut() async {
    await _googleAuthService.signOut();
    setState(() {
      _loginResponse = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Başarıyla çıkış yapıldı.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: _loginResponse == null
            ? ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Google ile Giriş Yap'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Merhaba, ${_loginResponse?.email ?? 'Kullanıcı'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Rol: ${_loginResponse?.roles.join(", ") ?? 'Bilinmiyor'}', // Kullanıcının rolleri
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _handleSignOut,
                    child: Text('Çıkış Yap'),
                  ),
                ],
              ),
      ),
    );
  }
}
