class FortuneTeller {
  final int? id;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? experience;
  final String? userName;
  final String? email;
  final String? password;
  final double? rating;
  final int? requirementCredit;

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
  });

  factory FortuneTeller.fromJson(Map<String, dynamic> json) {
    return FortuneTeller(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      rating: json['rating'],
      requirementCredit: json['requirementCredit'],
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
    };
  }
}
