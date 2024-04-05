import 'package:flutter/material.dart';
import 'package:messaging_app/model/group.dart';

class EditGroupPage extends StatefulWidget {
  final Group group;

  const EditGroupPage({Key? key, required this.group}) : super(key: key);

  @override
  State<EditGroupPage> createState() => _EditGroupPageState();
}

class _EditGroupPageState extends State<EditGroupPage> {
  late TextEditingController _groupNameController;
  late TextEditingController _groupAboutController;
  late TextEditingController _groupLocationController;
  late TextEditingController _groupMeetController;
  late TextEditingController _groupStudyController;
  late TextEditingController _publicController;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController(text: widget.group.groupName);
    _groupAboutController = TextEditingController(text: widget.group.groupAbout);
    _groupLocationController = TextEditingController(text: widget.group.groupLocation);
    _groupMeetController = TextEditingController(text: widget.group.groupMeet);
    _groupStudyController = TextEditingController(text: widget.group.groupStudy);
    _publicController = TextEditingController(text: widget.group.public.toString());
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupAboutController.dispose();
    _groupLocationController.dispose();
    _groupMeetController.dispose();
    _groupStudyController.dispose();
    _publicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _groupNameController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            TextFormField(
              controller: _groupAboutController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _groupLocationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              controller: _groupMeetController,
              decoration: InputDecoration(labelText: 'Meeting Time'),
            ),
            TextFormField(
              controller: _groupStudyController,
              decoration: InputDecoration(labelText: 'Study Description'),
            ),
            TextFormField(
              controller: _publicController,
              decoration: InputDecoration(labelText: 'Public'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to save changes
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
