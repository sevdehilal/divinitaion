class GoogleUser {
  final String googleId;
  final String email;
  final String firstName;
  final String lastName;

  // Constructor
  GoogleUser({
    required this.googleId,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  // fromJson methodu (eğer gelen JSON verisini parse etmeniz gerekirse)
  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
      googleId: json['googleId'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  // toJson methodu (JSON formatına dönüştürme)
  Map<String, dynamic> toJson() {
    return {
      'googleId': googleId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
