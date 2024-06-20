import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quizscreen/ui/quizscreen_page.dart';
import 'package:quiz_app/utils/globals.dart';

Widget getQuizCard() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Code',
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(shape: const LinearBorder()),
          onPressed: () {
            navigatorKey.currentState?.push(
                CupertinoPageRoute(builder: (context) =>  const QuizscreenPage()));
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}