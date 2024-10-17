import 'package:divinitaion/Page/Client/client_fortune_teller_list.dart';
import 'package:divinitaion/Page/Common/login.dart';
import 'package:divinitaion/Widgets/client_fortune_teller_card.dart';
import 'package:divinitaion/Widgets/fortune_teller_navigation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WelcomePage extends StatelessWidget {
  final storage = const FlutterSecureStorage();

  WelcomePage({super.key});

  Future<String> isLoggedIn() async {
    String? loggedInRole = await storage.read(key: 'loggedInAs');
    if (loggedInRole == "client") {
      return "client";
    }
    if (loggedInRole == "fortuneteller") {
      return "fortuneteller";
    }
    if (loggedInRole == "") {
      return "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          String? loggedInRole = snapshot.data;
          if (loggedInRole == "client") {
            return ClientFortuneTellerList();
          }
          if (loggedInRole == "fortuneteller") {
            return FortuneTellerBottomNavigation();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
