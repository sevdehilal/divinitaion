class FortuneTeller {
  final int? id;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? experience;
  final String? userName;
  final String? email;
  final String? password;

  FortuneTeller({
    this.id,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.experience,
    this.userName,
    this.email,
    this.password,
  });

  factory FortuneTeller.fromJson(Map<String, dynamic> json) {
    return FortuneTeller(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'experience': experience,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}
