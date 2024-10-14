import 'package:divinitaion/Views/ClientFortuneTellerCard.dart';
import 'package:flutter/material.dart';

class CustomFortuneTellerList extends StatelessWidget {
  final List<Map<String, dynamic>> fortuneTellers = [
    {'name': 'Falci A', 'rating': 5, 'balance': 100},
    {'name': 'Falci B', 'rating': 4, 'balance': 80},
    {'name': 'Falci C', 'rating': 3, 'balance': 60},
    {'name': 'Falci D', 'rating': 5, 'balance': 120},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Falcı Listesi'),
      ),
      body: ListView.builder(
        itemCount: fortuneTellers.length,
        itemBuilder: (context, index) {
          final fortuneTeller = fortuneTellers[index];
          return CustomFortuneTellerCard(
            fortuneTellerName: fortuneTeller['name'],
            rating: fortuneTeller['rating'],
            balance: fortuneTeller['balance'],
          );
        },
      ),
    );
  }
}
