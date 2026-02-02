class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, String> toMap() {
    return {
      "name": name,
      "mail": email,
      "pass": password,
    };
  }

  factory UserModel.fromMap(Map<String, String> map) {
    return UserModel(
      name: map["name"] ?? "",
      email: map["mail"] ?? "",
      password: map["pass"] ?? "",
    );
  }
}
