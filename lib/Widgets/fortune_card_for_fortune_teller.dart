import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';

class FortuneCardForFortuneTeller extends StatelessWidget {
  final FortuneForFortuneTeller fortune;

  const FortuneCardForFortuneTeller({
    Key? key,
    required this.fortune,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${fortune.firstName ?? ''} ${fortune.lastName ?? ''}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Categories: ${fortune.categories?.join(", ") ?? 'N/A'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${fortune.createDate?.toLocal().toString().split(' ')[0] ?? 'Unknown'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
