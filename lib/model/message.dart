import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageId;
  final String senderId;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
  });

  // We need to convert it to a map becouse that is how information is
  // Stored in firebase
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
  // Factory method to create a Message object from a DocumentSnapshot
  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    // Extract data from the snapshot
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String messageId = data['messageId'];
    String senderId = data['senderId'];
    String senderEmail = data['senderEmail'];
    String message = data['message'];
    Timestamp timestamp = data['timestamp'];
    // Extract other properties as needed

    // Return a new Message object
    return Message(
      messageId: messageId,
      senderId: senderId,
      senderEmail: senderEmail,
      message: message,
      timestamp: timestamp,
      // Initialize other properties here
    );
  }
}
