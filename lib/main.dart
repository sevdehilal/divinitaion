import 'dart:io';
import 'package:divinitaion/Page/Common/welcome.dart';
import 'package:divinitaion/Services/twitter.dart';
import 'package:divinitaion/Widgets/ClientWidgets/client_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MaterialApp(
    home: WelcomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
