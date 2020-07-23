import 'package:flutter/material.dart';
import 'package:webtracking/pages/login_signup_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebTracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignupPage()
    );
  }
}

