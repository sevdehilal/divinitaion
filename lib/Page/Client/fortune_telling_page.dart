import 'dart:ui';
import 'dart:io';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/ClientWidgets/fortune_categories_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FortuneTellingPage extends StatefulWidget {
  final FortuneTeller fortuneTeller;
  final List<PlatformFile> selectedFiles;

  FortuneTellingPage({
    required this.fortuneTeller,
    required this.selectedFiles,
  });

  @override
  _FortuneTellingPageState createState() => _FortuneTellingPageState();
}

class _FortuneTellingPageState extends State<FortuneTellingPage> {
  int? selectedTopic1Index;
  int? selectedTopic2Index;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTextWithBackground(String text, TextStyle style) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Falcı Bilgileri'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextWithBackground(
                'Falcı',
                TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
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
                            'https://via.placeholder.com/100'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.fortuneTeller.firstName} ${widget.fortuneTeller.lastName}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text('4.5', style: TextStyle(fontSize: 16)),
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
              _buildTextWithBackground(
                'Merak Ettiğin Konular:',
                TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
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
                      FortuneCategoriesDropdown(
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedTopic1Index = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      FortuneCategoriesDropdown(
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedTopic2Index = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTextWithBackground(
                'Fotoğraflar:',
                TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
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
                                    ? Image.memory(file.bytes!,
                                        width: 100, height: 100)
                                    : Image.file(File(file.path!),
                                        width: 100, height: 100);
                              }).toList()
                            : [
                                Text(
                                  'No images selected.',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    List<int> categoryIds = [];
                    if (selectedTopic1Index != null) {
                      categoryIds.add(1);
                    }
                    if (selectedTopic2Index != null) {
                      categoryIds.add(1);
                    }

                    PlatformFile? photo1 = widget.selectedFiles.length > 0
                        ? widget.selectedFiles[0]
                        : null;
                    PlatformFile? photo2 = widget.selectedFiles.length > 1
                        ? widget.selectedFiles[1]
                        : null;
                    PlatformFile? photo3 = widget.selectedFiles.length > 2
                        ? widget.selectedFiles[2]
                        : null;

                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final int? id = prefs.getInt('id');
                    bool success = await _apiService.saveFortune(
                      clientId: id,
                      fortunetellerId: widget.fortuneTeller.id,
                      categoryIds: categoryIds,
                      photo1: photo1!,
                      photo2: photo2!,
                      photo3: photo3!,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Fortune successfully saved!')));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to save fortune.')));
                    }
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
      ),
    );
  }
}
