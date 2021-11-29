import 'package:firebase_authentication/providers/auth_provider.dart';
import 'package:firebase_authentication/screens/authscreens/login.dart';
import 'package:firebase_authentication/screens/authscreens/reset.dart';
import 'package:firebase_authentication/screens/home.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: 'password'),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      AuthClass()
                          .createAccount(
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                      )
                          .then((res) {
                        if (res == 'Account created') {
                          setState(() {
                            loading = false;
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false,
                          );
                        } else {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(res)));
                        }
                      });
                    },
                    child: Text('Create Account'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
    );
  }
}
