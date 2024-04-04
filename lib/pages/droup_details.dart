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
  bool _isCurrentUserMember =
      false; // Flag to track if current user is a member
  bool _isGroupLeader = false; // Flag to track if current user is group leader

  @override
  void initState() {
    super.initState();
    // Check if the current user is a member of the group
    _checkMembership();
    // Check if the current user is the group leader
    _checkGroupLeadership();
  }

  Future<void> _checkMembership() async {
    // Implement logic to check if the current user is a member of the group
    // You can use a method from your GroupService to do this
    // For example:
    bool isMember =
        await GroupService().isCurrentUserMember(widget.group.groupId);
    setState(() {
      _isCurrentUserMember = isMember;
    });
  }

  Future<void> _checkGroupLeadership() async {
    // Implement logic to check if the current user is the group leader
    // You can use a method from your GroupService to do this
    // For example:
    bool isLeader =
        await GroupService().isCurrentUserGroupLeader(widget.group.groupId);
    setState(() {
      _isGroupLeader = isLeader;
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

  void _removeUserFromGroup(String userIdToRemove) async {
    // Implement logic to remove user from the group
    // You can use a method from your GroupService to do this
    // For example:
    await GroupService()
        .removeUserFromGroup(widget.group.groupId, userIdToRemove);
    // You may also want to update UI or state accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Details'),
        leading: IconButton(
            icon: Icon(
              Icons.navigate_before_rounded,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
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
            // Display remove user button if the current user is the group leader
            if (_isGroupLeader) ...[
              ElevatedButton(
                onPressed: () {
                  // Implement logic to remove a user
                  // For now, let's just print a message
                  print('Remove user button pressed');
                },
                child: Text('Remove User'),
              ),
            ],
            // List all members within the group
            Text('Group Members:'),
            FutureBuilder<List<String>>(
              future: GroupService().getGroupMembers(widget.group.groupId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while fetching members
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display error message if fetching fails
                } else {
                  return Column(
                    children: snapshot.data!.map((userId) {
                      return ListTile(
                        title: Text(userId),
                        // Display remove button if the current user is the group leader
                        trailing: _isGroupLeader
                            ? IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () {
                                  _removeUserFromGroup(userId);
                                },
                              )
                            : null,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
