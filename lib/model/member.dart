// Modify the Member class to include the fromMap factory constructor
class Member {
  final String uid;
  final String email;

  Member({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      uid: map['uid'],
      email: map['email'],
    );
  }
}
