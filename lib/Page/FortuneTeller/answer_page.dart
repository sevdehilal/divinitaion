import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Page/FortuneTeller/answer_input_page.dart';
import 'package:intl/intl.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';

class AnswerPage extends StatelessWidget {
  final FortuneForFortuneTeller fortune;

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
    double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${fortune.firstName} ${fortune.lastName}'),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.3),
      body: BackgroundContainer(
        child: Padding(
          padding: EdgeInsets.only(
            top: appBarHeight + 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.black.withOpacity(0.5),
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
                          'Telveden Manzaralar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Divider(color: Colors.white, thickness: 1),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.black.withOpacity(0.5),
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
                            'Fal meraklısı',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Divider(color: Colors.white, thickness: 1),
                          Row(
                            children: [
                              Icon(Icons.family_restroom, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Medeni Hal: ${fortune.maritalStatus}',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.work, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Meslek: ${fortune.occupation}',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.accessibility, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Cinsiyet: ${fortune.gender}',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Doğum Tarihi: ${fortune.dateOfBirth != null ? DateFormat('dd/MM/yyyy').format(fortune.dateOfBirth?.toLocal() ?? DateTime.now()) : "?"}',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Kategoriler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Divider(color: Colors.white, thickness: 1),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: fortune.categories!
                                .map(
                                  (category) => Chip(
                                    label: Text(category,
                                        style: TextStyle(color: Color.fromARGB(255, 43, 0, 0))),
                                    backgroundColor: Colors.white,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                fortune.answer != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.black.withOpacity(0.5),
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
                                  'Fal',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Divider(color: Colors.white, thickness: 1),
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      '${fortune.answer}',
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnswerInputPage(fortune: fortune),
                                  ),
                                );
                              },
                              child: Text(
                                'Hemen Cevap Ver',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
