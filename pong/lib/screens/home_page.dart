import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong/screens/cover_screen.dart';
import 'package:pong/widget/ball.dart';
import 'package:pong/widget/brick.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  double playerX = 0;
  //ball variable
  double ballX = 0;
  double ballY = 0;
  var ballDirection = direction.DOWN;

  bool gameHasStarted = false;
  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        //update direction
        updateDirection();
        //moveball
        moveBall();
      });
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9) {
        ballDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = direction.DOWN;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      playerX -= 0.1;
    });
    print(playerX.toString());
  }

  void moveRight() {
    setState(() {
      playerX += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Stack(
            children: [
              //tap to play
              GestureDetector(
                  onTap: startGame,
                  child: CoverScreen(gameHasStarted: gameHasStarted)),
              //top brick
              MyBrick(x: playerX, y: -.9),

              //bottom brick
              MyBrick(x: playerX, y: 0.9),
              //ball
              MyBall(x: ballX, y: ballY),
            ],
          ),
        ),
      ),
    );
  }
}
