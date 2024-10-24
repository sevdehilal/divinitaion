import 'dart:convert';
import 'dart:typed_data';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:file_picker/file_picker.dart';

class Fortune {
  final int? id;
  final int fortuneTellerId;
  final int userId;
  final String? answer;
  final List<PlatformFile> photos;
  final String date;

  Fortune({
    this.id,
    required this.fortuneTellerId,
    required this.userId,
    this.answer,
    required this.photos,
    required this.date,
  });

  factory Fortune.fromJson(Map<String, dynamic> json) {
    // Parse photos from base64 strings
    List<PlatformFile> photoList = [];
    for (int i = 1; i <= 3; i++) {
      String key = 'photo$i';
      if (json.containsKey(key)) {
        String? photoBase64 = json[key];
        if (photoBase64 != null && photoBase64.isNotEmpty) {
          try {
            // Convert base64 to bytes
            List<int> bytes = base64Decode(photoBase64);
            // Create PlatformFile object
            photoList.add(
              PlatformFile(
                name: 'photo$i.jpg',
                size: bytes.length,
                bytes: Uint8List.fromList(bytes), // Convert List<int> to Uint8List
              ),
            );
          } catch (e) {
            print('Failed to decode base64 for $key: $e');
          }
        }
      }
    }

    return Fortune(
      id: json['id'] as int?,
      fortuneTellerId: json['fortuneTellerId'] as int,
      userId: json['userId'] as int,
      answer: json['answer'] as String?,
      photos: photoList,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fortuneTellerId': fortuneTellerId,
      'userId': userId,
      'answer': answer,
      'photos': photos.map((photo) => base64Encode(photo.bytes!)).toList(),
      'date': date,
    };
  }
}
