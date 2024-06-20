import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/utils/font_style.dart';

class ResultPage extends StatelessWidget {
  final int result;
  final Size size;
  const ResultPage({super.key, required this.result, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Lottie.asset("assets/hamster.json"),
            getText(
                s: "Your Score is $result",
                size: size.height * 0.02,
                color: Colors.blue)
          ],
        ),
      ),
    );
    
  }
}
