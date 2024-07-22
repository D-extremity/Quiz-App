import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/utils/font_style.dart';

class ResultPage extends StatelessWidget {
  final int result;
  final int totalQ;
  const ResultPage({super.key, required this.result, required this.totalQ});

  @override
  Widget build(BuildContext context) {
    final double percent = (result / totalQ) * 100;
    String message = percent > 90
        ? "You are under top achievers"
        : percent > 80
            ? "You really did well"
            : percent > 60
                ? "You can do better, All the best"
                : "Please focus, your result is so poor";
    return Scaffold(
      appBar: AppBar(
        title: getText(
            s: "Rahein Education",
            size: size.height * 0.018,
            color: Colors.blue.shade900,
            fw: FontWeight.w500),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Image.asset("assets/logo.png"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.1,
                child: Lottie.asset("assets/hamster.json")),
            getText(
                s: "Your Score is $result/$totalQ",
                size: size.height * 0.02,
                color: Colors.blue),
            getText(s: message, size: size.height * 0.01, color: Colors.blue),
            SizedBox(height: size.height*0.04,),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Return"))
          ],
        ),
      ),
    );
  }
}
