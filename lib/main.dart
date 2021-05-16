import 'package:flutter/material.dart';
import 'login.dart';
import 'model/user.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quiz Login',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Login()
    );
  }
}
