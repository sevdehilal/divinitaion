class FortuneTeller {
  final int? id;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? experience;
  final String? userName;
  final String? email;
  final String? password;
  final num? rating;
  final int? requirementCredit;
  final int? totalCredit;

  FortuneTeller({
    this.id,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.experience,
    this.userName,
    this.email,
    this.password,
    this.rating,
    this.requirementCredit,
    this.totalCredit,
  });

  factory FortuneTeller.fromJson(Map<String, dynamic> json) {
    return FortuneTeller(
      id: json['id'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      experience: json['experience'],
      rating: json['rating'],
      requirementCredit: json['requirementCredit'],
      totalCredit: json['totalCredit'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'experience': experience,
      'userName': userName,
      'email': email,
      'password': password,
      'rating': rating,
      'requirementCredit': requirementCredit,
      'totalCredit': totalCredit,
    };
  }
}
