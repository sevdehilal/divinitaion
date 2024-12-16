import 'dart:io';
import 'package:divinitaion/Page/Client/fortune_telling_page.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:image_picker/image_picker.dart';

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

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );

    if (source == null) {
      return;
    }

    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        // Senkron olmayan işlemi `setState` dışına al
        final fileBytes = kIsWeb ? await pickedFile.readAsBytes() : null;
        final fileSize = File(pickedFile.path).lengthSync();

        setState(() {
          _selectedFiles.add(
            PlatformFile(
              path: pickedFile.path,
              name: pickedFile.name,
              size: fileSize,
              bytes: fileBytes,
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fotoğraf seçilmedi.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fotoğraf seçilirken bir hata oluştu: $e')),
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
      body: Stack(
        children: [
          BackgroundContainer(
            child: Column(
              children: [
                SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OutlinedButton(
                    onPressed: _pickImage,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Kahve Telvelerini Seç',
                      style: TextStyle(color: Colors.white),
                    ),
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
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: kIsWeb
                                      ? Image.memory(
                                          _selectedFiles[index].bytes!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : Image.file(
                                          File(_selectedFiles[index].path!),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text(
                'Fotoğraf Seç',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              backgroundColor: Colors.black.withOpacity(0.3),
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToSelectedImagesPage,
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_forward, color: Colors.black),
      ),
    );
  }
}
