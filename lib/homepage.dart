import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trying_flutter_1/barriers.dart';
import 'bird.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); // constructs the state of the widget and returns it to the framework
}

class _HomePageState extends State<HomePage> {
  //state of the widget is mutable and can be changed over time

  // Bird Physics for jum arc
  static double birdYaxis = 0; 
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;


  // Scores
  int score =0;
  int bestScore = 0;


  bool scoredBarrierOne= false;
  bool scoredBarrierTwo = false;

  // Game state
  bool gameHasStarted = false;

  //Barrier positions
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1;

 // jump function
 // resets upward arc at every jump from birds current position
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

//start game function
// starts the game and moves the bird downwards
  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 70), (timer) {
      //every 70 milliseconds, the timer will call the function
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time; //formula for free fall
      
      setState(() {
        birdYaxis = initialHeight - height; //move bird down
        _moveBarriers(); 
        _checkScore();
      });

      // 
      if (_checkCollision() || birdYaxis > 1) {
        _endGame(timer);
      }
    });
  }


  //Move barriers funciton
  // slides both barrier pairs left 
  void _moveBarriers(){
    if (barrierXone < -2) {
      barrierXone += 3.5;
      scoredBarrierOne = false; //reset score for barrier one
    } 
    else {
      barrierXone -= 0.03;
    }
    

    if (barrierXtwo < -2) {
      barrierXtwo += 3.5;
      scoredBarrierTwo = false; //reset score for barrier two
    } 
    else {
      barrierXtwo -= 0.03;
    }
  }

  //check score function
  // point when barrier passes bird (cross x =-0.1)
  void _checkScore(){
    if (barrierXone < -0.1 && !scoredBarrierOne){
      score++;
      scoredBarrierOne = true; // flag stops awarding multiple points per pass
    }
    if (barrierXtwo < -0.1 && !scoredBarrierTwo){
      score++;
      scoredBarrierTwo = true; 
    }
  }

  //check collision function
  // return true if bird overlaps pipe
  // if barrier close to x=0, check if bird in gap , if not then game over
 bool _checkCollision() {

  // zone barrier is close enough to birb
  const double hitZone = 0.15;

  if (barrierXone.abs() < hitZone) {
    const double gapTop = -0.35;
    const double gapBottom = 0.55;

    if (birdYaxis < gapTop || birdYaxis > gapBottom) {
      return true; // collision with barrier one
    }

    if (barrierXtwo.abs() < hitZone) {
      const double gapTop = -0.25;
      const double gapBottom = 0.55;
    }

    if (birdYaxis < gapTop || birdYaxis > gapBottom) {
        return true; // collision with barrier two
    }
    }

    return false; // no collision

  }
  
 

 //end game function
 void _endGame(Timer timer){
  timer.cancel();
  setState(() {
    if (score > bestScore){
      bestScore = score;
    } 
    gameHasStarted = false;
  });
 }

// UI BUILD
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
                    if (gameHasStarted) {
                      jump();
                    } else {
                      startGame();
                    }
                  },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
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
                    child: MyBarrier(size: 180),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.5),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 180),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 130),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.3),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 230),
                  ),
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
                          "$score",
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
                          "$bestScore",
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
      ),
    );
  }
}
