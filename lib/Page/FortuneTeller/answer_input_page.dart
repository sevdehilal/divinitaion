import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';

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
    double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${fortune.firstName} ${fortune.lastName} telveleri için...'),
        backgroundColor: Colors.black.withOpacity(0.2),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.2),
      body: BackgroundContainer(
        child: SingleChildScrollView( 
          child: Padding(
            padding: EdgeInsets.only(
            top: appBarHeight + 26.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
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
                  child: OutlinedButton(
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
                    child: Text('Cevabı Gönder',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
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
