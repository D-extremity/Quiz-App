import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/backend/fetchtest.dart';
import 'package:quiz_app/pages/quizscreen/ui/proceedtotest.dart';
import 'package:quiz_app/pages/solution_screen/video_solution.dart';
import 'package:quiz_app/pages/user_setting_page.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:quiz_app/widget/homepagewidget.dart';
import 'package:quiz_app/widget/notes_widget.dart';
import 'package:quiz_app/widget/profilepagewidget.dart';
import 'package:quiz_app/widget/quizpage.dart';
import 'package:shimmer/shimmer.dart';

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
          Icons.key_sharp,
          color: Colors.grey,
        ),
        label: "",
        backgroundColor: Color.fromARGB(255, 255, 255, 255)),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.menu_book,
          color: Colors.grey,
        ),
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
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

List<Widget> getScreen = [homepageWidget, quizScreen, profileWidget];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // print("UID OF USER : "+FirebaseAuth.instance.currentUser!.uid);
    super.initState();
    getDetails();
  }

  late Map<String, dynamic> userDetails;
  getDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .get();
    setState(() {
      userDetails = (snap.data() as Map<String, dynamic>);
    });
    screen = quizListScreenWidget(userDetails);
  }

  int currentIndex = 0;
  Widget screen = Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
          child: Column(
        children: [
          for (int i = 0; i < 4; i++)
            const Card(
              child: SizedBox(
                height: 200,
                width: 200,
              ),
            ),
        ],
      )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getText(
            s: "Quizzard",
            size: size.height * 0.016,
            color: Colors.blue.shade900,
            fw: FontWeight.w500),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Image.asset("assets/logo.png"),
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
            if (currentIndex == 0) {
              screen = quizListScreenWidget(userDetails);
            }
            if (currentIndex == 1) {
              screen = solutionScreen(userDetails);
            }
            if (currentIndex == 2) {
              screen = notesPage(userDetails, size, context);
            }
            if (currentIndex == 3) {
              screen = UserSettingPage(size: size, userDetails: userDetails);
            }
          });
        },
      ),
      body: screen,
    );
  }
}

Widget test(DocumentSnapshot document, Size size, BuildContext context,
    String userName, String userUid) {
  Map<String, dynamic> doc = (document.data() as Map<String, dynamic>);
  final Widget img = doc['coverImg'] == ""
      ? Image.asset("assets/test.jpg")
      : Image(image: NetworkImage(doc['coverImg']));
  List<Map<String, dynamic>> questions =
      (doc['testQuest'] as List<dynamic>).cast<Map<String, dynamic>>();
  return InkWell(
    onTap: () {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => PreQuizScreen(
                doc: document,
                questions: questions,
                userUid: userUid,
                userName: userName,
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

Widget quizListScreenWidget(Map<String, dynamic> userDetails) => StreamBuilder(
      stream: FetchTest(courseOpted: userDetails['courseOpted']).tests(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Some Error Occurred , Please try after some time"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Shimmer(
              gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
              child: Center(
                child: Text("Loading..."),
              ),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: getText(
                  s: "No Test Series is available currently",
                  size: size.height * 0.012));
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, int index) {
                return snapshot.data!.docs
                    .map((document) => test(
                        document,
                        MediaQuery.of(context).size,
                        context,
                        userDetails['name'],
                        userDetails['creduid']))
                    .toList()[index];
              });
        }
      },
    );

Widget solutionScreen(Map<String, dynamic> userDetails) => StreamBuilder(
      stream: FetchTest(courseOpted: userDetails['courseOpted']).solutions(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Some Error Occurred , Please try after some time"));
        }
        if (!snapshot.hasData) {
          return Center(
              child: getText(
                  s: "No Solution is available currently",
                  size: size.height * 0.012));
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: getText(
                  s: "No Solution is available currently",
                  size: size.height * 0.012));
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
                    .map((document) => solutionWidgets(
                        document, MediaQuery.of(context).size, context))
                    .toList()[index];
              });
        }
      },
    );

Widget solutionWidgets(DocumentSnapshot doc, Size size, BuildContext context) {
  Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => VideoSolutionPage(solution: data)));
        },
        child: Container(
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image(image: NetworkImage(data['image'])),
                getText(s: data['name'], size: size.width * 0.08)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget notesPage(
        Map<String, dynamic> userDetails, Size size, BuildContext context) =>
    StreamBuilder(
      stream: FetchTest(courseOpted: userDetails['courseOpted']).notes(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Some Error Occurred , Please try after some time"));
        }
        if (!snapshot.hasData) {
          return Center(
              child: getText(
                  s: "No Note is available currently",
                  size: size.height * 0.012));
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: getText(
                  s: "No Note is available currently",
                  size: size.height * 0.012));
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
                          child: notesWidgets(
                              document, MediaQuery.of(context).size, context),
                        ))
                    .toList()[index];
              });
        }
      },
    );
