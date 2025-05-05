import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String fullName;
  final String university;
  final String userId;

  UserModel(
      {required this.email,
      required this.fullName,
      required this.university,
      required this.userId});

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      university: data['university'] ?? '',
      userId: document.id,
    );
  }
}
