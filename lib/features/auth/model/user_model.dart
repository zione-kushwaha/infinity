import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String username;
  final String email;
  final String profilePic;
  final List subscriptions;
  final String userId;
  final List favorites;

  UserModel({
    required this.username,
    required this.email,
    required this.profilePic,
    required this.subscriptions,
    required this.favorites,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'subscriptions': subscriptions,
      'userId': userId,
      'favorites': favorites,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      subscriptions: List.from(map['subscriptions'] as List),
      userId: map['userId'] as String,
      favorites: List.from(map['favorites'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
