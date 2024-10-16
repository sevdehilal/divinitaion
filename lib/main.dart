import 'dart:io';
import 'package:divinitaion/Page/Common/email_verification.dart';
import 'package:divinitaion/Page/Common/login.dart';
import 'package:divinitaion/Page/Client/client_fortune_teller_list.dart';
import 'package:divinitaion/Widgets/client_button_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(home: CustomBottomNavigation()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
