import 'package:flutter/material.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:quiz_app/widget/joinquizcard.dart';





Widget quizScreen = Padding(
  padding: const EdgeInsets.all(8),
  child: Column(
    children: [
      SizedBox(
        height: size.height * 0.004,
      ),
      getQuizCard(),
      Expanded(
        child: ListView(children: [
          for (int i = 0; i < 10; i++) ...[
            Container(
              height: size.height*0.08,
              width: size.width*0.50,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            )
          ]
        ]),
      )
    ],
  ),
);
