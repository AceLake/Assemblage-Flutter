import 'package:flutter/material.dart';
import 'package:messaging_app/components/nav_bar.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/pages/droup_details.dart';
import 'package:messaging_app/services/group/group_service.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  int _currentIndex = 2;
  final GroupService _groupService = GroupService();
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _meetingTimeController = TextEditingController();
  final TextEditingController _studyDescriptionController = TextEditingController();
  bool _isPublic = false; // State for checkbox

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
              controller: _groupNameController,
            ),
            SizedBox(height: 16),
            Text('Description:'),
            TextFormField(
              controller: _descriptionController,
            ),
            SizedBox(height: 16),
            Text('Location:'),
            TextFormField(
              controller: _locationController,
            ),
            SizedBox(height: 16),
            Text('Meeting Time:'),
            TextFormField(
              controller: _meetingTimeController,
            ),
            SizedBox(height: 16),
            Text('Study Description:'),
            TextFormField(
              controller: _studyDescriptionController,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value ?? false;
                    });
                  },
                ),
                Text('Public Group'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Create a Group object with user inputs
                Group newGroup = Group(
                  groupId: '', // You may need to generate a unique ID here
                  leaderEmail: '', // Set accordingly based on your requirements
                  leaderId: '', // Set accordingly based on your requirements
                  groupName: _groupNameController.text,
                  groupAbout: _descriptionController.text,
                  groupLocation: _locationController.text,
                  groupMeet: _meetingTimeController.text,
                  groupStudy: _studyDescriptionController.text,
                  public: _isPublic,
                  members: [], // You may need to handle members appropriately
                );

                // Get the receiverId from your logic (you need to set it according to your app's requirements)
                String receiverId = '';

                // Call the createGroup method from your GroupService
                await _groupService.createGroup(receiverId, newGroup);

                // Navigate to the Group Details Page and pass the created group
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupDetailsPage(group: newGroup),
                  ),
                );

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
