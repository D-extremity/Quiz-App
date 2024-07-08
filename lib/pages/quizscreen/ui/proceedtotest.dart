import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quizscreen/ui/quizscreen_page.dart';

class PreQuizScreen extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  const PreQuizScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                    "This test contains ${questions.length} Questions\nClick on start to proceed"),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      QuizscreenPage(questions: questions,length: questions.length-1,)));
                        },
                        child: const Text("Start"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
