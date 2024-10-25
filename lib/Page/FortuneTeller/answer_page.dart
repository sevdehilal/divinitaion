import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  final FortuneForFortuneTeller fortune;
  final ApiService _apiService = ApiService();
  final TextEditingController _answerController = TextEditingController();

  AnswerPage({required this.fortune});

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
        title: Text('${fortune.firstName} ${fortune.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Birth Date: ${fortune.gender}'),
              Text('Marital Status: ${fortune.maritalStatus}'),
              Text('Occupation: ${fortune.occupation}'),
              SizedBox(height: 20),
              Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: fortune.categories!
                    .map((category) => Chip(
                          label: Text(category),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              ExpansionTile(
                title: Text(
                  'Photos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildImage(context, fortune.imageData1!),
                      _buildImage(context, fortune.imageData2!),
                      _buildImage(context, fortune.imageData3!),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _answerController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Enter your answer',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Calling the sendAnswer function with the fortune's ID and user's input
                      bool success = await _apiService.sendAnswer(
                        fortuneId: fortune.id, 
                        answer: _answerController.text
                      );

                      // Display appropriate feedback based on success or failure
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Answer sent successfully'))
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to send answer'))
                        );
                      }
                    } catch (e) {
                      // Handling any exceptions that might occur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred: $e'))
                      );
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
      ),
    );
  }
}
