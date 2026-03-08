class User {
  final dynamic id;
  final String name;
  final String email;
  final String role;
  final String? token;
  final String? refreshToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Handle backend field names for name (firstName + lastName)
    String nameValue = json['name'] ?? '';
    if (nameValue.isEmpty && (json['firstName'] != null || json['lastName'] != null)) {
      nameValue = '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim();
    }

    return User(
      id: json['id'],
      name: nameValue,
      email: json['email'] ?? '',
      role: (json['role'] ?? 'staff').toString().toLowerCase(),
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
