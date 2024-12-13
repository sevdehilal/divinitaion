import 'dart:io';
import 'package:divinitaion/AuthGoogle/login.dart';
import 'package:divinitaion/Page/Common/welcome.dart';
import 'package:divinitaion/Services/twitter.dart';
import 'package:divinitaion/Widgets/ClientWidgets/client_navigation_bar.dart';
import 'package:divinitaion/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //MobileAds.instance.initialize();
  runApp(MaterialApp(
    home: GoogleSignInScreen(),
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
