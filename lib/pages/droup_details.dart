import 'package:flutter/material.dart';
import 'package:messaging_app/components/nav_bar.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/services/group/group_service.dart';

class GroupDetailsPage extends StatefulWidget {
  final Group group;

  const GroupDetailsPage({Key? key, required this.group}) : super(key: key);

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  int _currentIndex = 2;
  bool _isCurrentUserMember = false; // Flag to track if current user is a member

  @override
  void initState() {
    super.initState();
    // Check if the current user is a member of the group
    _checkMembership();
  }

  Future<void> _checkMembership() async {
    // Implement logic to check if the current user is a member of the group
    // You can use a method from your GroupService to do this
    // For example:
    bool isMember = await GroupService().isCurrentUserMember(widget.group.groupId);
    setState(() {
      _isCurrentUserMember = isMember;
    });
  }

  void _joinGroup() async {
    // Implement logic to add the current user to the group
    // You can use a method from your GroupService to do this
    // For example:
    await GroupService().addCurrentUserToGroup(widget.group.groupId);
    // Update the flag to reflect the user's membership status
    setState(() {
      _isCurrentUserMember = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Group Name: ${widget.group.groupName}'),
            Text('Description: ${widget.group.groupAbout}'),
            Text('Location: ${widget.group.groupLocation}'),
            Text('Meeting Time: ${widget.group.groupMeet}'),
            Text('Study Description: ${widget.group.groupStudy}'),
            Text('Public: ${widget.group.public}'),
            // Display join group button if the current user is not a member
            if (!_isCurrentUserMember) ...[
              ElevatedButton(
                onPressed: _joinGroup,
                child: Text('Join Group'),
              ),
            ],
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
