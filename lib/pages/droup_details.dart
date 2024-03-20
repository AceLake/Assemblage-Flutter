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
            // You can display other group details here
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
