class UserModel {
  final String name;
  final String username;

  const UserModel({required this.name, required this.username});

  UserModel copyWith({String? name, String? username}) {
    return UserModel(
      name: name ?? this.name,
      username: username ?? this.username,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final String name = json['name'] as String;
    final String username = json['username'] as String;
    return UserModel(name: name, username: username);
  }
}
