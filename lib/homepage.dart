import 'dart:async';

import 'package:flutter/material.dart';
import 'bird.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();   //constructs the state of the widget and returns it to the framework
}

class _HomePageState extends State<HomePage> {  //state of the widget is mutable and can be changed over time
  
  static double birdYaxis = 0; //bird position on y axis
  double time = 0;
  double height = 0;
  double initialHeight= birdYaxis;
  bool gameHasStarted = false;


  void jump(){
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
    
  }

  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) { //every 500 milliseconds, the timer will call the function
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time; //formula for free fall
      setState(() {
        birdYaxis = initialHeight - height; //move bird down
      });

      if (birdYaxis > 1){
      timer.cancel(); //stop the timer if bird is below the screen
      gameHasStarted = false;
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: (){
              if (gameHasStarted){
                jump();
              } else {
                startGame();
              }
            },
            child: AnimatedContainer(
              alignment: Alignment(0, birdYaxis),
              duration: Duration(milliseconds: 0),
              color: Colors.blue,
              child: MyBird(),
              ),
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