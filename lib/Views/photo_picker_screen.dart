import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerScreen extends StatefulWidget {
  @override
  _PhotoPickerScreenState createState() => _PhotoPickerScreenState();
}

class _PhotoPickerScreenState extends State<PhotoPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File?> selectedImages = [null, null, null, null];

  Future<void> pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages[index] = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotoğraf Seç'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => pickImage(index),
            child: Container(
              color: Colors.grey[300],
              child: selectedImages[index] != null
                  ? Image.file(
                      selectedImages[index]!,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.add_a_photo, size: 50),
            ),
          );
        },
      ),
    );
  }
}
