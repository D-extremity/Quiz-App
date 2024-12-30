import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quizscreen/ui/quizscreen_page.dart';
import 'package:quiz_app/utils/font_style.dart';

class PreQuizScreen extends StatelessWidget {
  final String userUid;
  final String userName;
  final DocumentSnapshot doc;
  final List<Map<String, dynamic>> questions;
  const PreQuizScreen({super.key, required this.questions, required this.doc, required this.userUid, required this.userName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
    title: getText(
        s: "Quizzard ",
        size: size.height * 0.036,
        color: Colors.blue.shade900,
        fw: FontWeight.w500),
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading: Image.asset("assets/logo.png"),
          ),
          body: Center(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            testPreview(doc, size, context),
            getText(
                s: "This test contains ${questions.length} Questions\nClick on start to proceed",
                size: size.width * 0.05),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacement(CupertinoPageRoute(
                              builder: (context) => QuizscreenPage(
                                    testName: doc['name'],
                                    questions: questions,
                                    length: questions.length - 1, userName: userName, userUid: userUid,
                                  )));
                    },
                    child: const Text("Start"))
              ],
            )
          ],
        ),
      ),
    ),
          ),
        );
  }
}

Widget testPreview(DocumentSnapshot document, Size size, BuildContext context) {
  Map<String, dynamic> doc = (document.data() as Map<String, dynamic>);
  final Widget img = doc['coverImg'] == ""
      ? Image.asset("assets/test.jpg")
      : Image(image: NetworkImage(doc['coverImg']));
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [img, getText(s: doc['name'], size: size.width * 0.06)],
        ),
      ),
    ),
  );
}
