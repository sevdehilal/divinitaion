import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  CustomScaffold({
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Body'nin altına uzanmasını sağlar
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          // Arka plan resmi
          Positioned.fill(
            child: Image.asset(
              'lib/assets/background.png', // Arka plan resmi
              fit: BoxFit.cover, // Tam ekran boyutunda yerleştirir
            ),
          ),
          body, // Sayfa içeriği
        ],
      ),
    );
  }
}
