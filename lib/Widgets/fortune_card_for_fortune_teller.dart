import 'dart:io';
import 'package:divinitaion/Models/fortune_entity.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FortuneCardForFortuneTeller extends StatefulWidget {
  final int userId; // User ID
  final String date; // Date
  final List<PlatformFile> photos; // List of PlatformFile objects

  const FortuneCardForFortuneTeller({
    Key? key,
    required this.userId,
    required this.date,
    required this.photos,
  }) : super(key: key);

  @override
  _FortuneCardForFortuneTellerState createState() => _FortuneCardForFortuneTellerState();
}

class _FortuneCardForFortuneTellerState extends State<FortuneCardForFortuneTeller> {
  bool isChecked = false;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bekleyen Fallar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 70, 70, 68),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          height: 200, // Adjusted height for images
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display the photos
                  SizedBox(
                    width: 100, // Fixed width for images
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.photos.map((photo) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: ClipOval(
                            child: Image.file(
                              File(photo.path!),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey, // Placeholder for error
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text('User: ${widget.userId}'), // Display user ID
                        Text('Tarih: ${widget.date}'), // Display date
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
