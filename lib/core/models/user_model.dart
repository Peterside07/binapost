class UserModel {
  final String userId;
  final String username;
  final String name;
  final String bio;
  final String photo;

  UserModel({
    required this.userId,
    required this.username,
    required this.name,
    required this.bio,
    required this.photo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      photo: map['photo'] ?? '',
    );
  }
}
