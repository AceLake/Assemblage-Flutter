import 'package:flutter/material.dart';
import 'package:messaging_app/components/nav_bar.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group Name:'),
            TextFormField(
              // Add logic to handle group name input
            ),
            SizedBox(height: 16),
            Text('Description:'),
            TextFormField(
              // Add logic to handle description input
            ),
            SizedBox(height: 16),
            Text('Location:'),
            TextFormField(
              // Add logic to handle location input
            ),
            SizedBox(height: 16),
            Text('Meeting Time:'),
            TextFormField(
              // Add logic to handle meeting time input
            ),
            SizedBox(height: 16),
            Text('Study Description:'),
            TextFormField(
              // Add logic to handle study description input
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: false, // Add logic to handle checkbox state
                  onChanged: (value) {
                    // Add logic to handle checkbox state change
                  },
                ),
                Text('Public Group'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logic to handle group creation
              },
              child: Text('Create Group'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
