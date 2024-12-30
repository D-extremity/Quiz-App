import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/backend/fetchtest.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:shimmer/shimmer.dart';

class UploadedResultPage extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  const UploadedResultPage({
    super.key,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Text("Your Previous Test Results")),
          title: getText(
              s: "Quizzard",
              size: size.height * 0.036,
              color: Colors.blue.shade900,
              fw: FontWeight.w500),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Image.asset("assets/logo.png"),
        ),
        body: resultPage(userDetails, size, context));
  }
}

Widget resultWidgets(
    DocumentSnapshot document, Size size, BuildContext context) {
  Map<String, dynamic> doc = (document.data() as Map<String, dynamic>);
  final double percent =
      (int.parse(doc['marks']) / int.parse(doc['totalQuestions'])) * 100;
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
          leading: CircleAvatar(
            radius: size.width * 0.1,
            backgroundColor: color,
            child: Text("${percent.toString().substring(0, 4)}%"),
          ),
          title: getText(s: doc['testSeriesName'], size: size.height * 0.028),
          subtitle: getText(
              // ignore: prefer_interpolation_to_compose_strings
              s: "${"Score: " + doc['marks']}/" + doc['totalQuestions'],
              size: size.height * 0.02),
        ),
      ),
    ),
  );
}

Widget resultPage(
        Map<String, dynamic> userDetails, Size size, BuildContext context) =>
    StreamBuilder(
      stream: FetchTest(courseOpted: userDetails['courseOpted'])
          .results(userDetails['creduid']),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Some Error Occurred , Please try after some time"));
        }
        if (!snapshot.hasData) {
          return Center(
              child: getText(
                  s: "No Result is available ☹️", size: size.height * 0.012));
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: getText(
                  s: "No Result is available ☹️", size: size.height * 0.012));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Shimmer(
            gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
            child: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, int index) {
                return snapshot.data!.docs
                    .map((document) => InkWell(
                          child: resultWidgets(
                              document, MediaQuery.of(context).size, context),
                        ))
                    .toList()[index];
              });
        }
      },
    );
