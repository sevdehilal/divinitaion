import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyHomePage extends StatelessWidget {
  // Hashtagsiz metin paylaşımı
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Paylaşımı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Hashtagsiz Paylaşım Butonu
            ElevatedButton(
              onPressed: () async {
                await Share.share('asdasd');
              },
              child: Text('Twitter\'da Paylaş (Hashtagsiz)'),
            ),
          ],
        ),
      ),
    );
  }
}
