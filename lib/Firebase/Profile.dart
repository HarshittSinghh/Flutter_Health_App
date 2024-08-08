import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/Firebase/Login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImageUrl;
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
    _fetchUserDetails();
  }

  @override
  void dispose() {
    phoneController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profileImageUrl = user.photoURL;
        setState(() {
          _profileImageUrl = profileImageUrl;
        });
      }
    } catch (e) {
      print("Failed to fetch profile image: $e");
    }
  }

  Future<void> _fetchUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
        final data = userDoc.data();
        if (data != null) {
          phoneController.text = data['mobile'] ?? '';
          genderController.text = data['gender'] ?? '';
          dobController.text = data['dob'] ?? '';
        }
      }
    } catch (e) {
      print("Failed to fetch user details: $e");
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                ),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  try {
                    await FirebaseFirestore.instance.collection('User').doc(user.uid).update({
                      'mobile': phoneController.text,
                      'gender': genderController.text,
                      'dob': dobController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile updated successfully')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update profile: $e')),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title: Text(
            "Health Vista",
            style: GoogleFonts.dancingScript(
                fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You are not logged in.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()), 
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    final photoURL = _profileImageUrl ?? user.photoURL;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          "Health Vista",
          style: GoogleFonts.dancingScript(
              fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.list_outlined, color: Colors.white),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutDialog();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.deepPurple,
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(120),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.black54,
                    child: Ink.image(
                      image: photoURL != null
                          ? NetworkImage(photoURL)
                          : AssetImage('assets/default_profile.png') as ImageProvider,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            Container(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Name:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        user.displayName ?? 'No Name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        user.email ?? 'No Email',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: _editProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'User Details',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('User').doc(user.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.hasError) {
                    return Center(child: Text('Failed to load user details'));
                  }

                  final data = snapshot.data?.data() as Map<String, dynamic>?;

                  return ListView(
                    children: [
                      ListTile(
                        title: Text('Contact Number'),
                        subtitle: Text(data?['mobile'] ?? 'Not available'),
                      ),
                      ListTile(
                        title: Text('Gender'),
                        subtitle: Text(data?['gender'] ?? 'Not available'),
                      ),
                      ListTile(
                        title: Text('Date of Birth'),
                        subtitle: Text(data?['dob'] ?? 'Not available'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
