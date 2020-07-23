import 'package:flutter/material.dart';
import 'package:webtracking/pages/root_page.dart';
import 'package:webtracking/services/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WebTracking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(Auth()));
  }
}
