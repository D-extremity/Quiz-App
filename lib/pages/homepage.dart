import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/backend/fetchtest.dart';
import 'package:quiz_app/pages/quizscreen/ui/proceedtotest.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:quiz_app/widget/homepagewidget.dart';
import 'package:quiz_app/widget/profilepagewidget.dart';
import 'package:quiz_app/widget/quizpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.grey,
        ),
        label: "",
        backgroundColor: Color.fromARGB(255, 255, 255, 255)),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.list_alt_outlined,
          color: Colors.grey,
        ),
        label: "",
        backgroundColor: Color.fromARGB(255, 255, 255, 255)),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.stacked_bar_chart_rounded,
          color: Colors.grey,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        label: ""),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        label: ""),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Widget> getScreen = [
  homepageWidget,
  quizScreen,
  const Text("Past Scores"),
  profileWidget
];

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: getText(
          s: "Quiz App",
          size: size.height * 0.014,
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: null,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        // selectedIconTheme: IconThemeData(),
        selectedItemColor: Colors.white,
        items: HomePage.items,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        iconSize: size.height * 0.015,
        elevation: 0,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      // body: getScreen[currentIndex],
      body: StreamBuilder(
        stream: FetchTest().tests(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child:
                    Text("Some Error Occurred , Please try after some time"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, int index) {
                  return snapshot.data!.docs
                      .map((document) =>
                          test(document, MediaQuery.of(context).size, context))
                      .toList()[index];
                });
          }
        },
      ),
    ));
  }
}

Widget test(DocumentSnapshot document, Size size, BuildContext context) {
  Map<String, dynamic> doc = (document.data() as Map<String, dynamic>);
  final Widget img = doc['coverImg'] == ""
      ? Image.asset("assets/test.jpg")
      : Image(image: NetworkImage(doc['coverImg']));
  List<Map<String, dynamic>> questions = (doc['testQuest'] as List<dynamic>).cast<Map<String, dynamic>>();
  return InkWell(
    onTap: () {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => PreQuizScreen(
                questions: questions,
              )));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [img, getText(s: doc['name'], size: size.width * 0.08)],
          ),
        ),
      ),
    ),
  );
}
