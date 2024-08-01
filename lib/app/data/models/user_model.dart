import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String? photoUrl;
  String? phoneNumber;
  String email;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    this.photoUrl,
    this.phoneNumber,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      id: snapshot['id'] as String,
      name: snapshot['name'] as String,
      photoUrl:
          snapshot['photoUrl'] != null ? snapshot['photoUrl'] as String : null,
      phoneNumber: snapshot['phoneNumber'] != null
          ? snapshot['phoneNumber'] as String
          : null,
      email: snapshot['email'] as String,
      createdAt: (snapshot['createdAt'] as Timestamp).toDate(),
    );
  }
}
