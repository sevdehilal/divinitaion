class FortuneTeller {
  final String firstName;
  final String lastName;
  final String gender;
  final String experience;
  final String userName;
  final String email;
  final String password;

  FortuneTeller({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.experience,
    required this.userName,
    required this.email,
    required this.password,
  });

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
