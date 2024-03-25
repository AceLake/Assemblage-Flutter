// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:messaging_app/components/nav_bar.dart';
// import 'package:messaging_app/pages/chat_page.dart';
// import 'package:messaging_app/services/auth/auth_service.dart';
// import 'package:provider/provider.dart';

// class FindGroupPage extends StatefulWidget {
//   const FindGroupPage({Key? key}) : super(key: key);

//   @override
//   State<FindGroupPage> createState() => except();
// }

// class except extends State<FindGroupPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   int _currentIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     // Function to sign out the user
//     void signOut() {
//       // Get the auth service using Provider
//       final authService = Provider.of<AuthService>(context, listen: false);

//       // Call the signOut method from the AuthService
//       authService.signOut();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         actions: [
//           IconButton(
//             onPressed: signOut,
//             icon: const Icon(Icons.logout),
//           )
//         ],
//       ),
//       // Add additional widgets and content for the home page as needed
//       body: _buildUserList(),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }

//   //build a list of users except the currently logged in users
//   Widget _buildUserList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('users').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('error');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('Loading...');
//         }
//         return ListView(
//           children: snapshot.data!.docs
//               .map<Widget>((doc) => _buildUserListItem(doc))
//               .toList(),
//         );
//       },
//     );
//   }

//   Widget _buildUserListItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

//     // display all users exept for the current logged in user
//     if (_auth.currentUser!.email != data['email']) {
//       return ListTile(
//         title: Text(data['email']),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatPage(
//                 receiverUserEmail: data['email'],
//                 receiverUserID: data['uid'],
//               ),
//             ),
//           );
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
// }
