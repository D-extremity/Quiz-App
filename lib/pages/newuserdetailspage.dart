// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/backend/phone_auth.dart';
import 'package:quiz_app/bloc/bloc/auth_bloc_bloc.dart';
import 'package:quiz_app/utils/font_style.dart';

class NewUserDetailPage extends StatefulWidget {
  final String name;
  final String phoneNumber;
  const NewUserDetailPage(
      {super.key, required this.name, required this.phoneNumber});

  @override
  State<NewUserDetailPage> createState() => _NewUserDetailPageState();
}

class _NewUserDetailPageState extends State<NewUserDetailPage> {
  String _gender = "Male";
  String _courseOpted = "State Exams";
  int _year = 2005;
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
    print(course.keys.toList());
    Size sizee = MediaQuery.of(context).size;
    final List<int> years =
        List<int>.generate(60, (int index) => 1990 + index, growable: true);
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) => AuthBlocBloc(),
            child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
              listenWhen: (previous, current) => true,
              listener: (context, state) {
                if (state is AuthBlocAgeBelow15State) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Age should be greater than 15 years")));
                }
              },
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: sizee.height * 0.06,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Lottie.asset(
                            "assets/hamster.json",
                            height: size.height * 0.046,
                          )),
                      getText(
                          s: "Waiting for you to complete profile",
                          size: size.height * 0.006),
                      SizedBox(
                        height: sizee.height * 0.01,
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Padding(
                          padding: EdgeInsets.all(sizee.height * 0.03),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                getText(
                                    s: "Born Year", size: sizee.height * 0.02),
                                DropdownButton<int>(
                                  hint: getText(
                                      s: "Born Year",
                                      size: sizee.height * 0.02),
                                  value: _year,
                                  items: years.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text("$item"),
                                    );
                                  }).toList(),
                                  onChanged: (int? value) {
                                    setState(() {
                                      _year = value ?? _year;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller:
                                      TextEditingController(text: "$_year"),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.01,
                                ),
                                DropdownButton(
                                  hint: getText(
                                      s: "Gender", size: sizee.height * 0.02),
                                  value: _gender,
                                  items: <String>[
                                    "Male",
                                    "Female",
                                    "Others",
                                    "Not want to reveal"
                                  ].map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _gender = value ?? _gender;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller:
                                      TextEditingController(text: _gender),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.01,
                                ),
                                DropdownButton(
                                  hint: getText(
                                      s: "Preparing for ?",
                                      size: sizee.height * 0.02),
                                  value: _courseOpted,
                                  items:
                                      course.keys.toList().map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _courseOpted = value ?? _courseOpted;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller:
                                      TextEditingController(text: _courseOpted),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.022,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const LinearBorder(),
                                          backgroundColor: Colors.black,
                                          minimumSize: Size(sizee.width * 0.8,
                                              sizee.height * 0.06)),
                                      onPressed: () async {
                                        if (DateTime.now().year - _year < 12) {
                                          context
                                              .read<AuthBlocBloc>()
                                              .add(AuthBlocAgeBelow15Event());
                                        }
                                        if (_courseOpted.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Preparaing for field is empty"),
                                            backgroundColor: Colors.orange,
                                            duration: Duration(seconds: 2),
                                          ));
                                          return;
                                        } else {
                                          await Authorization(context,
                                                  name: widget.name,
                                                  phoneNumber:
                                                      widget.phoneNumber,
                                                  bornYear: _year,
                                                  gender: _gender,
                                                  courseOpted:
                                                      course[_courseOpted])
                                              .signUpwithPhoneNumber();
                                        }
                                      },
                                      child: const Text(
                                        "Sign up",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.015,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
