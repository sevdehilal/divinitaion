import 'dart:convert';

import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  final FortuneForFortuneTeller fortune;
  final ApiService _apiService = ApiService();
  final TextEditingController _answerController = TextEditingController();

  AnswerPage({required this.fortune});

  Widget _buildImage(String base64Image) {
    return Image.memory(
      base64Decode(base64Image),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${fortune.firstName} ${fortune.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildImage(fortune.imageData1!),
            SizedBox(height: 10),
            _buildImage(fortune.imageData2!),
            SizedBox(height: 10),
            _buildImage(fortune.imageData3!),
            SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Enter your answer',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _apiService.sendAnswer(fortune.id!, _answerController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Answer sent successfully')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send answer')));
                }
              },
              child: Text('Send Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
