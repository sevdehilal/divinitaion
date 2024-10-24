import 'dart:convert';

class FortuneForFortuneTeller {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? occupation;
  final String? maritalStatus;
  final List<String>? categories;
  final DateTime? createDate;
  final String? imageData1;
  final String? imageData2;
  final String? imageData3;

  FortuneForFortuneTeller({
     this.id,
     this.firstName,
     this.lastName,
    this.gender,
     this.occupation,
     this.maritalStatus,
     this.categories,
    this.createDate,
     this.imageData1,
     this.imageData2,
     this.imageData3,
  });

  factory FortuneForFortuneTeller.fromJson(Map<String, dynamic> json) {
    return FortuneForFortuneTeller(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      occupation: json['occupation'],
      maritalStatus: json['maritalStatus'],
      categories: List<String>.from(json['categories']),
      createDate: json['createDate'] != null ? DateTime.parse(json['createDate']) : null,
      imageData1: json['imageData1'],
      imageData2: json['imageData2'],
      imageData3: json['imageData3'],
    );
  }
}
