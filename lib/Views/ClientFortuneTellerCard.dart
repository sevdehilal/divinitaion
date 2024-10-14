import 'package:flutter/material.dart';

class CustomFortuneTellerCard extends StatelessWidget {
  final String fortuneTellerName;
  final int rating; // Puan
  final int balance; // Altın miktarı

  CustomFortuneTellerCard({
    required this.fortuneTellerName,
    required this.rating,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fortuneTellerName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 5),
                Text(
                  '$rating Puan',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.yellow),
                SizedBox(width: 5),
                Text(
                  '$balance Altın',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Fal baktırma işlemi
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$fortuneTellerName için fal baktırıldı!')),
                );
              },
              child: Text('Fal Baktır'),
            ),
          ],
        ),
      ),
    );
  }
}
