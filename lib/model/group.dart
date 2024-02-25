import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/model/member.dart';

class Group {
  final String groupId;
  final String leaderEmail;
  final String leaderId;
  final String groupName;
  final String groupAbout;
  final String groupLocation;
  final String groupMeet;
  final String groupStudy;
  final bool public;
  final List<Member> members;


  Group({
    required this.groupId,
    required this.leaderEmail,
    required this.leaderId,
    required this.groupName,
    required this.groupAbout,
    required this.groupLocation,
    required this.groupMeet,
    required this.groupStudy,
    required this.public,
    required this.members,
  });

  // We need to convert it to a map becouse that is how information is
  // Stored in firebase
  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'leaderEmail': leaderEmail,
      'leaderId': leaderId,
      'groupName': groupName,
      'groupAbout': groupAbout,
      'groupLocation': groupLocation,
      'groupMeet': groupMeet,
      'groupStudy': groupStudy,
      'public': public,
      'members': members.map((member) => member.toMap()).toList(),
    };
  }
}