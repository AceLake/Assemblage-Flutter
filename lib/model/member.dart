import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String uid;
  final String email;

  Member({
    required this.uid,
    required this.email,
  });

  // We need to convert it to a map becouse that is how information is
  // Stored in firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}