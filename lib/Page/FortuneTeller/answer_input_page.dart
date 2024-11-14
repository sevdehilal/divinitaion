import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

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
        title: Text('${fortune.firstName} ${fortune.lastName} telveleri için...'),
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Telveden manzaralar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildImage(context, fortune.imageData1!),
                  _buildImage(context, fortune.imageData2!),
                  _buildImage(context, fortune.imageData3!),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _answerController,
                maxLines: 17,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Gördüklerini yaz...',
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_answerController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Boş geçemezsin!'),
                      ));
                      return;
                    }

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
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('An error occurred: $e'),
                      ));
                    }
                  },
                  child: Text('Cevabı Gönder'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 24, 18, 20), backgroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
