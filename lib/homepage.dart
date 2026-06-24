import 'package:flutter/material.dart';
import 'bird.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();   //constructs the state of the widget and returns it to the framework
}

class _HomePageState extends State<HomePage> {  //state of the widget is mutable and can be changed over time
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       children: [
        Expanded(
          flex: 2,
          child: AnimatedContainer(
            alignment: Alignment(0, 0.5),
            duration: Duration(milliseconds: 0),
            color: Colors.blue,
            child: MyBird(),
            ),
          ),
        Expanded(
          child: Container(
            color: Colors.green,
          ),
        ),
       ] 
      )  
    );
  }
}