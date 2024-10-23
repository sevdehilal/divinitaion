import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:file_picker/file_picker.dart';

class Fortune {
  final int? id;
  final FortuneTeller fortuneTeller;
  final User user;
  final String? answer;
  final List<PlatformFile> photos;
  final DateTime date;

  Fortune({
    this.id,
    required this.fortuneTeller,
    required this.user,
    this.answer,
    required this.photos,
    required this.date,
  });

  factory Fortune.fromJson(Map<String, dynamic> json) {
    return Fortune(
      id: json['id'],
      fortuneTeller: json['fortuneTeller'],
      user: json['user'],
      answer: json['answer'],
      photos: json['photos'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fortuneTeller': fortuneTeller,
      'user': user,
      'answer': answer,
      'photos': photos,
      'date': date.toIso8601String(),
    };
  }
}
