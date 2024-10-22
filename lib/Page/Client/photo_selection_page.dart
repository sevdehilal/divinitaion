import 'dart:io';
import 'package:divinitaion/Page/Client/client_fortune_telling_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart'; // Import your model

class PhotoSelectionPage extends StatefulWidget {
  final FortuneTeller fortuneTeller; // Add this line

  PhotoSelectionPage({required this.fortuneTeller}); // Update the constructor

  @override
  _PhotoSelectionPageState createState() => _PhotoSelectionPageState();
}

class _PhotoSelectionPageState extends State<PhotoSelectionPage> {
  List<PlatformFile> _selectedFiles = [];

  Future<void> _pickImage() async {
    if (_selectedFiles.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only select up to 3 photos.')),
      );
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFiles.add(result.files.first);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
  }

  void _goToSelectedImagesPage() {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No images selected.')),
      );
      return;
    }
    // Here, you can navigate to the next page and pass the fortuneTeller model
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FortuneTellingPage(
          firstName: widget.fortuneTeller.firstName,
          lastName: widget.fortuneTeller.lastName,
          selectedFiles: _selectedFiles, // Pass selected files here
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Photos'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: _goToSelectedImagesPage,
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Select Photo'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _selectedFiles.isEmpty
                ? Center(child: Text('No photos selected.'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: _selectedFiles.length,
                    itemBuilder: (context, index) {
                      if (kIsWeb) {
                        return Image.memory(
                          _selectedFiles[index].bytes!,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Image.file(
                          File(_selectedFiles[index].path!),
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
