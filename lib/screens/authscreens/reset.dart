import 'package:firebase_authentication/providers/auth_provider.dart';
import 'package:firebase_authentication/screens/authscreens/login.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController _emailController = new TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset'),
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
                  // ignore: deprecated_member_use
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      AuthClass()
                          .resetPassword(
                        email: _emailController.text.trim(),
                      )
                          .then((res) {
                        if (res == 'Email sent') {
                          setState(() {
                            loading = false;
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
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
                    child: Text('Reset Your Account'),
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
