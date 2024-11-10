import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_page.dart';

class AnswerInputPage extends StatelessWidget {
  final FortuneForFortuneTeller fortune;
  final TextEditingController _answerController = TextEditingController();
  final ApiService _apiService = ApiService();

  AnswerInputPage({required this.fortune});

  Widget _buildImage(BuildContext context, String base64Image) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Image.memory(
              base64Decode(base64Image),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.memory(
          base64Decode(base64Image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer for ${fortune.firstName} ${fortune.lastName}'),
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fotoğraflar Başlığı
            Text(
              'Photos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Fotoğraflar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildImage(context, fortune.imageData1!),
                _buildImage(context, fortune.imageData2!),
                _buildImage(context, fortune.imageData3!),
              ],
            ),
            SizedBox(height: 20),
            // Cevap Metin Alanı
            TextField(
              controller: _answerController,
              maxLines: 17,
              decoration: InputDecoration(
                labelText: 'Enter your answer',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            // Cevabı Gönder Butonu
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    bool success = await _apiService.sendAnswer(
                      fortuneId: fortune.id,
                      answer: _answerController.text,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Answer sent successfully'),
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to send answer'),
                      ));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('An error occurred: $e'),
                    ));
                  }
                },
                child: Text('Send Answer'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
