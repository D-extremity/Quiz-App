import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/backend/userprofile.dart';
import 'package:quiz_app/pages/homepage.dart';
import 'package:quiz_app/pages/result_page.dart';
import 'package:quiz_app/pages/signup_phone_no_auth.dart';
import 'package:quiz_app/utils/font_style.dart';

class UserSettingPage extends StatefulWidget {
  final Map<String, dynamic> userDetails;
  final Size size;
  const UserSettingPage(
      {super.key, required this.userDetails, required this.size});

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  String _courseOpted = "State Exams";
  Map<String, String> course = {
    "Government Job Exams": 'govt',
    "State Exams": 'state',
    "AE & JE Exams": 'ae',
    "Gate & ESE": 'gate',
    "UG & PG Entrance Exam": 'ug',
    "School(K-12)": 'school',
    "Crack CA": 'crack',
    "BFSI": 'bfsi',
    "SKill Development": 'skill',
    "Nursing": 'nurse'
  };
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: getText(
              s: "${widget.userDetails['name']}",
              size: size.height * 0.02,
              color: const Color.fromARGB(255, 50, 49, 49)),
          subtitle: Text("${widget.userDetails['number']}"),
          leading: Icon(
            Icons.person,
            size: size.height * 0.032,
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  UploadedResultPage(userDetails: widget.userDetails))),
          title: Text("Results"),
          leading: Icon(Icons.bar_chart),
        ),
        const Divider(),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.border_color),
          title: Text("Change Course"),
          subtitle: DropdownButton(
            hint: getText(s: "Preparing for ?", size: size.height * 0.02),
            value: _courseOpted,
            items: course.keys.toList().map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? value) async {
              _courseOpted = value ?? _courseOpted;
              bool isUpdated = await updateCourse(
                 course[_courseOpted]!, widget.userDetails['number']);
              setState(() {});
              if (isUpdated) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              }
            },
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => const PhoneSignInPage()));
          },
          leading: const Icon(Icons.logout_outlined),
          title: const Text("Logout"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("About"),
        ),
      ],
    );
  }
}
