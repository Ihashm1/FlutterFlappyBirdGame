import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trying_flutter_1/barriers.dart';
import 'bird.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState(); //constructs the state of the widget and returns it to the framework
}

class _HomePageState extends State<HomePage> {
  //state of the widget is mutable and can be changed over time

  static double birdYaxis = 0; //bird position on y axis
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  double barrierXtwo = 1;
  double barrierXone = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      
      //every 500 milliseconds, the timer will call the function
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time; //formula for free fall
      setState(() {
        birdYaxis = initialHeight - height; //move bird down
        barrierXone -= 0.02;
        barrierXtwo -= 0.02;
      });

      if (birdYaxis > 1) {
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
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (gameHasStarted) {
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
                Container(
                  alignment: Alignment(0, -0.3),
                  child: gameHasStarted 
                  ? Text("")
                  : Text(
                    "T A P  T O  P L A Y",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXone, 1.1),
                  duration: Duration(milliseconds: 0),
                child: MyBarrier(
                  size: 180,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXone, -1.5),
                  duration: Duration(milliseconds: 0),
                child: MyBarrier(
                  size: 180,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo, 1.1),
                  duration: Duration(milliseconds: 0),
                child: MyBarrier(
                  size: 130,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXtwo, -1.3),
                  duration: Duration(milliseconds: 0),
                child: MyBarrier(
                  size: 230,
                  ),
                )
   
              ],
            ),
          ),
          Container(height: 15, color: Colors.green),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SCORE",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BEST",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "10",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
