import 'package:flutter/material.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/pages/group_list.dart';
import 'package:messaging_app/services/group/group_service.dart';

class EditGroupPage extends StatefulWidget {
  final Group group;

  const EditGroupPage({Key? key, required this.group}) : super(key: key);

  @override
  State<EditGroupPage> createState() => _EditGroupPageState();
}

class _EditGroupPageState extends State<EditGroupPage> {
  late bool _isPublic;
  late TextEditingController _groupNameController;
  late TextEditingController _groupAboutController;
  late TextEditingController _groupLocationController;
  late TextEditingController _groupMeetController;
  late TextEditingController _groupStudyController;
  late TextEditingController _publicController;
  final GroupService _groupService = GroupService();

  @override
  void initState() {
    super.initState();
    _isPublic = widget.group.public;
    _groupNameController = TextEditingController(text: widget.group.groupName);
    _groupAboutController =
        TextEditingController(text: widget.group.groupAbout);
    _groupLocationController =
        TextEditingController(text: widget.group.groupLocation);
    _groupMeetController = TextEditingController(text: widget.group.groupMeet);
    _groupStudyController =
        TextEditingController(text: widget.group.groupStudy);
    _publicController =
        TextEditingController(text: widget.group.public.toString());
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

  void _editGroup() {
    // Get updated values from text controllers
    String updatedGroupName = _groupNameController.text;
    String updatedGroupAbout = _groupAboutController.text;
    String updatedGroupLocation = _groupLocationController.text;
    String updatedGroupMeet = _groupMeetController.text;
    String updatedGroupStudy = _groupStudyController.text;
    bool updatedPublic = _isPublic;

    // Create a new Group object with updated values
    Group updatedGroup = Group(
      groupId: widget.group.groupId,
      groupName: updatedGroupName,
      groupAbout: updatedGroupAbout,
      groupLocation: updatedGroupLocation,
      groupMeet: updatedGroupMeet,
      groupStudy: updatedGroupStudy,
      public: updatedPublic,
      leaderEmail: widget.group.leaderEmail,
      leaderId: widget.group.leaderId,
      members: widget.group.members,
      messages: widget.group.messages,
    );

    // Call the editGroup method from GroupService
    _groupService.editGroup(updatedGroup);
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
            CheckboxListTile(
              title: Text('Public'),
              value: _isPublic,
              onChanged: (bool? value) {
                setState(() {
                  _isPublic = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _editGroup();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyGroupsPage()),
                );
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
