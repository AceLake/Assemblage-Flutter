// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/components/chat_bubble.dart';
import 'package:messaging_app/components/my_text_field.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/model/message.dart';
import 'package:messaging_app/pages/droup_details.dart';
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

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _groupService.sendMessage(
        widget.group.groupId,
        _firebaseAuth.currentUser!.uid, // Send the sender's ID
        _firebaseAuth.currentUser!.email!, // Send the sender's email
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
            padding: EdgeInsets.only(
                right: 16.0), // Adjust the right padding as needed
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _scaffoldKey.currentState
                    ?.openEndDrawer(); // Open the end drawer
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        // Use endDrawer instead of drawer
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
                  SizedBox(width: 10), // Add space between text and icon
                  Icon(Icons.info_outline,
                      color: Colors.blue), // Group details icon
                ],
              ),
              onTap: () {
                // Add your logic to navigate to the group details page
                // Navigate to a new page when a group is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GroupDetailsPage(group: widget.group)
                  ),
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
                  SizedBox(width: 10), // Add space between text and icon
                  Icon(Icons.logout, color: Colors.red), // Logout icon
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 30), // Adding space below the chat input
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
          reverse: true, // Start from the bottom
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

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
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  senderEmail,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context, DocumentSnapshot document) {
    final message = Message.fromSnapshot(document);
    final isCurrentUserMessage =
        message.senderId == _firebaseAuth.currentUser!.uid;

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
                    //_groupService.EditMessage(message);
                    Navigator.pop(context); // Close modal
                  },
                  child: Text('Edit Message'),
                ),
              if (isCurrentUserMessage)
                ElevatedButton(
                  onPressed: () {
                    _groupService.deleteMessage(
                        widget.group.groupId, message.messageId);
                    Navigator.pop(context); // Close modal
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
