import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/model/member.dart';
import 'package:uuid/uuid.dart';

class GroupService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createGroup(String receiverId, Group group) async {
    try {
      // Get the current user info from Firebase authentication
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      final String currentUserEmail =
          _firebaseAuth.currentUser!.email.toString();

      // Generate a UUID for the groupId
      String groupId = Uuid().v4();

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
        messages: [],
      );

      Member leaderUser = Member(
        uid: currentUserId,
        email: currentUserEmail,
      );

      newGroup.members
          .add(leaderUser.toMap()); // Assuming Member class has a toMap method

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

  Future<List<Group>> getUserGroups(String currentUserID, String currentUserEmail) async {
    List<Group> userGroups = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
          .collection('groups')
          .where('members', arrayContains: {
            'uid': currentUserID,
            'email': currentUserEmail
          })
          .get();

      querySnapshot.docs.forEach((doc) {
        Group group = Group(
          groupId: doc.id, // Use the document ID as the groupId
          leaderEmail: doc['leaderEmail'],
          leaderId: doc['leaderId'],
          groupName: doc['groupName'],
          groupAbout: doc['groupAbout'],
          groupLocation: doc['groupLocation'],
          groupMeet: doc['groupMeet'],
          groupStudy: doc['groupStudy'],
          public: doc['public'],
          members: List<Map<String, dynamic>>.from(doc['members']),
          messages: List<Map<String, dynamic>>.from(doc['messages']),
        );
        userGroups.add(group);
      });
    } catch (e) {
      print('Error fetching user groups: $e');
    }

    return userGroups;
  }

  Future<List<Group>> getPublicGroups() async {
    List<Group> userGroups = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
        .collection('groups')
        .where('public', isEqualTo: true)
        .get();

      querySnapshot.docs.forEach((doc) {
        Group group = Group(
          groupId: doc.id, // Use the document ID as the groupId
          leaderEmail: doc['leaderEmail'],
          leaderId: doc['leaderId'],
          groupName: doc['groupName'],
          groupAbout: doc['groupAbout'],
          groupLocation: doc['groupLocation'],
          groupMeet: doc['groupMeet'],
          groupStudy: doc['groupStudy'],
          public: doc['public'],
          members: List<Map<String, dynamic>>.from(doc['members']),
          messages: List<Map<String, dynamic>>.from(doc['messages']),
        );
        userGroups.add(group);
      });
    } catch (e) {
      print('Error fetching user groups: $e');
    }

    return userGroups;
  }
}
