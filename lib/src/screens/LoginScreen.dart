import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("This is a login screen"),
          RaisedButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
          )
        ]),
      ),
    );
  }
}
