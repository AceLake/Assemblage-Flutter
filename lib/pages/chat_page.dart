// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/components/chat_bubble.dart';
import 'package:messaging_app/components/my_text_field.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/model/member.dart';
import 'package:messaging_app/model/message.dart';
import 'package:messaging_app/pages/group_details.dart';
import 'package:messaging_app/pages/group_list.dart';
import 'package:messaging_app/services/group/group_service.dart';

class ChatPage extends StatefulWidget {
  final Group group;

  ChatPage({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final GroupService _groupService = GroupService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool editMode = false;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _groupService.sendMessage(
        widget.group.groupId,
        _firebaseAuth.currentUser!.uid,
        _firebaseAuth.currentUser!.email!,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.group.groupName),
        leading: IconButton(
            icon: Icon(
              Icons.navigate_before_rounded,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Group Details',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.info_outline, color: Colors.blue),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GroupDetailsPage(group: widget.group)),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Leave Chat',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.logout, color: Colors.red),
                ],
              ),
              onTap: () async {
                // Check if the current user is the leader
                if (widget.group.leaderId == _firebaseAuth.currentUser!.uid) {
                  // Fetch current members of the group
                  List<Map<String, dynamic>> members = widget.group.members;
                  List<Member> potentialLeaders = members
                      .map((memberMap) => Member.fromMap(memberMap))
                      .toList();

                  String currentUserUid = _firebaseAuth.currentUser!.uid;

                  potentialLeaders = potentialLeaders
                      .where((member) => member.uid != currentUserUid)
                      .map((member) =>
                          Member(uid: member.uid, email: member.email))
                      .toList();

                  String? newLeaderId = await showDialog<String>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Select New Leader'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: potentialLeaders.map((member) {
                            return ListTile(
                              title: Text(member.email),
                              onTap: () {
                                Navigator.pop(context, member.uid);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  );

                  if (newLeaderId != null) {
                    // Promote the selected member to leader
                    await _groupService.promoteToLeaderAndLeave(
                      widget.group.groupId,
                      newLeaderId,
                      _firebaseAuth.currentUser!.uid,
                    );

                    // Navigate to the MyGroupsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyGroupsPage()),
                    );

                    // Pop all routes until the first route (usually the home page)
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyGroupsPage()),
                    );
                  } else {
                    // If the current user is not the leader, just remove them from the group
                    await _groupService.removeUserFromGroup(
                      widget.group.groupId,
                      _firebaseAuth.currentUser!.uid,
                    );
                  }
                } else {
                  // If the current user is not the leader, just remove them from the group
                  await _groupService.removeUserFromGroup(
                    widget.group.groupId,
                    _firebaseAuth.currentUser!.uid,
                  );
                  // Navigate to the MyGroupsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyGroupsPage()),
                  );

                  // Pop all routes until the first route (usually the home page)
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyGroupsPage()),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          editMode
              ? _buildEditMessageInput()
              : _buildMessageInput(), // Conditional rendering based on editMode
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _groupService.getMessages(widget.group.groupId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

// Updated _buildMessageInput
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Type a message...',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildEditMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Edit your message...',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: () {
              editMode = false; // Exit edit mode when send button is pressed
              sendMessage(); // Call send message method to edit the message
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String senderId = data['senderId'];
    String senderEmail = data['senderEmail'];
    String message = data['message'];
    bool isCurrentUser = senderId == _firebaseAuth.currentUser!.uid;

    return GestureDetector(
      onLongPress: () {
        _showMessageOptions(context, document);
      },
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment
                    .start, // Align the sender's email to the right if it's the current user
            children: [
              Text(
                senderEmail,
                style: TextStyle(
                  color: Color.fromARGB(255, 148, 148, 148),
                  fontSize: 14,
                ),
                textAlign: isCurrentUser
                    ? TextAlign.right
                    : TextAlign.left, // Conditionally set the text alignment
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width *
                    0.6, // Set the width to half of the screen width
                child: Text(
                  message,
                  maxLines: 10, // Set a maximum number of lines
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditMessageDialog(Message initialMessage) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _editMessageController =
            TextEditingController(text: initialMessage.message);

        return AlertDialog(
          title: Text('Edit Message'),
          content: TextField(
            controller: _editMessageController,
            decoration: InputDecoration(hintText: 'Enter edited message...'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String editedMessage = _editMessageController.text;
                // Call the method to edit the message with the new text
                _groupService.editMessage(widget.group.groupId,
                    initialMessage.messageId, editedMessage);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showMessageOptions(BuildContext context, DocumentSnapshot document) {
    final message = Message.fromSnapshot(document);
    final isCurrentUserMessage =
        message.senderId == _firebaseAuth.currentUser!.uid;

    // Updated showModalBottomSheet
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isCurrentUserMessage)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showEditMessageDialog(message);
                  },
                  child: Text('Edit Message'),
                ),
              if (isCurrentUserMessage)
                ElevatedButton(
                  onPressed: () {
                    _groupService.deleteMessage(
                        widget.group.groupId, message.messageId);
                    Navigator.pop(context);
                  },
                  child: Text('Delete Message'),
                ),
            ],
          ),
        );
      },
    );
  }
}
