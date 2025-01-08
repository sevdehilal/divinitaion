import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ScreenshotSharePage extends StatefulWidget {
  @override
  _ScreenshotSharePageState createState() => _ScreenshotSharePageState();
}

class _ScreenshotSharePageState extends State<ScreenshotSharePage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _takeScreenshotAndShare() async {
    try {
      final image = await _screenshotController.capture();

      if (image != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = File('${directory.path}/screenshot.png');

        await imagePath.writeAsBytes(image);

        await Share.shareXFiles([XFile(imagePath.path)], text: 'Great picture');
      } else {
        print('Ekran görüntüsü alınamadı!');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ekran Görüntüsü Al ve Paylaş'),
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Text(
                  'Bu fal yorumunuzdur. Şansınız açık olsun!',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _takeScreenshotAndShare,
                child: Text('Paylaş'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
