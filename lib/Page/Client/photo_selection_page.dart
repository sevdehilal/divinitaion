import 'dart:io';
import 'package:divinitaion/Page/Client/fortune_telling_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';

class PhotoSelectionPage extends StatefulWidget {
  final FortuneTeller fortuneTeller;

  PhotoSelectionPage({required this.fortuneTeller});

  @override
  _PhotoSelectionPageState createState() => _PhotoSelectionPageState();
}

class _PhotoSelectionPageState extends State<PhotoSelectionPage> {
  List<PlatformFile> _selectedFiles = [];

  Future<void> _pickImage() async {
    if (_selectedFiles.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yalnızca 3 fotoğraf seçilebilir.')),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFiles.addAll(result.files.take(3 - _selectedFiles.length));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dosya seçmelisiniz.')),
      );
    }
  }

  void _goToSelectedImagesPage() {
    if (_selectedFiles.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('En az 3 fotoğraf seçmelisiniz.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FortuneTellingPage(
          fortuneTeller: widget.fortuneTeller,
          selectedFiles: _selectedFiles,
        ),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotoğraf Seç', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 24, 18, 20),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: _goToSelectedImagesPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 24, 18, 20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: _pickImage,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Kahve Telvelerini Seç',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: _selectedFiles.isEmpty
                        ? Center(
                            child: Text(
                              'Fotoğraf seçilmedi',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemCount: _selectedFiles.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  if (kIsWeb)
                                    Image.memory(
                                      _selectedFiles[index].bytes!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )
                                  else
                                    Image.file(
                                      File(_selectedFiles[index].path!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  Positioned(
                                    top: -8,
                                    right: -8,
                                    child: IconButton(
                                      icon: Icon(Icons.remove_circle, color: Colors.red),
                                      onPressed: () => _removeImage(index),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
