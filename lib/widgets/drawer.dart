import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/profile.png",
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Attendance App",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(
              Icons.person,
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(
              Icons.help,
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: const Text('Offline Items'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(
              Icons.offline_bolt,
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(
              Icons.logout,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
