import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/utils/font_style.dart';

class ResultPage extends StatefulWidget {
  final int result;
  final int totalQ;
  const ResultPage({super.key, required this.result, required this.totalQ});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double percent = (widget.result / widget.totalQ) * 100;
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
            s: "Quizzard",
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
                s: "Your Score is ${widget.result}/${widget.totalQ}",
                size: size.height * 0.02,
                color: Colors.blue),
            SizedBox(
              height: size.height * 0.04,
            ),
            scoreCard(widget.result, widget.totalQ, message, size, context),
            SizedBox(
              height: size.height * 0.04,
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Return"))
          ],
        ),
      ),
    );
  }
}

Widget scoreCard(int result, int totalQuestion, String remark, Size size,
    BuildContext context) {
  final double percent = (result / totalQuestion) * 100;
  Color color = percent > 80
      ? Colors.green
      : percent > 60
          ? Colors.yellow
          : Colors.red;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          horizontalTitleGap: 2,
          leading: CircleAvatar(
            radius: size.width * 0.1,
            backgroundColor: color,
            child: Text("${percent.toString().substring(0, 4)}%"),
          ),
          title: getText(s: remark, size: size.height * 0.008),
          subtitle: getText(
              // ignore: prefer_interpolation_to_compose_strings
              s: "Score : " +
                  result.toString() +
                  "/" +
                  totalQuestion.toString(),
              size: size.height * 0.006),
        ),
      ),
    ),
  );
}
