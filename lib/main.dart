import 'package:flutter/material.dart';
import "./Home.dart";

// https://qurani-api.herokuapp.com/api/reciters

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF2A5592),
      ),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
