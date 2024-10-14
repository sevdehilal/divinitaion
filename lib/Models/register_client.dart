class User {
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime dateOfBirth;
  final String occupation;
  final String maritalStatus;
  final String userName;
  final String email;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.occupation,
    required this.maritalStatus,
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'dateofBirth': dateOfBirth.toIso8601String(),
      'occupation': occupation,
      'maritalStatus': maritalStatus,
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}
