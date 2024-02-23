import 'package:flutter/material.dart';
import 'package:messaging_app/pages/create_group_page.dart';
import 'package:messaging_app/pages/find_page.dart';
import 'package:messaging_app/pages/landing_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.add),
          label: 'Create Group',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        // Add more BottomNavigationBarItems as needed
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        // Handle navigation based on the tapped index
        switch (index) {
          case 0:
            // Navigate to the Search page and remove previous routes
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
            break;
          case 1:
            // Navigate to the Search page and remove previous routes
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FindGroupPage()),
            );
            break;
          case 2:
            // Navigate to the Search page and remove previous routes
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CreateGroupPage()),
            );
          case 3:
            // Navigate to the Chat page
            break;
          // Add more cases as needed
        }
        onTap(index);
      },
    );
  }
}
