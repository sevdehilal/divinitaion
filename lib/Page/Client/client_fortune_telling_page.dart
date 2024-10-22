import 'dart:io';
import 'package:divinitaion/Page/Client/client_fortune_teller_list.dart';
import 'package:divinitaion/Page/Common/fortune_categories_page.dart';
import 'package:divinitaion/Page/Common/welcome.dart';
import 'package:divinitaion/Widgets/client_button_navigation.dart';
import 'package:divinitaion/Widgets/fortune_card.dart';
import 'package:divinitaion/Widgets/fortune_categories_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import for PlatformFile

class FortuneTellingPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final List<PlatformFile> selectedFiles; // Keep this line

  FortuneTellingPage({
    required this.firstName,
    required this.lastName,
    required this.selectedFiles, // Include selected files in the constructor
  });

  @override
  _FortuneTellingPageState createState() => _FortuneTellingPageState();
}

class _FortuneTellingPageState extends State<FortuneTellingPage> {
  int? selectedTopic1;
  int? selectedTopic2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Falcı Bilgileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Falcı adı ve puanı
            Text(
              'Falcı',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Falcı Kartı
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/100'), // Dummy image
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.firstName} ${widget.lastName}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('4.5', style: TextStyle(fontSize: 16)), // Static rating for now
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star_half, color: Colors.amber),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Merak ettiğin konular
            Text(
              'Merak Ettiğin Konular:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Merak Ettiğin Konular Kartı
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FortuneCategoriesDropdown 1
                    FortuneCategoriesDropdown(
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedTopic1 = newValue; // İlk seçilen konuyu güncelle
                        });
                      },
                    ),
                    SizedBox(height: 8),

                    // FortuneCategoriesDropdown 2
                    FortuneCategoriesDropdown(
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedTopic2 = newValue; // İkinci seçilen konuyu güncelle
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Fotoğraflar
            Text(
              'Fotoğraflar:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Fotoğraflar Kartı
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.selectedFiles.isNotEmpty
                          ? widget.selectedFiles.map((file) {
                              return kIsWeb
                                  ? Image.memory(file.bytes!, width: 100, height: 100)
                                  : Image.file(File(file.path!), width: 100, height: 100);
                            }).toList()
                          : [
                              Text('No images selected.', style: TextStyle(fontSize: 16)), // Feedback for empty state
                            ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Gönder Butonu
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fal gönderildi!')),
                  );
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomBottomNavigation(),
                      ),
                    );
                  });
                },
                child: Text('Gönder'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
