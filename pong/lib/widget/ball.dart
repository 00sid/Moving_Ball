import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double x;
  final double y;
  const MyBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        height: 20,
        width: 20,
      ),
    );
  }
}
