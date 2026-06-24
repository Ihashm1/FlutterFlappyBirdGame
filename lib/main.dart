import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {  //immutable 

  @override //method from parent class
  Widget build(BuildContext context) {     //re-render UI using widget thats returned 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
