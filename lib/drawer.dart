import 'package:flutter/material.dart';
import 'package:health_app/Features/Google_map.dart';
import 'package:health_app/chat_bot.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 16),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'user@gmail.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.message, color: Colors.deepPurple),
              title:const Text(
                'Ask Gemini',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=> BotScreen(),),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.map, color: Colors.deepPurple),
              title: const Text(
                'Google Map',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MapScreen(),),);
              },
            ),
            ListTile(
              leading: Icon(Icons.policy, color: Colors.deepPurple),
              title: const Text(
                'Policies',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Add functionality for Policies section
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.deepPurple),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Add functionality for Logout
              },
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.deepPurple.shade100,
              height: 30,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: 10),
            ListTile(
              title:const Text(
                'Help & Support',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Add functionality for Help & Support
              },
            ),
          ],
        ),
      ),
    );
  }
}
