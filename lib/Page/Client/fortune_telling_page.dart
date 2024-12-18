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
  bool _isButtonDisabled = false; 

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

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.toInt();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        ...List.generate(fullStars, (index) => Icon(Icons.star, color: Colors.amber)),
        if (hasHalfStar) Icon(Icons.star_half, color: Colors.amber),
        ...List.generate(emptyStars, (index) => Icon(Icons.star_border, color: Colors.amber)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Fal Detayları',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              _buildTextWithBackground(
                'Falcı',
                TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Card(
                color: Colors.black.withOpacity(0.5),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.fortuneTeller.firstName} ${widget.fortuneTeller.lastName}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      _buildRatingStars(widget.fortuneTeller.rating?.toDouble() ?? 0.0),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTextWithBackground(
                'Merak Ettiğin Konuları Seç... ',
                TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Card(
                color: Colors.black.withOpacity(0.5),
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
                'Fotoğraflar ',
                TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Card(
                color: Colors.black.withOpacity(0.5),
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
                                Text(
                                  'No images selected.',
                                  style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
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
                  onPressed: _isButtonDisabled ? null : () async {
                    setState(() {
                      _isButtonDisabled = true;
                    });

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

                    setState(() {
                      _isButtonDisabled = false;
                    });

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Fal başarıyla gönderildi!')));

                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Fal gönderirken hata oluştu! Lütfen tekrar deneyiniz.')));
                    }
                  },
                  child: _isButtonDisabled
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Gönder'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                    backgroundColor: Colors.black.withOpacity(0.5),
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
