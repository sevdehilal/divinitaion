import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  final int id; // ID parametresi dışarıdan alınacak

  EmailVerificationPage({required this.id});

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _isLoading = false;

  // API'ye ID gönderme fonksiyonu
  Future<void> _verifyId() async {
    setState(() {
      _isLoading = true;
    });

    try {
      ApiService apiService = ApiService();
      await apiService.verifyId(widget.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ID başarıyla doğrulandı!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-posta Doğrulama'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ID doğrulaması yapılacak',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyId,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Doğrulama İsteği Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
