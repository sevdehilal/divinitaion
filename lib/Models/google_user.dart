class GoogleUser {
  final String googleId;
  final String email;
  final String firstName;
  final String lastName;

  GoogleUser({
    required this.googleId,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
      googleId: json['googleId'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'googleId': googleId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
