import 'package:example_app/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iClimb',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
