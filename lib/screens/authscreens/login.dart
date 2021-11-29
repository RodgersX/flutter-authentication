import 'package:firebase_authentication/providers/auth_provider.dart';
import 'package:firebase_authentication/screens/authscreens/register.dart';
import 'package:firebase_authentication/screens/authscreens/reset.dart';
import 'package:firebase_authentication/screens/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      AuthClass()
                          .signIn(
                        email: _emailController.text.trim(),
                        password: _passController.text.trim(),
                      )
                          .then((res) {
                        if (res == 'welcome') {
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
                    child: Text('Log in'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text('Don\'t have an account? Register'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPage()),
                      );
                    },
                    child: Text('Forgot password? Reset'),
                  ),
                ],
              ),
            ),
    );
  }
}
