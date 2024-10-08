import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/Screens/Intro_Home_Screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroHomeScreen()),
        );
      } else {
        print("Sign-in aborted by user");
      }
    } catch (error) {
      print("Sign-in error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return IntroHomeScreen(); // User is logged in, navigate to the home screen
            } else {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://i.pinimg.com/originals/f0/fc/9b/f0fc9bbd1034c2723392d41c1e062b78.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black54,
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Welcome to Health App',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton.icon(
                          icon: Image.network(
                            'https://static-00.iconduck.com/assets.00/google-icon-2048x2048-pks9lbdv.png',
                            height: 24.0,
                            width: 24.0,
                          ),
                          label: const Text(
                            'Login with Google',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _handleSignIn,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(250, 50),
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
