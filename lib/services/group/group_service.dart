import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/model/member.dart';
import 'package:uuid/uuid.dart';

import '../../model/message.dart';

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

  Future<List<Group>> getUserGroups(
      String currentUserID, String currentUserEmail) async {
    List<Group> userGroups = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
          .collection('groups')
          .where('members', arrayContains: {
        'uid': currentUserID,
        'email': currentUserEmail
      }).get();

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
    // Send Message

    return userGroups;
  }

  Future<void> sendMessage(String groupId, String senderId, String senderEmail,
      String message) async {
    try {
      final Timestamp timestamp = Timestamp.now();
      // Generate a UUID for the groupId
      String messageId = Uuid().v4();
      // Create a new message
      Message newMessage = Message(
        messageId: messageId,
        senderId: senderId,
        senderEmail: senderEmail,
        message: message,
        timestamp: timestamp,
      );

      // Add the new message to the group's messages collection
      await _fireStore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .add(newMessage.toMap());
    } catch (e) {
      print('Error sending message: $e');
      // Handle the error accordingly
    }
  }

  // Get Messages
  Stream<QuerySnapshot> getMessages(String groupId) {
    return _fireStore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void deleteMessage(String groupId, String messageId) async {
    try {
      // Query for the message document by message ID
      QuerySnapshot querySnapshot = await _fireStore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .where('messageId', isEqualTo: messageId)
          .get();

      // Check if the message document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the message document
        String documentId = querySnapshot.docs.first.id;

        // Delete the message document using its document ID
        await _fireStore
            .collection('groups')
            .doc(groupId)
            .collection('messages')
            .doc(documentId)
            .delete();
      } else {
        print('Message not found.');
        // Handle the case where the message document is not found
      }
    } catch (e) {
      print('Error deleting message: $e');
      // Handle the error appropriately
    }
  }

  Future<bool> isCurrentUserMember(String groupId) async {
    try {
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      // Get the group document from Firestore
      DocumentSnapshot groupSnapshot = await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .get();

      // Check if the group exists
      if (groupSnapshot.exists) {
        // Get the data from the group document
        Map<String, dynamic>? groupData =
            groupSnapshot.data() as Map<String, dynamic>?;

        // Check if groupData is not null and contains the 'members' field
        if (groupData != null && groupData.containsKey('members')) {
          List<dynamic> members = groupData['members'];

          // Check if the current user's UID exists in the 'members' list
          return members.any((member) => member['uid'] == currentUserId);
        }
      }
      // Return false if the group does not exist or if the 'members' field is missing
      return false;
    } catch (e) {
      print('Error checking user membership: $e');
      return false; // Return false in case of an error
    }
  }

  Future<void> addCurrentUserToGroup(String groupId) async {
    try {
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      final String currentUserEmail =
          _firebaseAuth.currentUser!.email.toString();

      // Get the group document reference
      DocumentReference groupRef = _fireStore.collection('groups').doc(groupId);

      // Update the 'members' array in the group document
      await groupRef.update({
        'members': FieldValue.arrayUnion([
          {'uid': currentUserId, 'email': currentUserEmail}
        ])
      });
    } catch (e) {
      print('Error adding current user to group: $e');
      // Handle the error accordingly
    }
  }

  removeUserFromGroup(String groupId, String userIdToRemove) async {
    
  }

  Future<bool> isCurrentUserGroupLeader(String groupId) async {
  try {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    // Get the group document from Firestore
    DocumentSnapshot groupSnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    // Check if the group exists
    if (groupSnapshot.exists) {
      Map<String, dynamic>? groupData =
          groupSnapshot.data() as Map<String, dynamic>?;

      // Check if the group data contains the 'leaderId' field
      if (groupData != null && groupData.containsKey('leaderId')) {
        String leaderId = groupData['leaderId'];

        // Return true if the current user is the group leader
        return leaderId == currentUserId;
      }
    }
    // Return false if the group does not exist or if the 'leaderId' field is missing
    return false;
  } catch (e) {
    print('Error checking user membership: $e');
    return false; // Return false in case of an error
  }
}

Future<List<String>> getGroupMembers(String groupId) async {
  try {
    // Fetch the group document from Firestore
    final groupDocSnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    // Check if the document exists and contains the 'members' field
    if (groupDocSnapshot.exists && groupDocSnapshot.data()?.containsKey('members') == true) {
      // Extract the 'members' field from the document data
      List<dynamic> membersList = groupDocSnapshot.data()?['members'];

      // Extract the user IDs from each member map and return them as a list
      List<String> memberEmails = membersList.map<String>((member) => member['email'] as String).toList();

      return memberEmails;
    } else {
      // If the document does not exist or does not contain 'members' field, return an empty list
      return [];
    }
  } catch (e) {
    // Handle errors if any
    print('Error fetching group members: $e');
    return []; // Return an empty list in case of errors
  }
}

  Future<void> editGroup(Group group) async {
    try {
      // Reference to the group document in Firestore
      DocumentReference groupRef = _fireStore.collection('groups').doc(group.groupId);

      // Update the group information in Firestore
      await groupRef.update({
        'groupName': group.groupName,
        'groupAbout': group.groupAbout,
        'groupLocation': group.groupLocation,
        'groupMeet': group.groupMeet,
        'groupStudy': group.groupStudy,
        'public': group.public,
        // Add other fields to update if needed
      });
    } catch (error) {
      // Handle any errors that occur during the update process
      print('Error updating group: $error');
      throw Exception('Failed to update group: $error');
    }
  }
}
