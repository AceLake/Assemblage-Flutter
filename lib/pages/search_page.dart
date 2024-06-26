import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/components/nav_bar.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/pages/group_details.dart';
import 'package:messaging_app/services/group/group_service.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/components/nav_bar.dart';
import 'package:messaging_app/model/group.dart';
import 'package:messaging_app/services/group/group_service.dart';

class SearchGroupsPage extends StatefulWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  _SearchGroupsPageState createState() => _SearchGroupsPageState();
}

class _SearchGroupsPageState extends State<SearchGroupsPage> {
  int _currentIndex = 1;
  List<Group> _userGroups = [];
  List<Group> _filteredGroups = [];
  final GroupService _groupService = GroupService();

  @override
  void initState() {
    super.initState();
    // Fetch user groups when the page initializes
    _fetchPublicGroups();
  }

  // Function to fetch user groups
  Future<void> _fetchPublicGroups() async {
    try {
      final user = widget._firebaseAuth.currentUser;
      if (user != null) {
        List<Group> userGroups = await _groupService.getPublicGroups();
        setState(() {
          _userGroups = userGroups;
          _filteredGroups = userGroups;
        });
      } else {
        print('User is not authenticated.');
      }
    } catch (e) {
      print('Error fetching user groups: $e');
    }
  }

  // Function to filter groups based on search query
  void _filterGroups(String query) {
    setState(() {
      _filteredGroups = _userGroups.where((group) {
        final nameMatches =
            group.groupName.toLowerCase().contains(query.toLowerCase());
        final locationMatches =
            group.groupLocation.toLowerCase().contains(query.toLowerCase());
        final studyMatches =
            group.groupStudy.toLowerCase().contains(query.toLowerCase());
        // Return true if any of the criteria match
        return nameMatches || locationMatches || studyMatches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Groups'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterGroups,
              decoration: InputDecoration(
                labelText: 'Search Group',
                hintText: 'Enter group name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredGroups.length,
              itemBuilder: (context, index) {
                // Check if it's not the last item to avoid adding Divider after the last item
                if (index < _filteredGroups.length - 1) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the GroupDetailsPage for the corresponding group
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupDetailsPage(
                                  group: _filteredGroups[index]),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(_filteredGroups[index].groupName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location: ${_filteredGroups[index].groupLocation}',
                              ),
                              Text(
                                'Study Description: ${_filteredGroups[index].groupStudy}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.5),
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                } else {
                  // If it's the last item, don't add Divider
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the GroupDetailsPage for the corresponding group
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GroupDetailsPage(group: _filteredGroups[index]),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(_filteredGroups[index].groupName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location: ${_filteredGroups[index].groupLocation}',
                          ),
                          Text(
                            'Study Description: ${_filteredGroups[index].groupStudy}',
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
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
