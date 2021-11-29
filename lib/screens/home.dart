import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/providers/auth_provider.dart';
import 'package:firebase_authentication/screens/authscreens/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // sign out user
              AuthClass().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text('Email: $email'),
      ),
    );
  }
}
