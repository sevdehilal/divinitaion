import 'package:divinitaion/Models/fortune_list.dart';
import 'package:flutter/material.dart';

class FortuneAnswerPage extends StatelessWidget {
  final FortuneListt fortune;

  const FortuneAnswerPage({Key? key, required this.fortune}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortune Answer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the categories as a comma-separated list
            Text(
              'Categories: ${fortune.categories?.join(', ') ?? 'No categories available'}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Display the creation date
            Text(
              'Create Date: ${fortune.createDate}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),

            // Divider
            const Divider(),

            // Large area for the fortune answer
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    fortune.answer ?? 'No answer provided.',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
