import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_input_page.dart';

class AnswerPage extends StatelessWidget {
  final FortuneForFortuneTeller fortune;
  final ApiService _apiService = ApiService();

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
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Color.fromARGB(255, 24, 18, 20),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fotoğraflar Kartı
              Card(
                color: Color.fromARGB(255, 42, 30, 34),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      SizedBox(height: 10),
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
                ),
              ),
              SizedBox(height: 20),
              // Kullanıcı Bilgileri Kartı - Alta Alındı
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Color.fromARGB(255, 42, 30, 34),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Divider(color: Colors.white, thickness: 1),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.family_restroom, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Marital Status: ${fortune.maritalStatus}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.work, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Occupation: ${fortune.occupation}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.accessibility, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Gender: ${fortune.gender}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Birth Date: ${fortune.dateOfBirth}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Divider(color: Colors.white, thickness: 1),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: fortune.categories!
                              .map(
                                (category) => Chip(
                                  label: Text(category,
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: Colors.blueAccent,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Cevap Girişi Butonu
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerInputPage(fortune: fortune),
                      ),
                    );
                  },
                  child: Text('Enter Your Answer'),
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
