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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateofBirth']),
      occupation: json['occupation'] as String,
      maritalStatus: json['maritalStatus'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

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
