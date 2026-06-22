import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  @override //method from parent class
  Widget build(BuildContext context) {     //re-render UI using widget thats returned 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
