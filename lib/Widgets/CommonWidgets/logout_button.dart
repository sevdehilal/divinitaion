import 'package:divinitaion/Page/Common/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';

// Logout işlemi yapan buton widget'ı
class LogoutButton extends StatelessWidget {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Butona tıklandığında çağrılacak fonksiyon
  Future<void> _logoutAndClearData(BuildContext context) async {
    // Onay mesajı göster
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Dialog'un arka planını şeffaf yap
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), // Arka plan bulanıklaştırma
            child: AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.6), // Arka planı yarı saydam yap
              title: Text(
                'Çıkış yapmak istediğinizden emin misiniz?',
                style: TextStyle(fontSize: 14, color: Colors.white), // Font boyutunu küçült
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // "Hayır" diyerek dialog'u kapat
                  },
                  child: Text(
                    'Hayır',
                    style: TextStyle(fontSize: 12, color: Colors.white), // Font boyutunu küçült
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // "Evet" diyerek dialog'u kapat
                  },
                  child: Text(
                    'Evet',
                    style: TextStyle(fontSize: 12, color: Colors.white), // Font boyutunu küçült
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Kullanıcı onay verdiyse çıkış işlemi yapılacak
    if (confirmed ?? false) {
      await secureStorage.deleteAll(); // Secure storage'daki tüm verileri sil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged out and data cleared!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Login ekranına yönlendir
      );
    }
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
