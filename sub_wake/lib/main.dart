import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SubWakeApp());
}

class SubWakeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sub_wake',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
