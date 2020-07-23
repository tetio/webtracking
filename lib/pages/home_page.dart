import 'package:flutter/material.dart';
import 'package:webtracking/services/authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({this.username, this.auth, this.logoutCallback});
  final String username;
  final Auth auth;
  final Function logoutCallback;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Ncha!'),
    );
  }
}
