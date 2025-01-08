import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:divinitaion/Page/Common/login.dart';
import 'package:divinitaion/Widgets/ClientWidgets/client_navigation_bar.dart';
import 'package:divinitaion/Widgets/FortuneWidgets/fortune_teller_navigation_bar.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final storage = const FlutterSecureStorage();
  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSplashVisible = false;
      });
    });
  }

  Future<String> isLoggedIn() async {
    String? loggedInRole = await storage.read(key: 'loggedInAs');
    if (loggedInRole == "client") {
      return "client";
    }
    if (loggedInRole == "fortuneteller") {
      return "fortuneteller";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    if (_isSplashVisible) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ClipOval(
            child: Image.asset(
              'lib/assets/logo1.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

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
            return CustomBottomNavigation();
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
