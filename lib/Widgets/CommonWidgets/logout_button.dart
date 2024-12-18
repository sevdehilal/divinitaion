import 'package:divinitaion/Page/Common/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:ui';

class LogoutButton extends StatelessWidget {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> _logoutAndClearData(BuildContext context) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.6),
              title: Text(
                'Çıkış yapmak istediğinizden emin misiniz?',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Hayır',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Evet',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed ?? false) {
      await secureStorage.deleteAll();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged out and data cleared!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _logoutAndClearData(context),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Logout',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
