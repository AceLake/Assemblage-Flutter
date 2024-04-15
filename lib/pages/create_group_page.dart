import 'package:flutter/material.dart';
import 'package:messaging_app/components/nav_bar.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/pages/group_details.dart';
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
  final TextEditingController _studyDescriptionController =
      TextEditingController();
  bool _isPublic = false;
  final _formKey = GlobalKey<FormState>(); // Form key for input validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _groupNameController,
                  decoration: InputDecoration(labelText: 'Group Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _meetingTimeController,
                  decoration: InputDecoration(labelText: 'Meeting Time'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a meeting time';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _studyDescriptionController,
                  decoration: InputDecoration(labelText: 'Study Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a study description';
                    }
                    return null;
                  },
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
                    if (_formKey.currentState!.validate()) {
                      Group newGroup = Group(
                        groupId: '',
                        leaderEmail: '',
                        leaderId: '',
                        groupName: _groupNameController.text,
                        groupAbout: _descriptionController.text,
                        groupLocation: _locationController.text,
                        groupMeet: _meetingTimeController.text,
                        groupStudy: _studyDescriptionController.text,
                        public: _isPublic,
                        members: [],
                        messages: [],
                      );

                      // Get the receiverId from your logic
                      String receiverId = '';

                      try {
                        // Call the createGroup method from your GroupService
                        await _groupService.createGroup(receiverId, newGroup);

                        // Navigate to the Group Details Page and pass the created group
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupDetailsPage(group: newGroup),
                          ),
                        );
                      } catch (e) {
                        // Handle errors
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to create group: $e'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Text('Create Group'),
                ),
              ],
            ),
          ),
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
