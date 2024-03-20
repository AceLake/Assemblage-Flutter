class Member {
  final String uid;
  final String email;

  Member({required this.uid, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
