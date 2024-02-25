import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/model/member.dart';

class GroupService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createGroup(String receiverId, Group group) async {
    try {
      // Get the current user info from Firebase authentication
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();

      List<String> ids = [currentUserId, group.groupName];
      ids.sort();
      String groupId = ids.join("_");
      // Create a new group
      Group newGroup = Group(
        groupId: groupId,
        leaderEmail: currentUserEmail,
        leaderId: currentUserId,
        groupName: group.groupName,
        groupAbout: group.groupAbout,
        groupLocation: group.groupLocation,
        groupMeet: group.groupMeet,
        groupStudy: group.groupStudy,
        public: group.public,
        members: group.members,
      );

      Member leaderUser = Member(
        uid: currentUserId,
        email: currentUserEmail,
      );

      newGroup.members.add(leaderUser);

      //newGroup.members.add(value)
      // Construct group ID from current user ID and group name to ensure uniqueness

      // Get a reference to the Firestore collection
      CollectionReference groupCollection = _fireStore.collection('groups');

      // Set the new group document with the generated ID
      await groupCollection.doc(groupId).set(newGroup.toMap());

    } catch (e) {
      // Handle errors
      print('Error creating group: $e');
    }
  }
}