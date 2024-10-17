import 'package:divinitaion/Page/Common/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Logout işlemi yapan buton widget'ı
class LogoutButton extends StatelessWidget {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Butona tıklandığında çağrılacak fonksiyon
  Future<void> _logoutAndClearData(BuildContext context) async {
    await secureStorage.deleteAll(); // Secure storage'daki tüm verileri sil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out and data cleared!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _logoutAndClearData(context), // Logout işlemi
      child: Text('Logout'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
    );
  }
}
