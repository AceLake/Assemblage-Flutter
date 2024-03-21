import 'package:messaging_app/model/message.dart';

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
  final List<Map<String, dynamic>> members;
  final List<Map<String, dynamic>> messages;

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
    required this.messages,
  });

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
      'members': members.map((member) => member).toList(),
      'messages': members.map((message) => message).toList(),
    };
  }

  Group.fromMap(Map<String, dynamic> map)
      : groupId = map['groupId'],
        leaderEmail = map['leaderEmail'],
        leaderId = map['leaderId'],
        groupName = map['groupName'],
        groupAbout = map['groupAbout'],
        groupLocation = map['groupLocation'],
        groupMeet = map['groupMeet'],
        groupStudy = map['groupStudy'],
        public = map['public'],
        members = List<Map<String, dynamic>>.from(map['members']),
        messages = List<Map<String, dynamic>>.from(map['messages']);
}
